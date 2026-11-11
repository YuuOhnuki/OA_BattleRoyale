#!/usr/bin/env python3
"""OA Battle Royale 1.9.97 map update.

Reads the v1.9.96 tile functions (oa:map/internal/tiles/place|water), applies the 1.9.97 map changes to a voxel
model, and writes patch commands back into the tile functions.  Usage:
    python3 build_map_1_9_97.py <pack_dir>        (edits the pack in place, idempotent only on a v1.9.96 pack)
Changes
  * plaza dome frame (8 vertical piers, copper-patina gridshell, open oculus), 22+ blocks above the floor
  * wind-swept rock patches replace the straight 17-block-pitch packed-ice lines in the northern snow field
  * meadow/forest-edge flora, sea-floor seagrass/kelp, gravel patches on the sea floor
Coordinates: x,z relative to the map centre, y relative to the selected top plane; tile functions use ~x ~y ~z.
"""
import re, sys, math, json, random
from pathlib import Path
import numpy as np

LOW, TOPY = -20, 30
NY = TOPY - LOW + 1
X0 = Z0 = -152
W = 305
GROUND = -11
DOME_MAX_Y = 29            # highest block of the dome frame
CLEAR_TOP = 30             # air clear above y=0 for tiles that contain frame blocks

rx = re.compile(r'^fill (~-?\d+) (~-?\d+) (~-?\d+) (~-?\d+) (~-?\d+) (~-?\d+) (\S+)\s*$')
def rel(t): return int(t[1:] or 0)

class Grid:
    def __init__(self):
        self.pal = ['minecraft:air']; self.pid = {'minecraft:air': 0}
        self.V = np.zeros((NY, W, W), dtype=np.int16)
    def P(self, b):
        if b not in self.pid:
            self.pid[b] = len(self.pal); self.pal.append(b)
        return self.pid[b]
    def get(self, x, y, z):
        if not (-152 <= x <= 152 and -152 <= z <= 152 and LOW <= y <= TOPY): return 'minecraft:air'
        return self.pal[self.V[y - LOW, z - Z0, x - X0]]
    def set(self, x, y, z, b):
        assert -152 <= x <= 152 and -152 <= z <= 152 and LOW <= y <= TOPY, (x, y, z)
        self.V[y - LOW, z - Z0, x - X0] = self.P(b)
    def copy(self):
        g = Grid(); g.pal = list(self.pal); g.pid = dict(self.pid); g.V = self.V.copy(); return g

def replay(root, grid=None, kinds=('place', 'water')):
    g = grid or Grid()
    for kind in kinds:
        for i in range(100):
            f = Path(root) / f'data/oa/function/map/internal/tiles/{kind}/{i}.mcfunction'
            for l in f.read_text().splitlines():
                if not l.startswith('fill ~'): continue
                m = rx.match(l)
                assert m, (kind, i, l)
                x0, y0, z0, x1, y1, z1 = [rel(m.group(k)) for k in range(1, 7)]
                p = g.P(m.group(7))
                g.V[min(y0, y1) - LOW:max(y0, y1) - LOW + 1, min(z0, z1) - Z0:max(z0, z1) - Z0 + 1, min(x0, x1) - X0:max(x0, x1) - X0 + 1] = p
    return g

def tile_boxes(root):
    boxes = {}
    for i in range(100):
        t = (Path(root) / f'data/oa/function/map/internal/tiles/place/{i}.mcfunction').read_text().splitlines()
        for l in t:
            m = rx.match(l)
            if m and m.group(7) == 'minecraft:bedrock' and rel(m.group(2)) == -20:
                x0, z0, x1, z1 = rel(m.group(1)), rel(m.group(3)), rel(m.group(4)), rel(m.group(6))
                boxes[i] = (x0, z0, x1, z1); break
        assert i in boxes, i
    return boxes

def protected_points(root):
    pts = []
    rp = re.compile(r'positioned ~(-?\d+) ~(-?\d+) ~(-?\d+) if block ~ ~ ~ minecraft:(chest|coal_ore|redstone_ore|deepslate_redstone_ore|deepslate_coal_ore)')
    for i in range(100):
        for l in (Path(root) / f'data/oa/function/map/internal/tiles/apply/{i}.mcfunction').read_text().splitlines():
            m = rp.search(l)
            if m: pts.append((int(m.group(1)), int(m.group(2)), int(m.group(3)), m.group(4)))
    return sorted(set(pts))

# ----------------------------------------------------------------------------------------------- noise
def value_noise(seed, scale, shape=(W, W)):
    rng = np.random.default_rng(seed)
    gh = int(W / scale) + 3
    lat = rng.random((gh, gh))
    ys, xs = np.mgrid[0:shape[0], 0:shape[1]]
    fy, fx = ys / scale, xs / scale
    iy, ix = fy.astype(int), fx.astype(int)
    ty, tx = fy - iy, fx - ix
    sy, sx = ty * ty * (3 - 2 * ty), tx * tx * (3 - 2 * tx)
    a = lat[iy, ix] * (1 - sx) + lat[iy, ix + 1] * sx
    b = lat[iy + 1, ix] * (1 - sx) + lat[iy + 1, ix + 1] * sx
    return a * (1 - sy) + b * sy
def fbm(seed, scale):
    return 0.6 * value_noise(seed, scale) + 0.3 * value_noise(seed + 1, scale / 2.1) + 0.1 * value_noise(seed + 2, scale / 4.3)

# ----------------------------------------------------------------------------------------------- dome
R_BASE, R_MID, R_TOP = 25.0, 17.0, 9.0
K_BASE, K_TOP, K_CENTER = 22, 39, None
K0 = GROUND + 1                      # y of layer k=0
def Yk(k): return K0 + k
def sphere_k(r):
    kc = ((R_TOP ** 2 + K_TOP ** 2) - (R_BASE ** 2 + K_BASE ** 2)) / (2 * (K_TOP - K_BASE))
    return kc + math.sqrt(max(0.0, R_BASE ** 2 + (K_BASE - kc) ** 2 - r * r))
CU = ['minecraft:waxed_cut_copper', 'minecraft:waxed_exposed_cut_copper', 'minecraft:waxed_weathered_cut_copper', 'minecraft:waxed_oxidized_cut_copper']
LANT, BLK, CHI = 'minecraft:sea_lantern', 'minecraft:polished_blackstone', 'minecraft:waxed_chiseled_copper'
def tone(k):
    return CU[0] if k <= 27 else CU[1] if k <= 32 else CU[2] if k <= 36 else CU[3]
def line3(a, b):
    (x0, y0, z0), (x1, y1, z1) = a, b
    n = int(max(abs(x1 - x0), abs(y1 - y0), abs(z1 - z0)) * 2) + 1
    seen, res = set(), []
    for i in range(n + 1):
        t = i / n
        p = (round(x0 + (x1 - x0) * t), round(y0 + (y1 - y0) * t), round(z0 + (z1 - z0) * t))
        if p not in seen: seen.add(p); res.append(p)
    return res
def pol(r, deg, k=None):
    a = math.radians(deg)
    return (r * math.cos(a), sphere_k(r) if k is None else k, r * math.sin(a))
PYLON_ANGLES = [18.0 + 45 * j for j in range(8)]   # rotated off the bridge approach and the four road gates

def build_dome():
    B = {}                                   # (x, y, z) -> block
    def put_k(x, k, z, b, over=False):
        key = (x, Yk(k), z)
        if over or key not in B: B[key] = b
    pylons = []
    for a in PYLON_ANGLES:
        cx, cz = R_BASE * math.cos(math.radians(a)), R_BASE * math.sin(math.radians(a))
        x0, z0 = round(cx - 0.5), round(cz - 0.5)
        pylons.append((a, x0, z0))
        for dx in (0, 1):
            for dz in (0, 1):
                for k in range(0, K_BASE):
                    b = BLK if k < 2 else CHI if k >= K_BASE - 2 else CU[0]
                    put_k(x0 + dx, k, z0 + dz, b, over=True)
        inner = min(((dx, dz) for dx in (0, 1) for dz in (0, 1)), key=lambda d: (x0 + d[0]) ** 2 + (z0 + d[1]) ** 2)
        for k in (6, 11, 16): put_k(x0 + inner[0], k, z0 + inner[1], LANT, over=True)
    kb, km, kt = K_BASE, round(sphere_k(R_MID)), K_TOP
    def ring(r, k):
        for i in range(720):
            a = math.radians(360 * i / 720)
            put_k(round(r * math.cos(a)), k, round(r * math.sin(a)), tone(k))
    ring(R_BASE, kb); ring(R_MID, km); ring(R_TOP, kt)
    major = list(PYLON_ANGLES); minor = [a + 22.5 for a in PYLON_ANGLES]
    def meridian(deg, r_from, r_to):
        n = int(abs(r_from - r_to) * 4) + 1
        for i in range(n + 1):
            r = r_from + (r_to - r_from) * i / n
            a = math.radians(deg)
            k = round(sphere_k(r)); put_k(round(r * math.cos(a)), k, round(r * math.sin(a)), tone(k))
    for a in major: meridian(a, R_BASE, R_TOP)
    nodes = []
    for a0 in major:        # pinwheel bracing: every diagonal turns the same way
        for (x, k, z) in line3(pol(R_BASE, a0, kb), pol(R_MID, a0 + 22.5, km)): put_k(x, k, z, tone(k))
        p0, p1 = pol(R_MID, a0, km), pol(R_TOP, a0 + 45, kt)
        for (x, k, z) in line3(p0, p1): put_k(x, k, z, tone(k))
        nodes.append((round((p0[0] + p1[0]) / 2), round((p0[1] + p1[1]) / 2), round((p0[2] + p1[2]) / 2)))
    for a, x0, z0 in pylons:
        r = math.radians(a); put_k(round(R_BASE * math.cos(r)), kb, round(R_BASE * math.sin(r)), LANT, over=True)
    for a in major:
        r = math.radians(a)
        put_k(round(R_MID * math.cos(r)), km, round(R_MID * math.sin(r)), LANT, over=True)
        put_k(round(R_TOP * math.cos(r)), kt, round(R_TOP * math.sin(r)), LANT, over=True)
    for (x, k, z) in nodes: put_k(x, k, z, LANT, over=True)
    return B, pylons

def apply_dome(g):
    B, pylons = build_dome()
    allowed_old = lambda b: b == 'minecraft:air' or 'slab' in b or b in ('minecraft:short_grass', 'minecraft:poppy', 'minecraft:dandelion', 'minecraft:azure_bluet')
    for (x, y, z), b in B.items():
        old = g.get(x, y, z)
        assert allowed_old(old), ('dome would overwrite', (x, y, z), old)
        g.set(x, y, z, b)
    # flush foot plates around the piers (floor level only, no height)
    plate = 0
    for a, x0, z0 in pylons:
        for dx in range(-2, 4):
            for dz in range(-2, 4):
                x, z = x0 + dx, z0 + dz
                border = dx in (-2, 3) or dz in (-2, 3)
                old = g.get(x, GROUND, z)
                if old in ('minecraft:air',) or 'water' in old: continue
                g.set(x, GROUND, z, BLK if border else CU[0]); plate += 1
    return {'dome_blocks': len(B), 'pylons': len(pylons), 'foot_plate_cells': plate}

# ----------------------------------------------------------------------------------------------- snow
def apply_snow(g):
    """Remove the straight packed-ice lines (x+z = const every 17 blocks) and add wind-swept rock patches instead.
    Rock patches use stone/gravel, which stay valid for registered spawn points (#oa:spawn_ground) and ground item drops."""
    sno = g.P('minecraft:snow_block'); ice = g.P('minecraft:packed_ice')
    stone = g.P('minecraft:stone'); gravel = g.P('minecraft:gravel')
    V = g.V
    ys, zs, xs = np.where(V == ice)
    for y, z, x in zip(ys, zs, xs): V[y, z, x] = sno
    removed = len(ys)
    n = fbm(9101, 11.0); n2 = value_noise(9111, 3.0)
    made = 0
    snow_cols = np.where((V == sno).any(axis=0))
    for z, x in zip(*snow_cols):
        col = V[:, z, x]; yy = np.where(col > 0)[0].max()
        if col[yy] == sno and n[z, x] > 0.70:
            V[yy, z, x] = gravel if n2[z, x] > 0.72 else stone; made += 1
    return {'ice_line_cells_removed': int(removed), 'rock_patch_cells': made}

# ----------------------------------------------------------------------------------------------- flora
FLOWERS = ['minecraft:cornflower', 'minecraft:oxeye_daisy', 'minecraft:allium', 'minecraft:red_tulip', 'minecraft:orange_tulip',
           'minecraft:white_tulip', 'minecraft:pink_tulip', 'minecraft:lily_of_the_valley', 'minecraft:poppy', 'minecraft:dandelion', 'minecraft:azure_bluet']
PLANTS = {'minecraft:short_grass', 'minecraft:fern', 'minecraft:poppy', 'minecraft:dandelion', 'minecraft:azure_bluet'}
def is_plant(b): return b.split('[')[0].split(':')[1] in {p.split(':')[1] for p in PLANTS | set(FLOWERS)} or 'tall_grass' in b or 'seagrass' in b or 'kelp' in b

def apply_flora(g, prot, seed=1997):
    rng = random.Random(seed)
    V, pal = g.V, g.pal
    n_zone = fbm(7001, 18.0); n_type = value_noise(7010, 9.0); n_det = fbm(7020, 5.0)
    prot_xz = np.zeros((W, W), dtype=bool)
    for (px, py, pz, b) in prot:
        for dx in range(-3, 4):
            for dz in range(-3, 4):
                if -152 <= px + dx <= 152 and -152 <= pz + dz <= 152: prot_xz[pz + dz - Z0, px + dx - X0] = True
    pads = [(int(x) - 152, int(z) - 152) for y, z, x in np.argwhere(V == g.P('minecraft:stone_pressure_plate[powered=false]'))]
    for (px, pz) in pads:
        for dx in range(-4, 5):
            for dz in range(-4, 5): prot_xz[pz + dz - Z0, px + dx - X0] = True
    grass = g.P('minecraft:grass_block')
    solid_air = (V == 0)
    count = {}
    def cell_top(x, z):
        col = V[:, z - Z0, x - X0]; idx = np.nonzero(col)[0]
        return int(idx.max()) + LOW if len(idx) else None
    placed = []
    for z in range(-148, 149):
        for x in range(-148, 149):
            if prot_xz[z - Z0, x - X0]: continue
            if math.hypot(x, z) < 29.5: continue        # leave the plaza and its approaches untouched
            col = V[:, z - Z0, x - X0]
            yt = cell_top(x, z)
            if yt is None or yt >= 0: continue
            if col[yt - LOW] != grass: continue
            # clear air above (3 high) and calm neighbourhood (no buildings/trees)
            if not (V[yt + 1 - LOW:yt + 6 - LOW, z - Z0, x - X0] == 0).all(): continue
            ok = True
            for dx in (-1, 0, 1):
                for dz in (-1, 0, 1):
                    if (dx or dz):
                        nb = V[yt + 1 - LOW:yt + 3 - LOW, z + dz - Z0, x + dx - X0]
                        for v in nb:
                            if v and not is_plant(pal[v]): ok = False
            if not ok: continue
            zone, t, d = n_zone[z - Z0, x - X0], n_type[z - Z0, x - X0], n_det[z - Z0, x - X0]
            r = rng.random()
            blk = None
            if zone > 0.60:                      # flower meadow
                if r < 0.24:
                    blk = FLOWERS[int(t * 6.99) % 7] if d > 0.45 else FLOWERS[(int(t * 6.99) + 3) % 7]
                elif r < 0.30: blk = 'minecraft:short_grass'
                elif r < 0.33: blk = 'tall'
            elif zone < 0.34:                    # fern & grass clearings
                if r < 0.08: blk = 'minecraft:fern'
                elif r < 0.17: blk = 'minecraft:short_grass'
                elif r < 0.19: blk = 'tall'
            else:
                if r < 0.04: blk = 'minecraft:short_grass'
                elif r < 0.05: blk = 'tall'
            if blk is None: continue
            if blk == 'tall':
                if not (V[yt + 1 - LOW:yt + 3 - LOW, z - Z0, x - X0] == 0).all(): continue
                g.set(x, yt + 1, z, 'minecraft:tall_grass[half=lower]'); g.set(x, yt + 2, z, 'minecraft:tall_grass[half=upper]')
                count['tall_grass'] = count.get('tall_grass', 0) + 1
            else:
                g.set(x, yt + 1, z, blk); count[blk.split(':')[1]] = count.get(blk.split(':')[1], 0) + 1
    return {'flora': count, 'flora_total': sum(count.values())}

# ----------------------------------------------------------------------------------------------- sea
def apply_sea(g, seed=2026):
    rng = random.Random(seed)
    V, pal = g.V, g.pal
    water = g.P('minecraft:water'); sand = g.P('minecraft:sand')
    n_gv = fbm(8001, 14.0); n_sg = fbm(8010, 10.0); n_kp = fbm(8020, 16.0)
    count = {'gravel_patch': 0, 'seagrass': 0, 'tall_seagrass': 0, 'kelp_columns': 0}
    gravel = 'minecraft:gravel'
    for z in range(-146, 147):
        for x in range(-146, 147):
            col = V[:, z - Z0, x - X0]
            wy = np.nonzero(col == water)[0]
            if len(wy) != 5: continue
            yb = int(wy.min()) + LOW; fl = col[yb - 1 - LOW]
            if fl != sand: continue
            if yb != -18: continue
            # quiet neighbourhood: only water/air around within 2 cells for y in -18..-12 (keeps piers, hulls, ladders clear)
            ok = True
            for dx in range(-2, 3):
                for dz in range(-2, 3):
                    seg = V[yb - LOW:yb + 7 - LOW, z + dz - Z0, x + dx - X0]
                    if any(v and v != water for v in seg): ok = False
                    below = V[yb - 1 - LOW, z + dz - Z0, x + dx - X0]
                    if below == 0: ok = False
            if not ok: continue
            if n_gv[z - Z0, x - X0] > 0.66:
                g.set(x, yb - 1, z, gravel); count['gravel_patch'] += 1
            r = rng.random(); sg, kp = n_sg[z - Z0, x - X0], n_kp[z - Z0, x - X0]
            if kp > 0.64 and r < 0.30:
                h = rng.choice([2, 3, 3, 4])
                for i in range(h - 1): g.set(x, yb + i, z, 'minecraft:kelp_plant')
                g.set(x, yb + h - 1, z, 'minecraft:kelp[age=25]'); count['kelp_columns'] += 1
            elif sg > 0.56 and r < 0.38:
                if rng.random() < 0.35:
                    g.set(x, yb, z, 'minecraft:tall_seagrass[half=lower]'); g.set(x, yb + 1, z, 'minecraft:tall_seagrass[half=upper]'); count['tall_seagrass'] += 1
                else:
                    g.set(x, yb, z, 'minecraft:seagrass'); count['seagrass'] += 1
            elif r < 0.012:
                g.set(x, yb, z, 'minecraft:seagrass'); count['seagrass'] += 1
    return count

# ----------------------------------------------------------------------------------------------- emit
AQUATIC = ('seagrass', 'kelp')
def is_water_pass(newb, oldb):
    return 'water' in oldb or any(a in newb for a in AQUATIC)
def runs_to_boxes(cells):
    """cells: {(x,y,z): block} -> list of (x0,y0,z0,x1,y1,z1,block): row runs along x merged along z."""
    rows = {}
    for (x, y, z), b in cells.items(): rows.setdefault((y, z, b), []).append(x)
    segs = []
    for (y, z, b), xs in rows.items():
        xs.sort(); s = e = xs[0]
        for x in xs[1:]:
            if x == e + 1: e = x
            else: segs.append((y, b, s, e, z)); s = e = x
        segs.append((y, b, s, e, z))
    segs.sort()
    out = []; cur = None
    by = {}
    for y, b, s, e, z in segs: by.setdefault((y, b, s, e), []).append(z)
    for (y, b, s, e), zs in sorted(by.items()):
        zs.sort(); a = p = zs[0]
        for z in zs[1:]:
            if z == p + 1: p = z
            else: out.append((s, y, a, e, y, p, b)); a = p = z
        out.append((s, y, a, e, y, p, b))
    return out

def emit(root, old, new, boxes, label='1.9.97'):
    changed = np.argwhere(old.V != new.V)
    per_tile = {i: {'place': {}, 'water': {}} for i in boxes}
    def tile_of(x, z):
        for i, (bx0, bz0, bx1, bz1) in boxes.items():
            if bx0 <= x <= bx1 and bz0 <= z <= bz1: return i
        raise AssertionError((x, z))
    tops = {}
    for yi, zi, xi in changed:
        x, y, z = int(xi) + X0, int(yi) + LOW, int(zi) + Z0
        ob, nb = old.pal[old.V[yi, zi, xi]], new.pal[new.V[yi, zi, xi]]
        t = tile_of(x, z)
        kind = 'water' if is_water_pass(nb, ob) else 'place'
        per_tile[t][kind][(x, y, z)] = nb
        if y > 0: tops[t] = max(tops.get(t, 0), y)
    stats = {'tiles_touched': 0, 'patch_lines': 0, 'cells_changed': int(len(changed)), 'tiles_with_upper_clear': sorted(tops)}
    for i, (bx0, bz0, bx1, bz1) in boxes.items():
        for kind in ('place', 'water'):
            cells = per_tile[i][kind]
            if not cells and not (kind == 'place' and i in tops): continue
            path = Path(root) / f'data/oa/function/map/internal/tiles/{kind}/{i}.mcfunction'
            lines = path.read_text().splitlines()
            patch = [f'# {label} map update patches'] + [f'fill ~{a} ~{b} ~{c} ~{d} ~{e} ~{f} {blk}' for a, b, c, d, e, f, blk in runs_to_boxes(cells)] if cells else []
            if kind == 'place':
                # insert upper clear after the first air clear, and patches before the first fillbiome
                if i in tops:
                    k = next(j for j, l in enumerate(lines) if l.startswith('fill ~') and l.endswith(' minecraft:air'))
                    assert f'~{CLEAR_TOP}' not in lines[k]
                    up = f'fill ~{bx0} ~1 ~{bz0} ~{bx1} ~{CLEAR_TOP} ~{bz1} minecraft:air'
                    assert (bx1 - bx0 + 1) * (bz1 - bz0 + 1) * CLEAR_TOP <= 32768
                    lines.insert(k + 1, up)
                j = next((j for j, l in enumerate(lines) if l.startswith('fillbiome ')), len(lines))
                lines[j:j] = patch
            else:
                if lines and lines[0].startswith('# No water'): lines = []
                lines += patch
            path.write_text('\n'.join(lines) + '\n')
            stats['patch_lines'] += len(patch)
        if per_tile[i]['place'] or per_tile[i]['water'] or i in tops: stats['tiles_touched'] += 1
    # delete: clear the frame volume above the old top plane too
    for i in tops:
        bx0, bz0, bx1, bz1 = boxes[i]
        p = Path(root) / f'data/oa/function/map/internal/delete/apply/{i}.mcfunction'
        L = p.read_text().splitlines()
        k = next(j for j, l in enumerate(L) if l.startswith('fill ~') and l.endswith(' minecraft:air'))
        L.insert(k + 1, f'fill ~{bx0} ~1 ~{bz0} ~{bx1} ~{CLEAR_TOP} ~{bz1} minecraft:air')
        p.write_text('\n'.join(L) + '\n')
    return stats

def main(root):
    root = Path(root)
    old = replay(root)
    boxes = tile_boxes(root)
    prot = protected_points(root)
    new = old.copy()
    report = {'protected_points': len(prot)}
    report['dome'] = apply_dome(new)
    report['snow'] = apply_snow(new)
    report['flora'] = apply_flora(new, prot)
    report['sea'] = apply_sea(new)
    # protected cells must be unchanged
    for (px, py, pz, b) in prot:
        assert old.get(px, py, pz) == new.get(px, py, pz) and old.get(px, py, pz).split('[')[0] == 'minecraft:' + b, (px, py, pz, b)
    report['emit'] = emit(root, old, new, boxes)
    # dump the target voxel model for the validator
    np.savez_compressed(root / 'source' / 'map_1_9_97_target.npz', V=new.V, pal=np.array(new.pal), low=LOW)
    print(json.dumps(report, ensure_ascii=False, indent=1, default=int))

if __name__ == '__main__':
    main(sys.argv[1])
