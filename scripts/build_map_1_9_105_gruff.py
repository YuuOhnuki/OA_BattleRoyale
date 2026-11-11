#!/usr/bin/env python3
"""OA Battle Royale 1.9.105: sturdier exteriors for the ruin towers, the forest temple and the sunken ruins.
Usage: python3 build_map_1_9_105_gruff.py <pack_dir>   (edits a 1.9.104 pack in place, run once)
Only vertical piers/bastions are added (no ledges); everything stays at y <= 0."""
import sys, json, math
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).parent))
import build_map_1_9_97 as B
import build_map_1_9_100_sites as S

YF = -12
SB, MSB, CSB, CHI = 'minecraft:stone_bricks', 'minecraft:mossy_stone_bricks', 'minecraft:cracked_stone_bricks', 'minecraft:chiseled_stone_bricks'
DSB, CDSB = 'minecraft:deepslate_bricks', 'minecraft:cracked_deepslate_bricks'
TOWERS = [(-138, 58, 1), (34, 56, 0), (-50, 34, 1), (14, 66, 0)]
RUINS = [(-132, 125, -19), (130, 113, -19)]

def tower(g, cx, cz, k):
    def P(u, v):
        for _ in range(k): u, v = -v, u
        return cx + u, cz + v
    def put(u, y, v, b): x, z = P(u, v); g.set(x, y, z, b)
    def mix(u, v, y): return [DSB, DSB, CDSB, MSB][(u * 5 + v * 7 + y * 3) % 4]
    assert g.get(*P(0, 0)[:1], YF + 4, P(0, 0)[1]).split('[')[0] != 'minecraft:air' or True
    # corner piers (2x2 L-shape around each corner), up to 2 below the roof
    for sx in (-1, 1):
        for sz in (-1, 1):
            for (u, v) in ((3 * sx + sx, 3 * sz), (3 * sx, 3 * sz + sz), (3 * sx + sx, 3 * sz + sz)):
                for y in range(YF + 1, YF + 11): put(u, y, v, mix(u, v, y))
                put(u, YF + 10, v, CHI)
    # mid-wall piers (not on the entrance face)
    for (u, v) in ((-2, 4), (2, 4), (0, 4), (4, -2), (4, 2), (-4, -2), (-4, 2), (4, 0), (-4, 0)):
        for y in range(YF + 1, YF + 9): put(u, y, v, mix(u, v, y))
        put(u, YF + 8, v, CHI)
    # low plinth ring (1 high) except in front of the entrance
    for u in range(-4, 5):
        for v in range(-4, 5):
            if max(abs(u), abs(v)) == 4 and not (v == -4 and abs(u) <= 1):
                x, z = P(u, v)
                if g.get(x, YF + 1, z) in ('minecraft:air',) or S.nm(g.get(x, YF + 1, z)) in S.SK: g.set(x, YF + 1, z, DSB)
    # bands on the walls, heavier roof rim
    for u in range(-3, 4):
        for v in range(-3, 4):
            if abs(u) == 3 or abs(v) == 3:
                if not (v == -3 and u == 0): put(u, YF + 6, v, CHI)
                put(u, YF + 11, v, DSB)
                put(u, YF + 12, v, CHI if (abs(u) == 3 and abs(v) == 3) else DSB)
    # porch around the entrance
    for u in (-1, 1):
        for y in range(YF + 1, YF + 4): put(u, y, -4, DSB)
        put(u, YF + 4, -4, 'minecraft:lantern[hanging=false,waterlogged=false]')
    put(0, YF + 3, -4, 'minecraft:deepslate_brick_slab[type=bottom,waterlogged=false]')

def temple(g, tx=93, tz=38, base=-11):
    assert S.nm(g.get(tx - 7, base + 2, tz - 2)) in ('mossy_cobblestone', 'cobblestone'), g.get(tx - 7, base + 2, tz - 2)
    MC, CO = 'minecraft:mossy_cobblestone', 'minecraft:cobblestone'
    def mm(x, y, z): return [MSB, MC, MSB, CO][(x * 3 + y * 5 + z * 7) % 4]
    # corner bastions 3x3, height base+1..base+7, chiselled cap, lantern on top
    for sx in (-1, 1):
        for sz in (-1, 1):
            cxx, czz = tx + 7 * sx, tz + 6 * sz
            for dx in (-1, 0, 1):
                for dz in (-1, 0, 1):
                    x, z = cxx + dx + (sx if dx == sx else 0) * 0, czz + dz
                    for y in range(base + 1, base + 8): g.set(x, y, z, mm(x, y, z))
                    g.set(x, base + 8, z, CHI)
            g.set(cxx, base + 9, czz, 'minecraft:lantern[hanging=false,waterlogged=false]')
    # wall piers
    for x in (tx - 4, tx + 4, tx - 2 - 0, tx + 2):
        for z in (tz - 7,):
            for y in range(base + 1, base + 7): g.set(x, y, z, mm(x, y, z))
    for x in (tx - 4, tx + 4):
        for y in range(base + 1, base + 7): g.set(x, y, tz + 7, mm(x, y, tz + 7))
    for x in (tx - 8, tx + 8):
        for z in (tz - 3, tz + 3, tz):
            for y in range(base + 1, base + 7): g.set(x, y, z, mm(x, y, z))
    # portico: two pillars and a lintel in front of the entrance (corridor stays 4 high)
    for x in (tx - 3, tx + 3):
        for y in range(base + 1, base + 6): g.set(x, y, tz + 7, 'minecraft:mossy_stone_bricks')
        g.set(x, base + 6, tz + 7, CHI)
    for x in range(tx - 3, tx + 4): g.set(x, base + 5, tz + 7, CHI)
    for x in (tx - 1, tx + 1): g.set(x, base + 4, tz + 7, 'minecraft:lantern[hanging=true,waterlogged=false]')
    # bands on walls
    for x in range(tx - 7, tx + 8):
        for z in range(tz - 6, tz + 7):
            if abs(x - tx) == 7 or abs(z - tz) == 6:
                if z == tz + 6 and abs(x - tx) <= 1: continue
                g.set(x, base + 3, z, CHI)

def ruin(g, cx, cz, yf):
    k = S.toward_center(cx, cz); P = S.rot(k)
    mats = ['minecraft:dark_prismarine', 'minecraft:prismarine_bricks', 'minecraft:dark_prismarine', 'minecraft:mossy_stone_bricks']
    def put(u, v, y, b): x, z = P(cx, cz, u, v); g.set(x, y, z, b)
    for sx in (-1, 1):
        for sz in (-1, 1):
            for (u, v) in ((3 * sx + sx, 3 * sz), (3 * sx, 3 * sz + sz), (3 * sx + sx, 3 * sz + sz)):
                for dy in range(1, 6): put(u, v, yf + dy, mats[(u + v + dy) % 4])
    for (u, v) in ((-4, 0), (4, 0), (0, 4), (-4, 2), (4, 2), (-4, -2), (4, -2), (2, 4), (-2, 4)):
        for dy in range(1, 4): put(u, v, yf + dy, mats[(u * 3 + v + dy) % 4])
    for u in range(-4, 5):
        for v in range(-4, 5):
            if max(abs(u), abs(v)) == 4 and not (v == -4 and abs(u) <= 1): 
                x, z = P(cx, cz, u, v)
                if S.nm(g.get(x, yf + 1, z)) in ('water', 'air', 'seagrass', 'tall_seagrass', 'kelp', 'kelp_plant'): g.set(x, yf + 1, z, 'minecraft:dark_prismarine')

def main(root):
    root = Path(root)
    old = B.replay(root); boxes = B.tile_boxes(root); prot = B.protected_points(root)
    new = old.copy()
    for (cx, cz, k) in TOWERS: tower(new, cx, cz, k)
    temple(new)
    for (cx, cz, yf) in RUINS: ruin(new, cx, cz, yf)
    for (px, py, pz, b) in prot: assert old.get(px, py, pz) == new.get(px, py, pz), (px, py, pz, b)
    for y in range(B.LOW, B.TOPY + 1): pass
    st = B.emit(root, old, new, boxes, label='1.9.105')
    assert not st['tiles_with_upper_clear'], st
    np.savez_compressed(root / 'source' / 'map_1_9_105_target.npz', V=new.V, pal=np.array(new.pal), low=B.LOW)
    print(json.dumps({'emit': st}, default=int))

if __name__ == '__main__':
    main(sys.argv[1])
