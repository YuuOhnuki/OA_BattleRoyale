#!/usr/bin/env python3
"""OA Battle Royale 1.9.100: snow caves (north snow field) and sunken ruins (south sea) with rich chests.
Usage: python3 build_map_1_9_100_sites.py <pack_dir>   (edits a 1.9.99 pack in place, run once)
All blocks stay at y <= 0, so the existing delete functions (clear y -20..0) remove them.
"""
import sys, re, json, math
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).parent))
import build_map_1_9_97 as B

SK = {'air', 'short_grass', 'fern', 'poppy', 'dandelion', 'azure_bluet', 'tall_grass', 'snow'}
PLANT = {'seagrass', 'tall_seagrass', 'kelp', 'kelp_plant'}
FACE = ['north', 'east', 'south', 'west']

def nm(b): return b.split('[')[0].split(':')[1]

def surface(g, x, z, water=False):
    for y in range(B.TOPY, B.LOW - 1, -1):
        n = nm(g.get(x, y, z))
        if n in SK or n.endswith('leaves') or n in PLANT: continue
        if n == 'water' and water: continue
        return y, n
    return None, None

def find_flat(g, boxes, prot, wcells, allowed, R, water, region, maxcount, mindist, seed_order, tol=0, maxy=99):
    cand = []
    xs0, xs1, zs0, zs1 = region
    for cz in range(zs0, zs1 + 1, 2):
        for cx in range(xs0, xs1 + 1, 2):
            y0, n0 = surface(g, cx, cz, water)
            if n0 not in allowed: continue
            good = True; ys = []
            for dz in range(-R, R + 1):
                for dx in range(-R, R + 1):
                    y, n = surface(g, cx + dx, cz + dz, water)
                    if y is None or abs(y - y0) > tol or n not in allowed: good = False; break
                    ys.append(y)
                if not good: break
            if not good or max(ys) - min(ys) > tol: continue
            y0 = max(ys)
            if y0 > maxy: continue
            if any(abs(px - cx) <= R + 6 and abs(pz - cz) <= R + 6 for px, py, pz, b in prot): continue
            if any(abs(wx - cx) <= R + 1 and abs(wz - cz) <= R + 1 for (wx, wy, wz) in wcells): continue
            tl = [i for i, (a, b, c, d) in boxes.items() if a <= cx - R and cx + R <= c and b <= cz - R and cz + R <= d]
            if tl: cand.append((cx, cz, tl[0], y0))
    cand.sort(key=seed_order)
    picks = [cand[0]]
    while len(picks) < maxcount:
        picks.append(max(cand, key=lambda c: min(math.hypot(c[0] - p[0], c[1] - p[1]) for p in picks)))
    assert all(math.hypot(a[0] - b[0], a[1] - b[1]) >= mindist for i, a in enumerate(picks) for b in picks[:i]), picks
    return picks

def toward_center(cx, cz):
    """k: 0 entrance north(-z), 1 east(+x), 2 south(+z), 3 west(-x); faces the plaza (map centre)."""
    if abs(cx) >= abs(cz): return 1 if cx < 0 else 3
    return 2 if cz < 0 else 0

def rot(k):
    def P(cx, cz, u, v):
        for _ in range(k): u, v = -v, u
        return cx + u, cz + v
    return P

def find_caves(g, boxes, prot, count=2, mindist=70):
    """Carved caves: a domed room inside high snow terrain plus a rising tunnel to the open slope."""
    cand = []
    dirs = [(0, -1), (1, 0), (0, 1), (-1, 0)]
    for cz in range(-135, -100, 3):
        for cx in range(-135, 136, 3):
            y0, n0 = surface(g, cx, cz, False)
            if n0 != 'snow_block' or y0 < -4: continue
            surf = {}
            ok = True
            for dz in range(-5, 6):
                for dx in range(-5, 6):
                    if dx * dx + dz * dz > 25: continue
                    y, n = surface(g, cx + dx, cz + dz, False)
                    if n != 'snow_block': ok = False; break
                    surf[(dx, dz)] = y
                if not ok: break
            if not ok: continue
            yc = min(surf.values()) - 5
            if yc < -12 or any(g.get(cx + dx, yc - 1, cz + dz) in ('minecraft:air',) for (dx, dz) in surf if dx * dx + dz * dz <= 20): continue
            if any(abs(px - cx) <= 16 and abs(pz - cz) <= 16 for px, py, pz, b in prot): continue
            best = None
            for d in dirs:
                for i in range(1, 36):
                    x, z = cx + d[0] * (4 + i), cz + d[1] * (4 + i); yfl = yc + i // 3
                    if not (-150 <= x <= 150 and -150 <= z <= 150) or yfl + 2 > 0: break
                    ys, ns = surface(g, x, z, False)
                    if ns not in ('snow_block', 'grass_block', 'stone', 'gravel', 'dirt'): break
                    if ys <= yfl + 1: best = (i, d) if (best is None or i < best[0]) else best; break
            if not best: continue
            tl = [t for t, (a, b, c, d2) in boxes.items() if a <= cx - 6 - best[0] - 6 and cx + 6 + best[0] + 6 <= c and b <= cz - 6 - best[0] - 6 and cz + 6 + best[0] + 6 <= d2] if False else None
            cand.append((cx, cz, yc, best[1], best[0]))
    assert cand, 'no cave site'
    cand.sort(key=lambda c: (-c[2], c[0]))
    picks = [cand[0]]
    while len(picks) < count:
        picks.append(max(cand, key=lambda c: min(math.hypot(c[0] - p[0], c[1] - p[1]) for p in picks)))
    assert all(math.hypot(a[0] - b[0], a[1] - b[1]) >= mindist for i, a in enumerate(picks) for b in picks[:i]), picks
    return picks

def build_cave(g, cx, cz, yc, d, n_tunnel):
    u = d                                              # unit vector toward the exit
    for dy in range(0, 4):
        for dz in range(-5, 6):
            for dx in range(-5, 6):
                if math.sqrt(dx * dx + dz * dz + (dy + 0.5) ** 2 * 1.2) <= 4.4: g.set(cx + dx, yc + dy, cz + dz, 'minecraft:air')
    for dz in range(-5, 6):
        for dx in range(-5, 6):
            if dx * dx + dz * dz <= 20: g.set(cx + dx, yc - 1, cz + dz, 'minecraft:snow_block')
    for i in range(1, n_tunnel + 1):
        x, z = cx + u[0] * (3 + i), cz + u[1] * (3 + i); yfl = yc + i // 3
        g.set(x, yfl, z, 'minecraft:snow_block')
        for dy in (1, 2):
            g.set(x, yfl + dy, z, 'minecraft:air')
        for sd in (-1, 1):
            xs, zs = x + u[1] * sd, z + u[0] * sd
            if nm(g.get(xs, yfl + 1, zs)) == 'air' and surface(g, xs, zs, False)[0] < yfl + 1:
                pass
        # reach: also open one more block above at the entrance so the mouth is not too tight
    x, z = cx - u[0] * 3, cz - u[1] * 3
    f = {(0, -1): 'south', (1, 0): 'west', (0, 1): 'north', (-1, 0): 'east'}[u]
    chest = (x, yc, z)
    g.set(*chest, f"minecraft:chest[facing={f},type=single,waterlogged=false]")
    for sd in (-1, 1):
        g.set(cx - u[0] * 3 + u[1] * sd * 2, yc, cz - u[1] * 3 + u[0] * sd * 2, 'minecraft:lantern[hanging=false,waterlogged=false]')
    g.set(cx, yc - 1, cz, 'minecraft:blue_ice')
    for dy in range(1, 3):
        x0, z0 = cx - u[0] * 3, cz - u[1] * 3
        g.set(x0, yc + dy, z0, 'minecraft:air')
    return chest

def build_ruin(g, cx, cz, yf, k):
    P = rot(k)
    def face(f): return FACE[(FACE.index(f) + k) % 4]
    mats = ['minecraft:prismarine_bricks'] * 4 + ['minecraft:dark_prismarine'] * 2 + ['minecraft:cracked_stone_bricks'] * 2 + ['minecraft:mossy_stone_bricks'] * 2
    for u in range(-3, 4):
        for v in range(-3, 4):
            x, z = P(cx, cz, u, v)
            g.set(x, yf, z, 'minecraft:prismarine_bricks')
            if abs(u) == 3 or abs(v) == 3:
                h = 1 + (u * 5 + v * 11 + 7) % 4                         # ragged wall tops, 1..4 high
                if abs(u) == 3 and abs(v) == 3: h = 5
                if v == -3 and abs(u) <= 1: h = 0                         # entrance gap
                for dy in range(1, h + 1):
                    g.set(x, yf + dy, z, 'minecraft:sea_lantern' if (abs(u) == 3 and abs(v) == 3 and dy == 5) else mats[(u * 7 + v * 13 + dy * 3) % len(mats)])
    x, z = P(cx, cz, 0, 1); chest = (x, yf + 1, z)
    g.set(*chest, f"minecraft:chest[facing={face('north')},type=single,waterlogged=true]")
    for u, v in ((-1, 1), (1, 1), (0, 2)):
        x, z = P(cx, cz, u, v); g.set(x, yf + 1, z, 'minecraft:prismarine_bricks')
    return chest

def register_chests(root, chests):
    for (tile, where, x, y, z) in chests:
        if where == 'water':      # chest lives in the water pass: register right after the water function of its tile
            p = root / f'data/oa/function/map/internal/tiles/water_apply/{tile}.mcfunction'
            L = p.read_text().splitlines()
            k = next(j for j, l in enumerate(L) if l == f'function oa:map/internal/tiles/water/{tile}')
            L[k + 1:k + 1] = [f'execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich',
                              f'execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_upgraded']
            p.write_text('\n'.join(L) + '\n'); continue
        p = root / f'data/oa/function/map/internal/tiles/apply/{tile}.mcfunction'
        L = p.read_text().splitlines(); n_old = None
        for j, l in enumerate(L):
            m = re.match(r'scoreboard players set #expectedc oa\.map2 (\d+)$', l)
            if m: n_old = int(m.group(1)); L[j] = f'scoreboard players set #expectedc oa.map2 {n_old + 1}'
        assert n_old is not None
        j2 = next(j for j, l in enumerate(L) if l.startswith('execute unless score #localc oa.map2 matches'))
        reg = f'execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich'
        loot = f'execute if score #mode oa.map2 matches 0 positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_upgraded'
        L[j2:j2] = [reg, loot]
        L = [re.sub(r'(execute unless score #localc oa\.map2 matches )\d+', rf'\g<1>{n_old + 1}', l) for l in L]
        p.write_text('\n'.join(L) + '\n')

def main(root):
    root = Path(root)
    old = B.replay(root); boxes = B.tile_boxes(root); prot = B.protected_points(root)
    gw = B.replay(root, kinds=('water',))
    wcells = {(int(x) + B.X0, int(y) + B.LOW, int(z) + B.Z0) for y, z, x in np.argwhere(gw.V != 0) if gw.pal[gw.V[y, z, x]].split('[')[0] != 'minecraft:water'}
    caves = find_caves(old, boxes, prot)
    ruins = find_flat(old, boxes, prot, wcells, {'sand', 'gravel'}, 4, True, (-140, 140, 85, 140), 2, 60, lambda c: (c[0], c[1]), tol=1)
    new = old.copy(); chests = []
    for (cx, cz, yc, d, nt) in caves:
        ch = build_cave(new, cx, cz, yc, d, nt)
        tile = next(t for t, (a, b, c, d2) in boxes.items() if a <= ch[0] <= c and b <= ch[2] <= d2)
        chests.append((tile, 'apply') + ch)
    for (cx, cz, tile, yf) in ruins: chests.append((tile, 'water') + build_ruin(new, cx, cz, yf, toward_center(cx, cz)))
    for (px, py, pz, b) in prot: assert old.get(px, py, pz) == new.get(px, py, pz), (px, py, pz, b)
    st = B.emit(root, old, new, boxes, label='1.9.100')
    assert not st['tiles_with_upper_clear']
    register_chests(root, chests)
    (root / 'source').mkdir(exist_ok=True)
    np.savez_compressed(root / 'source' / 'map_1_9_100_target.npz', V=new.V, pal=np.array(new.pal), low=B.LOW)
    print(json.dumps({'caves': caves, 'ruins': ruins, 'chests': chests, 'emit': st}, default=int))

if __name__ == '__main__':
    main(sys.argv[1])
