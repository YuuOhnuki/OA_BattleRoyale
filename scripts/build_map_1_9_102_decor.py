#!/usr/bin/env python3
"""OA Battle Royale 1.9.102: conspicuous cave entrances (north snow field) + ship decoration (south-west harbour).
Usage: python3 build_map_1_9_102_decor.py <pack_dir>   (edits a 1.9.101 pack in place, run once)
All new blocks stay at y <= 0 (delete functions clear y -20..0) and only y >= -13 near the sea (outside the water pass)."""
import sys, json, math
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).parent))
import build_map_1_9_97 as B
import build_map_1_9_100_sites as S

CAVES = [dict(cx=27, cz=-120, yc=-6, d=(0, -1), nt=9), dict(cx=-120, cz=-129, yc=-11, d=(-1, 0), nt=8)]
LOGX = 'minecraft:spruce_log[axis=x]'; LOGZ = 'minecraft:spruce_log[axis=z]'; LOGY = 'minecraft:spruce_log[axis=y]'
def isair(b): return S.nm(b) in ('air', 'short_grass', 'tall_grass', 'fern', 'snow', 'poppy', 'dandelion', 'azure_bluet', 'cornflower', 'allium', 'oxeye_daisy')

def widen_cave(g, c):
    cx, cz, yc, d, nt = c['cx'], c['cz'], c['yc'], c['d'], c['nt']
    ux, uz = d; px, pz = uz, ux            # perpendicular (|.|) unit
    placed = []
    def at(i, s): return cx + ux * (3 + i) + px * s, cz + uz * (3 + i) + pz * s
    for i in range(1, nt + 4):
        yfl = yc + i // 3
        w = 1 if i < nt - 2 else 2
        for s in range(-w, w + 1):
            x, z = at(i, s)
            for dy in (1, 2, 3):
                if yfl + dy <= 0: g.set(x, yfl + dy, z, 'minecraft:air')
            if S.nm(g.get(x, yfl - 1, z)) != 'air' or True:
                g.set(x, yfl, z, 'minecraft:packed_ice' if s == 0 else 'minecraft:snow_block')
            if S.nm(g.get(x, yfl - 1, z)) == 'air': g.set(x, yfl - 1, z, 'minecraft:snow_block')
    # gate at the mouth
    im = nt + 3; yfl = yc + im // 3
    for s in (-3, 3):
        x, z = at(im, s)
        top = min(yfl + 4, 0)
        for y in range(yfl, top + 1): g.set(x, y, z, LOGY)
        if top + 1 <= 0: g.set(x, top + 1, z, 'minecraft:lantern[hanging=false,waterlogged=false]')
    for s in (-2, 2):
        x, z = at(im, s); g.set(x, yfl, z, 'minecraft:blue_ice')
    if yfl + 4 <= 0:
        for s in range(-3, 4):
            x, z = at(im, s); g.set(x, yfl + 4, z, LOGX if ux == 0 else LOGZ)
        for s in (-1, 1):
            x, z = at(im, s); g.set(x, yfl + 3, z, 'minecraft:lantern[hanging=true,waterlogged=false]')
    # boardwalk leading to the entrance, following the surface
    for k in range(1, 15):
        i = im + k
        for s in (-1, 0, 1):
            x, z = at(i, s); y, n = S.surface(g, x, z, False)
            if y is None or n in ('stone',): continue
            for yy in range(y + 1, min(y + 4, 1)): g.set(x, yy, z, 'minecraft:air')
            g.set(x, y, z, 'minecraft:spruce_planks')
        if k % 4 == 1:
            for s in (-2, 2):
                x, z = at(i, s); y, n = S.surface(g, x, z, False)
                if y is not None and y + 2 <= 0:
                    g.set(x, y + 1, z, 'minecraft:spruce_fence[north=false,south=false,east=false,west=false,waterlogged=false]')
                    g.set(x, y + 2, z, 'minecraft:lantern[hanging=false,waterlogged=false]')
    # icicles and ice patches inside the room
    rnd = np.random.default_rng(abs(c['cx'] * 31 + c['cz']))
    for _ in range(14):
        a = rnd.uniform(0, 2 * math.pi); r = rnd.uniform(1.5, 3.6)
        x = cx + int(round(math.cos(a) * r)); z = cz + int(round(math.sin(a) * r))
        if abs(x - (cx - ux * 3)) <= 1 and abs(z - (cz - uz * 3)) <= 1: continue
        if S.nm(g.get(x, yc + 3, z)) == 'air' and S.nm(g.get(x, yc + 4, z)) != 'air':
            g.set(x, yc + 3, z, 'minecraft:pointed_dripstone[thickness=tip,vertical_direction=down,waterlogged=false]')
    for _ in range(8):
        a = rnd.uniform(0, 2 * math.pi); r = rnd.uniform(1, 3.5)
        x = cx + int(round(math.cos(a) * r)); z = cz + int(round(math.sin(a) * r))
        if S.nm(g.get(x, yc - 1, z)) in ('snow_block', 'packed_ice') and S.nm(g.get(x, yc, z)) == 'air': g.set(x, yc - 1, z, 'minecraft:blue_ice')

def ship(g):
    CX = -78
    def put(x, y, z, b, force=False):
        cur = g.get(x, y, z)
        assert y >= -13 and y <= 0, (x, y, z)
        if force or isair(cur): g.set(x, y, z, b); return True
        return False
    # hull stripe + portholes (y=-13 ring): replace spruce planks of the outer ring
    cnt = 0
    for z in range(93, 130):
        for x in range(-86, -69):
            if S.nm(g.get(x, -13, z)) == 'spruce_planks':
                nb = any(S.nm(g.get(x + dx, -13, z + dz)) in ('air',) for dx, dz in ((1, 0), (-1, 0), (0, 1), (0, -1)))
                if nb: 
                    g.set(x, -13, z, 'minecraft:glass' if (z % 4 == 0 and abs(x - CX) >= 3 and (x in (-85, -84, -72, -71))) else 'minecraft:dark_oak_planks'); cnt += 1
    # bowsprit with lanterns
    put(CX, -11, 92, 'minecraft:oak_planks'); put(CX, -11, 91, 'minecraft:spruce_planks')
    for z in (92, 91, 90): put(CX, -10, z, LOGZ)
    put(CX, -11, 90, 'minecraft:lantern[hanging=true,waterlogged=false]')
    put(CX, -9, 91, 'minecraft:gold_block'); put(CX, -9, 92, 'minecraft:lantern[hanging=false,waterlogged=false]')
    # fore mast + sail
    for y in range(-10, -2): put(CX, y, 97, LOGY, True)
    for x in range(-81, -74): put(x, -3, 97, LOGX, True)
    for x in range(-80, -75):
        for y in range(-8, -3):
            put(x, y, 96, 'minecraft:red_wool' if y == -6 else 'minecraft:white_wool')
    put(CX, -2, 97, 'minecraft:spruce_fence[north=false,south=false,east=false,west=false,waterlogged=false]')
    for x in (-77, -76, -75): put(x, -2, 97, 'minecraft:red_wool')
    for x in (-81, -75): put(x, -4, 97, 'minecraft:lantern[hanging=true,waterlogged=false]')
    # main mast: bigger flag, hanging lanterns, shroud chains
    for x in range(-77, -72): put(x, 0, 110, 'minecraft:blue_wool', True)
    for x in range(-77, -73): put(x, -1, 110, 'minecraft:white_wool', True)
    for x in (-83, -73):
        for y in range(-3, -9, -1): put(x, y, 110, 'minecraft:iron_chain[axis=y,waterlogged=false]')
        put(x, -9, 110, 'minecraft:lantern[hanging=true,waterlogged=false]')
    # extra emblem on the main sail (blue diamond on white) at z=109
    for (x, y) in ((-78, -7), (-79, -5), (-77, -5), (-78, -4), (-78, -5)):
        if S.nm(g.get(x, y, 109)) == 'white_wool': g.set(x, y, 109, 'minecraft:blue_wool')
    # more rail lanterns
    n = 0
    for z in range(95, 128):
        for x in (-85, -71):
            if S.nm(g.get(x, -10, z)) == 'oak_fence' and isair(g.get(x, -9, z)) and z % 6 == 1:
                near = any(S.nm(g.get(x, -9, z + dz)) == 'lantern' for dz in range(-3, 4))
                if not near: put(x, -9, z, 'minecraft:lantern[hanging=false,waterlogged=false]'); n += 1
    # cargo along the rails (keep the centre lane and hatch free)
    for z in (101, 102, 103):
        put(-84, -10, z, 'minecraft:barrel[facing=up,open=false]'); put(-72, -10, z, 'minecraft:barrel[facing=up,open=false]')
    put(-84, -9, 102, 'minecraft:barrel[facing=up,open=false]'); put(-72, -9, 102, 'minecraft:barrel[facing=up,open=false]')
    for z in (113, 114): put(-84, -10, z, 'minecraft:hay_block[axis=y]'); put(-72, -10, z, 'minecraft:hay_block[axis=y]')
    put(-84, -9, 113, 'minecraft:hay_block[axis=y]')
    # stern roof rail with corner lanterns
    roof = [(x, z) for x in range(-86, -69) for z in range(116, 128) if S.nm(g.get(x, -4, z)) == 'spruce_planks']
    rs = set(roof)
    for (x, z) in roof:
        if any((x + dx, z + dz) not in rs for dx, dz in ((1, 0), (-1, 0), (0, 1), (0, -1))):
            put(x, -3, z, 'minecraft:spruce_fence[north=false,south=false,east=false,west=false,waterlogged=false]')
    if roof:
        xs = [r[0] for r in roof]; zs = [r[1] for r in roof]
        for (x, z) in ((min(xs), min(zs)), (min(xs), max(zs)), (max(xs), min(zs)), (max(xs), max(zs))): put(x, -2, z, 'minecraft:lantern[hanging=false,waterlogged=false]')
    # captain's cabin furnishing (inside x -81..-75, z 118..125, y -10)
    for x in range(-80, -75):
        for z in range(119, 125):
            if isair(g.get(x, -10, z)) and S.nm(g.get(x, -11, z)) == 'oak_planks': g.set(x, -10, z, 'minecraft:red_carpet')
    put(-80, -10, 119, 'minecraft:cartography_table', True); put(-76, -10, 119, 'minecraft:lectern[facing=south,has_book=false,powered=false]', True)
    put(-80, -10, 124, 'minecraft:crafting_table', True)
    put(-78, -7, 121, 'minecraft:lantern[hanging=true,waterlogged=false]'); 
    return cnt, n

def main(root):
    root = Path(root)
    old = B.replay(root); boxes = B.tile_boxes(root); prot = B.protected_points(root)
    new = old.copy()
    for c in CAVES: widen_cave(new, c)
    stats = ship(new)
    for (px, py, pz, b) in prot: assert old.get(px, py, pz) == new.get(px, py, pz), (px, py, pz, b)
    st = B.emit(root, old, new, boxes, label='1.9.102')
    assert not st['tiles_with_upper_clear'], st
    np.savez_compressed(root / 'source' / 'map_1_9_102_target.npz', V=new.V, pal=np.array(new.pal), low=B.LOW)
    print(json.dumps({'ship': stats, 'emit': st}, default=int))

if __name__ == '__main__':
    main(sys.argv[1])
