#!/usr/bin/env python3
"""Static validation for the 1.9.97 map update.  Usage: validate_map_1_9_97.py <new_pack_dir> <old_pack_dir>
Checks: (1) replaying the emitted tile functions reproduces the target voxel model exactly,
        (2) every changed cell is an intended change, protected cells (chests/ores/jump pads) untouched,
        (3) command syntax / fill volume limits, (4) no frame surface within ぴちぴち/ふろボール reach of the old top plane,
        (5) rain/ground coverage and obstruction numbers for the plaza.  Writes VALIDATION_1_9_97.json."""
import sys, re, json, math
from pathlib import Path
import numpy as np
sys.path.insert(0, str(Path(__file__).parent))
import build_map_1_9_97 as B

new_root, old_root = Path(sys.argv[1]), Path(sys.argv[2])
res = {'version': '1.9.97', 'checks': {}}
def ok(name, cond, detail=None):
    res['checks'][name] = {'pass': bool(cond), **({'detail': detail} if detail is not None else {})}
    print(('PASS ' if cond else 'FAIL ') + name, detail if detail is not None else '')
    return cond

TILES_UP = [34, 43, 44, 45, 54, 55]
# (1) replay equality ---------------------------------------------------------------------------
old = B.replay(old_root)
new = B.replay(new_root)
tgt = np.load(new_root / 'source' / 'map_1_9_97_target.npz')
tpal = list(map(str, tgt['pal'])); TV = tgt['V']
mism = 0
for yi in range(B.NY):
    names_new = np.array([new.pal[i] for i in range(len(new.pal))])
    a = names_new[new.V[yi]]; b = np.array(tpal)[TV[yi]]
    mism += int((a != b).sum())
ok('replay_matches_target_model', mism == 0, {'mismatching_cells': mism})

# (2) change classification ---------------------------------------------------------------------
prot = B.protected_points(old_root)
pads = [(int(x) - 152, int(y) + B.LOW, int(z) - 152) for y, z, x in np.argwhere(old.V == old.P('minecraft:stone_pressure_plate[powered=false]'))]
allpal = sorted(set(old.pal) | set(new.pal)); amap = {n: i for i, n in enumerate(allpal)}
om = np.array([amap[n] for n in old.pal])[old.V]; nm = np.array([amap[n] for n in new.pal])[new.V]
changed = np.argwhere(om != nm)
DOME_BLOCKS = {'minecraft:waxed_cut_copper', 'minecraft:waxed_exposed_cut_copper', 'minecraft:waxed_weathered_cut_copper', 'minecraft:waxed_oxidized_cut_copper', 'minecraft:waxed_chiseled_copper', 'minecraft:sea_lantern', 'minecraft:polished_blackstone'}
cat = {}; bad = []
flora_ok = lambda n: any(s in n for s in ('cornflower', 'oxeye_daisy', 'allium', 'tulip', 'fern', 'short_grass', 'tall_grass'))
for yi, zi, xi in changed:
    x, y, z = int(xi) + B.X0, int(yi) + B.LOW, int(zi) + B.Z0
    o, n = old.pal[old.V[yi, zi, xi]], new.pal[new.V[yi, zi, xi]]
    r = math.hypot(x, z); k = None
    if n in DOME_BLOCKS and r <= 32 and y >= B.GROUND:
        k = 'dome_or_foot_plate' if y > B.GROUND else None
        if y == B.GROUND: k = 'foot_plate'
        if y > B.GROUND and not (o == 'minecraft:air' or 'slab' in o or flora_ok(o) or o.split(':')[1] in ('poppy', 'dandelion', 'azure_bluet')): k = None
    elif o == 'minecraft:packed_ice' and n in ('minecraft:snow_block', 'minecraft:stone', 'minecraft:gravel'): k = 'ice_line_removed'
    elif o == 'minecraft:snow_block' and n in ('minecraft:stone', 'minecraft:gravel') and z <= -90: k = 'snow_rock_patch'
    elif o == 'minecraft:air' and flora_ok(n) and y <= 0:
        below = old.get(x, y - 1, z) if 'half=upper' not in n else old.get(x, y - 2, z)
        k = 'flora' if below == 'minecraft:grass_block' else None
    elif o == 'minecraft:water' and any(s in n for s in ('seagrass', 'kelp')) and -18 <= y <= -15: k = 'sea_plant'
    elif o == 'minecraft:sand' and n == 'minecraft:gravel' and y == -19: k = 'sea_gravel'
    if k is None: bad.append((x, y, z, o, n))
    else: cat[k] = cat.get(k, 0) + 1
ok('all_changed_cells_are_intended', not bad, {'categories': cat, 'unexpected': bad[:10]})
touched = [(px, py, pz, b) for (px, py, pz, b) in prot if old.get(px, py, pz) != new.get(px, py, pz)]
touched += [(px, py, pz, 'pad') for (px, py, pz) in pads if old.get(px, py, pz) != new.get(px, py, pz)]
ok('chests_ores_jump_pads_untouched', not touched, {'protected': len(prot), 'jump_pads': len(pads)})
# registered chests/ores keep a clear 3x3 sky-side neighbourhood
near = 0
for (px, py, pz, b) in prot:
    for dx in (-1, 0, 1):
        for dz in (-1, 0, 1):
            for yy in (py, py + 1):
                if (dx or dz) and (old.get(px + dx, yy, pz + dz) != new.get(px + dx, yy, pz + dz)): near += 1
ok('no_changes_adjacent_to_chests_or_ores', near == 0, {'changed_adjacent_cells': near})

# (3) command syntax and limits -----------------------------------------------------------------
allowed = re.compile(r'^(#.*|fill ~-?\d+ ~-?\d+ ~-?\d+ ~-?\d+ ~-?\d+ ~-?\d+ minecraft:[a-z_]+(\[[a-z_=,0-9a-z]+\])?|fillbiome ~-?\d+ ~-?\d+ ~-?\d+ ~-?\d+ ~-?\d+ ~-?\d+ minecraft:[a-z_]+|scoreboard players set #stage oa.map2 \d|)$')
rxf = re.compile(r'^fill ~(-?\d+) ~(-?\d+) ~(-?\d+) ~(-?\d+) ~(-?\d+) ~(-?\d+) ')
bad_lines = 0; maxvol = 0; maxlines = 0; files = 0
for kind in ('place', 'water'):
    for i in range(100):
        L = (new_root / f'data/oa/function/map/internal/tiles/{kind}/{i}.mcfunction').read_text().splitlines()
        files += 1; maxlines = max(maxlines, len(L))
        for l in L:
            if not allowed.match(l): bad_lines += 1; print('BAD LINE', kind, i, l)
            m = rxf.match(l)
            if m:
                a = list(map(int, m.groups())); vol = (abs(a[3] - a[0]) + 1) * (abs(a[4] - a[1]) + 1) * (abs(a[5] - a[2]) + 1); maxvol = max(maxvol, vol)
ok('tile_function_syntax', bad_lines == 0, {'files': files, 'bad_lines': bad_lines})
ok('fill_volume_within_32768', maxvol <= 32768, {'max_fill_volume': maxvol})
ok('function_length_within_chain_limit', maxlines < 65536, {'longest_tile_function_lines': maxlines})
for i in TILES_UP:
    for p in (new_root / f'data/oa/function/map/internal/tiles/place/{i}.mcfunction', new_root / f'data/oa/function/map/internal/delete/apply/{i}.mcfunction'):
        if not any(re.match(r'^fill ~-?\d+ ~1 ~-?\d+ ~-?\d+ ~30 ~-?\d+ minecraft:air$', l) for l in p.read_text().splitlines()):
            ok('upper_clear_present_' + p.parent.name + '_' + str(i), False)
ok('upper_clear_in_place_and_delete_for_frame_tiles', True, {'tiles': TILES_UP, 'clear_to_y': '+30'})
# frame tiles must be exactly the tiles that contain blocks above y=0
above = set()
boxes = B.tile_boxes(new_root)
ys, zs, xs = np.nonzero(new.V[1 - B.LOW + 0:] > 0)
for yy, zz, xx in zip(ys, zs, xs):
    x, z = int(xx) + B.X0, int(zz) + B.Z0
    for i, (a, b_, c, d) in boxes.items():
        if a <= x <= c and b_ <= z <= d: above.add(i)
ok('upper_clear_tiles_cover_all_blocks_above_y0', above == set(TILES_UP), {'tiles_with_blocks_above_y0': sorted(above)})
topy = int(max(int(yy) for yy in np.nonzero((new.V > 0).any(axis=(1, 2)))[0]) + B.LOW)
ok('highest_block_below_clear_top', topy <= B.CLEAR_TOP, {'highest_y': topy, 'clear_top': B.CLEAR_TOP})

# (4) reach analysis ----------------------------------------------------------------------------
NONSOLID = ('air', 'water', 'short_grass', 'tall_grass', 'fern', 'poppy', 'dandelion', 'azure_bluet', 'cornflower', 'oxeye_daisy', 'allium', 'tulip', 'lily_of_the_valley', 'seagrass', 'kelp', 'vine', 'pressure_plate', 'ladder')
def solid(n): return not any(s in n for s in NONSOLID)
dome_cells = set(B.build_dome()[0].keys())
stand_dome_min = None; stand_other_max = None
Vn = new.V; names = np.array(new.pal)
solid_pal = np.array([solid(p) for p in new.pal])
S = solid_pal[Vn]                              # (NY, W, W)
free = ~S
stand = np.zeros_like(S)
stand[1:-1] = S[:-2] & free[1:-1] & free[2:]   # cell y stands on y-1, two cells headroom
# (stand index yi means standing cell y = yi+LOW; support at yi-1)
dome_h = []; other_h = []
for yi, zi, xi in np.argwhere(stand):
    x, y, z = int(xi) + B.X0, int(yi) + B.LOW, int(zi) + B.Z0
    if (x, y - 1, z) in dome_cells: dome_h.append(y)
    elif y > -9 and math.hypot(x, z) < 80: other_h.append(y)
other_hi = [int(np.argwhere(stand)[:, 0].max()) + B.LOW]
stand_dome_min = min(dome_h); stand_other_max = max(other_h)
# stand cells that are not dome-owned but above y=1 (nothing should be there)
stray = [(int(xi) + B.X0, int(yi) + B.LOW, int(zi) + B.Z0) for yi, zi, xi in np.argwhere(stand) if int(yi) + B.LOW > 1 and (int(xi) + B.X0, int(yi) + B.LOW - 1, int(zi) + B.Z0) not in dome_cells]
ok('no_standable_surface_above_old_top_except_frame', not stray, {'stray': stray[:5]})
FUROBALL, PICHI_PAIMON, PICHI = 10.087, 8.43, 6.13
gap = stand_dome_min - 1                         # old top stand level is y=1 (leaf tops at y=0)
ok('frame_lowest_surface_beyond_all_vertical_mobility', gap > FUROBALL, {'lowest_frame_stand_y': stand_dome_min, 'old_top_stand_y': 1, 'gap_blocks': gap, 'furoball_rise': FUROBALL, 'pichi_plus_paimon_jump': PICHI_PAIMON, 'pichi_jump': PICHI})
res['reach'] = {'lowest_frame_standing_height_above_plaza_floor': stand_dome_min - (B.GROUND + 1), 'highest_non_frame_stand_y': 1}

# (5) plaza numbers -----------------------------------------------------------------------------
cells_under = {(x, z) for (x, y, z) in dome_cells if y >= B.Yk(0)}
def cov(rm): return sum(1 for c in cells_under if math.hypot(*c) <= rm), sum(1 for x in range(-27, 28) for z in range(-27, 28) if math.hypot(x, z) <= rm)
res['plaza'] = {'cells_under_frame_r<=26.5': cov(26.5), 'cells_under_frame_r<=23': cov(23), 'cells_under_frame_r<=9': cov(9),
                'frame_blocks': len(dome_cells), 'ground_level_obstruction_cells': sum(1 for (x, y, z) in dome_cells if y == B.Yk(0)),
                'sea_lantern_blocks': sum(1 for v in B.build_dome()[0].values() if v == 'minecraft:sea_lantern'), 'frame_top_y': max(y for (x, y, z) in dome_cells)}
print(res['plaza'])
ok('plaza_centre_disc_r8_open_to_sky', cov(8)[0] == 0, {'cells_under_frame_r<=8': cov(8)[0]})
# ground-level walkability: floor cells at y=-10..-8 changed only on pier footprints
gl = [(x, y, z) for (x, y, z) in dome_cells if y <= B.Yk(0) + 20]
piers = {(x, z) for (x, y, z) in gl}
ok('lower_frame_is_only_8_vertical_piers_2x2', len(piers) == 32 and all(sum(1 for (x, y, z) in dome_cells if (x, z) == c and y < B.Yk(B.K_BASE)) == B.K_BASE for c in piers))
ok('no_frame_block_between_k0_and_k20_except_piers', all(((x, z) in piers) for (x, y, z) in dome_cells if y < B.Yk(B.K_BASE)))
res['summary'] = {k: v['pass'] for k, v in res['checks'].items()}
res['all_pass'] = all(v['pass'] for v in res['checks'].values())
(new_root / 'VALIDATION_1_9_97.json').write_text(json.dumps(res, ensure_ascii=False, indent=1, default=int) + '\n')
print('ALL PASS' if res['all_pass'] else 'SOME FAILED')
sys.exit(0 if res['all_pass'] else 1)
