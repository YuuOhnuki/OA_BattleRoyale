#!/usr/bin/env python3
"""OA Battle Royale 1.9.99: adds ruin towers with rich chests to the southern meadow.
Usage: python3 build_map_1_9_99_towers.py <pack_dir>   (edits the pack in place; run once on a 1.9.98 pack)
Tower (7x7, local frame: entrance on -v side, ladder on +v wall): floor y=YF, walls YF+1..YF+11, mid floor YF+7,
roof YF+12 (= y 0, the old top plane, 12 blocks above the ground so no mobility reaches it from outside).
"""
import sys, re, json, math
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).parent))
import build_map_1_9_97 as B

YF = -12
FL = {'air', 'short_grass', 'fern', 'poppy', 'dandelion', 'azure_bluet', 'tall_grass'}
N_TOWERS = 4

def find_sites(g, boxes, prot, R=5):
    def top_ok(x, z):
        if g.get(x, YF, z) != 'minecraft:grass_block': return False
        return all(g.get(x, y, z).split('[')[0].split(':')[1] in FL for y in range(YF + 1, 1))
    ok = np.array([[top_ok(x, z) for x in range(-152, 153)] for z in range(-152, 153)])
    cand = []
    for cz in range(-140, 141, 2):
        for cx in range(-140, 141, 2):
            if not ok[cz + 152 - R:cz + 152 + R + 1, cx + 152 - R:cx + 152 + R + 1].all(): continue
            if (cx * cx + cz * cz) ** .5 < 55: continue
            if any(abs(px - cx) <= R + 6 and abs(pz - cz) <= R + 6 for px, py, pz, b in prot): continue
            tl = [i for i, (a, b, c, d) in boxes.items() if a <= cx - R and cx + R <= c and b <= cz - R and cz + R <= d]
            if tl: cand.append((cx, cz, tl[0]))
    # greedy farthest-point selection, seeded with the candidate nearest to the west edge
    cand.sort()
    picks = [cand[0]]
    while len(picks) < N_TOWERS:
        picks.append(max(cand, key=lambda c: min(math.hypot(c[0] - p[0], c[1] - p[1]) for p in picks)))
    return picks

FACE = ['north', 'east', 'south', 'west']      # k=0: entrance on north (-z) wall
def build_tower(g, cx, cz, k):
    """Local (u,v): u to the right, v toward +z when k=0; rotated k*90 degrees clockwise."""
    def P(u, v):
        for _ in range(k): u, v = -v, u
        return cx + u, cz + v
    def face(f): return FACE[(FACE.index(f) + k) % 4]
    def put(u, y, v, b):
        x, z = P(u, v); g.set(x, y, z, b)
    bricks = ['minecraft:stone_bricks'] * 6 + ['minecraft:mossy_stone_bricks'] * 2 + ['minecraft:cracked_stone_bricks'] * 2
    for u in range(-3, 4):
        for v in range(-3, 4):
            x, z = P(u, v)
            for y in range(YF + 1, 1): g.set(x, y, z, 'minecraft:air')       # clear flora and interior
            put(u, YF, v, 'minecraft:stone_bricks')
            edge = abs(u) == 3 or abs(v) == 3
            for y in range(YF + 1, YF + 12):
                if edge: put(u, y, v, bricks[(u * 7 + v * 13 + y * 5) % len(bricks)])
            put(u, YF + 12, v, 'minecraft:stone_bricks')                      # roof (y = 0)
            if not edge: put(u, YF + 7, v, 'minecraft:stone_bricks')          # mid floor
    for y in (YF + 1, YF + 2): put(0, y, -3, 'minecraft:air')                 # entrance gap, 1 wide x 2 high
    for sgn in (-1, 1):                                                       # window slits
        for y in (YF + 9, YF + 10): put(sgn * 3, y, 0, 'minecraft:air')
    for y in range(YF + 1, YF + 9):                                           # ladder through the mid-floor hole
        put(0, y, 2, f"minecraft:ladder[facing={face('north')},waterlogged=false]")
    put(0, YF + 8, -2, f"minecraft:chest[facing={face('south')},type=single,waterlogged=false]")
    put(0, YF + 11, 0, 'minecraft:lantern[hanging=true,waterlogged=false]')
    put(0, YF + 1, 0, 'minecraft:lantern[hanging=false,waterlogged=false]')
    x, z = P(0, -2)
    return x, YF + 8, z

def main(root):
    root = Path(root)
    old = B.replay(root); boxes = B.tile_boxes(root); prot = B.protected_points(root)
    sites = find_sites(old, boxes, prot)
    new = old.copy(); chests = []
    for (cx, cz, tile) in sites:
        # entrance faces the plaza along the dominant axis
        if abs(cx) >= abs(cz): k = 1 if cx < 0 else 3     # west tower: entrance east; east tower: entrance west
        else: k = 2 if cz < 0 else 0
        # k=0 entrance on north(-z); k=2 entrance south(+z); k=1 entrance east(+x); k=3 west(-x)
        chests.append((tile,) + build_tower(new, cx, cz, k))
    for (px, py, pz, b) in prot:
        assert old.get(px, py, pz) == new.get(px, py, pz), (px, py, pz, b)
    st = B.emit(root, old, new, boxes, label='1.9.99')
    # chest registration in the apply functions
    for (tile, x, y, z) in chests:
        p = root / f'data/oa/function/map/internal/tiles/apply/{tile}.mcfunction'
        L = p.read_text().splitlines()
        for j, l in enumerate(L):
            m = re.match(r'scoreboard players set #expectedc oa\.map2 (\d+)$', l)
            if m: L[j] = f'scoreboard players set #expectedc oa.map2 {int(m.group(1)) + 1}'; n_old = int(m.group(1))
        j2 = next(j for j, l in enumerate(L) if l.startswith('execute unless score #localc oa.map2 matches'))
        reg = f'execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich'
        loot = f'execute if score #mode oa.map2 matches 0 positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_upgraded'
        L[j2:j2] = [reg, loot]
        L = [re.sub(r'(execute unless score #localc oa\.map2 matches )\d+', rf'\g<1>{n_old + 1}', l) for l in L]
        # tiles with several towers: later iterations re-read the file, so counts accumulate
        p.write_text('\n'.join(L) + '\n')
    np.savez_compressed(root / 'source' / 'map_1_9_99_target.npz', V=new.V, pal=np.array(new.pal), low=B.LOW) if (root / 'source').exists() else None
    out = {'sites': [(c[0], c[1], c[2]) for c in sites], 'chests': chests, 'emit': st}
    print(json.dumps(out, default=int))

if __name__ == '__main__':
    main(sys.argv[1])
