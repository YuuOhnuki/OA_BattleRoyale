"""OA 出撃ターミナル（1.9.203）。ロビーの建築・表示・操作部品の唯一の生成元。

座標は登録原点からの相対。床面 y=-1（立つ高さ y=0）。範囲 X/Z ±40、Y -3〜+44（従来と同じ）。
正面は +Z（到着・帰還位置 (0.5, 0, 5.5) から南を向く）。
出力：
  data/oa/function/lobby/terminal/build.mcfunction     ブロック＋表示（oa.admin 14 / 4）
  data/oa/function/lobby/terminal/entities.mcfunction  表示・操作部品だけを置き直す（oa.admin 46）
検査（失敗すると例外）：主要通路の床・頭上、操作部品の手前の空き、歩いて届くこと、
  足元の明るさ（ブロック光の簡易計算）、浮いたブロック、ガラス・柵・壁の接続、操作部品の重なり。
"""
from pathlib import Path
import json, math, sys
from collections import deque
sys.path.insert(0, str(Path(__file__).resolve().parent))
from lobby_models import placement

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / 'data/oa/function/lobby/terminal'
OUT.mkdir(parents=True, exist_ok=True)
VER = 203
LIM, YMIN, YMAX = 40, -3, 44

ops = []          # ('fill', x1,y1,z1,x2,y2,z2,block) in order
blocks = {}       # final voxel state
ents = []         # summon commands
meta = {'interactions': [], 'exhibits': [], 'texts': 0, 'items': 0}

def box(x1, y1, z1, x2, y2, z2, b):
    x1, x2 = sorted((x1, x2)); y1, y2 = sorted((y1, y2)); z1, z2 = sorted((z1, z2))
    assert -LIM <= x1 and x2 <= LIM and -LIM <= z1 and z2 <= LIM and YMIN <= y1 and y2 <= YMAX, (x1, y1, z1, x2, y2, z2, b)
    ops.append((x1, y1, z1, x2, y2, z2, b))
    for x in range(x1, x2 + 1):
        for y in range(y1, y2 + 1):
            for z in range(z1, z2 + 1):
                if b == 'air': blocks.pop((x, y, z), None)
                else: blocks[x, y, z] = b

def put(x, y, z, b): box(x, y, z, x, y, z, b)
def repl(x1, y1, z1, x2, y2, z2, old, new):
    """fill ... new replace old (exact block id without state)."""
    x1, x2 = sorted((x1, x2)); y1, y2 = sorted((y1, y2)); z1, z2 = sorted((z1, z2))
    ops.append((x1, y1, z1, x2, y2, z2, new + ' replace minecraft:' + old))
    for x in range(x1, x2 + 1):
        for y in range(y1, y2 + 1):
            for z in range(z1, z2 + 1):
                if base(blocks.get((x, y, z), 'air')) == old: blocks[x, y, z] = new
def at(x, y, z): return blocks.get((x, y, z), 'air')
def base(b): return b.split('[')[0]

FLIP = {'east': 'west', 'west': 'east'}
def flip(b, side):
    """Mirror a block state across X when side < 0."""
    if side > 0 or '[' not in b: return b
    name, props = b[:-1].split('[')
    out = []
    for p in props.split(','):
        k, v = p.split('=')
        if k == 'facing' and v in FLIP: v = FLIP[v]
        if k in ('east', 'west'): k = FLIP[k]
        out.append(f'{k}={v}')
    return name + '[' + ','.join(out) + ']'

# ---------------------------------------------------------------- entities
def f(v): return float(round(v, 4))
def tf(scale=1.0, tr=(0, 0, 0), lr=(0, 0, 0, 1)):
    s = scale if isinstance(scale, (list, tuple)) else [scale] * 3
    return {'translation': [f(v) for v in tr], 'left_rotation': [f(v) for v in lr], 'right_rotation': [0.0, 0.0, 0.0, 1.0], 'scale': [f(v) for v in s]}
def nbt(d): return json.dumps(d, ensure_ascii=False, separators=(',', ':'))
YAW = {'n': 180.0, 's': 0.0, 'e': -90.0, 'w': 90.0}   # side the face looks toward
DIR = {'n': (0, -1), 's': (0, 1), 'e': (1, 0), 'w': (-1, 0)}
TAGS = ['oa.lobby_exhibit', 'oa.terminal', f'oa.t{VER}']

def text(x, y, z, comp, face='n', scale=1.0, tags=(), width=200, bg=0, align='center', view=1.0, bright=True):
    if isinstance(comp, str): comp = {'text': comp}
    d = {'Tags': TAGS + list(tags), 'Rotation': [YAW[face], 0.0], 'billboard': 'fixed', 'text': comp,
         'background': bg, 'shadow': True, 'line_width': width, 'alignment': align, 'view_range': view,
         'transformation': tf(scale)}
    if bright: d['brightness'] = {'block': 15, 'sky': 15}
    ents.append(f'summon minecraft:text_display ~{f(x)} ~{f(y)} ~{f(z)} ' + nbt(d))
    meta['texts'] += 1

def item(x, y, z, item_nbt, face='n', p=None, tags=(), glow_bright=True, view=0.8):
    d = {'Tags': TAGS + list(tags), 'Rotation': [YAW[face], 0.0], 'billboard': 'fixed', 'item_display': 'fixed',
         'item': item_nbt, 'view_range': view,
         'transformation': tf(p['scale'], p['translation'], p['left_rotation'])}
    if glow_bright: d['brightness'] = {'block': 15, 'sky': 15}
    ents.append(f'summon minecraft:item_display ~{f(x)} ~{f(y)} ~{f(z)} ' + nbt(d))
    meta['items'] += 1

def oa_item(model):
    if model == 'furoball':
        return {'id': 'minecraft:fire_charge', 'count': 1}
    assert (ROOT.parent / 'oa_battleroyale_resourcepack/assets/oa/items' / f'{model}.json').is_file(), model
    return {'id': 'minecraft:carrot_on_a_stick', 'count': 1, 'components': {'minecraft:item_model': 'oa:' + model}}

def interaction(x, y, z, width, height, action, label):
    """x, z: centre. Box spans x±w/2, y..y+h."""
    ents.append(f'summon minecraft:interaction ~{f(x)} ~{f(y)} ~{f(z)} ' + nbt({'Tags': TAGS + ['oa.term.' + action], 'width': f(width), 'height': f(height), 'response': True}))
    meta['interactions'].append({'action': action, 'label': label, 'x0': x - width / 2, 'x1': x + width / 2, 'z0': z - width / 2, 'z1': z + width / 2, 'y0': y, 'y1': y + height})

# ---------------------------------------------------------------- palette
WHITE, WHITE_S = 'smooth_quartz', 'smooth_quartz_slab[type=bottom]'
WHITE_T = 'smooth_quartz_slab[type=top]'
DARK, DARK_S, DARK_T = 'polished_deepslate', 'polished_deepslate_slab[type=bottom]', 'polished_deepslate_slab[type=top]'
BRICK, TILE = 'deepslate_bricks', 'deepslate_tiles'
TILE_S = 'deepslate_tile_slab[type=bottom]'
PILLAR = 'quartz_pillar[axis=y]'
CAP = 'chiseled_quartz_block'
SCREEN = 'polished_blackstone'
GLASS_PANE = 'light_blue_stained_glass_pane'
SKY = 'light_blue_stained_glass'
BEAM_X, BEAM_Z = 'dark_oak_log[axis=x]', 'dark_oak_log[axis=z]'
WOOD = 'stripped_oak_log[axis=y]'
LEAF = 'azalea_leaves[persistent=true]'
FLEAF = 'flowering_azalea_leaves[persistent=true]'
BR_C, TDM_C = 'light_blue_concrete', 'orange_concrete'
BR_LIGHT, TDM_LIGHT = 'sea_lantern', 'shroomlight'

def column(x, z, h, plinth=DARK):
    put(x, 0, z, plinth); box(x, 1, z, x, h - 1, z, PILLAR); put(x, h, z, CAP)

def lantern_hang(x, z, y_top, drop):
    """Chain from the ceiling block at y_top+1 down to a lantern."""
    for y in range(y_top, y_top - drop, -1): put(x, y, z, 'iron_chain[axis=y]')
    put(x, y_top - drop, z, 'lantern[hanging=true]')

def planter(x, z, r=1, tree=True):
    box(x - r - 1, 0, z - r - 1, x + r + 1, 0, z + r + 1, DARK)
    box(x - r, 0, z - r, x + r, 0, z + r, 'moss_block')
    if tree:
        box(x, 1, z, x, 3, z, WOOD)
        box(x - 1, 3, z - 1, x + 1, 4, z + 1, LEAF); put(x, 3, z, WOOD)
        box(x, 5, z, x, 5, z, FLEAF); put(x - 1, 4, z, FLEAF); put(x + 1, 3, z + 1, FLEAF)
    else:
        for dx in range(-r, r + 1):
            for dz in range(-r, r + 1):
                put(x + dx, 1, z + dz, 'azalea' if (dx + dz) % 2 == 0 else 'flowering_azalea')

def tree(x, z, h=5, leaf=LEAF, accent=FLEAF):
    """Free-standing garden tree on a grass patch (trunk rests on the ground)."""
    box(x, 0, z, x, h, z, 'oak_log[axis=y]')
    for y, r in [(h - 2, 2), (h - 1, 2), (h, 1), (h + 1, 1)]:
        for dx in range(-r, r + 1):
            for dz in range(-r, r + 1):
                if abs(dx) == r and abs(dz) == r and r == 2: continue
                if (dx, dz) == (0, 0) and y <= h: continue
                put(x + dx, y, z + dz, accent if (dx * 3 + dz + y) % 5 == 0 else leaf)

def lamp_post(x, z, top=BR_LIGHT):
    put(x, 0, z, DARK); box(x, 1, z, x, 3, z, 'dark_oak_fence'); put(x, 4, z, top); put(x, 5, z, DARK_S)

def bench(x, z, length, face):
    """Bench along X (face n/s) or Z (face e/w). Seat slabs, backrest trapdoor on the far side, end posts."""
    if face in 'ns':
        dz = -DIR[face][1]
        box(x, 0, z, x + length - 1, 0, z, 'spruce_slab[type=bottom]')
        tr = {'n': 'south', 's': 'north'}[face]
        box(x, 0, z + dz, x + length - 1, 0, z + dz, f'spruce_trapdoor[facing={tr},half=bottom,open=true]')
    else:
        dx = -DIR[face][0]
        box(x, 0, z, x, 0, z + length - 1, 'spruce_slab[type=bottom]')
        tr = {'e': 'west', 'w': 'east'}[face]
        box(x + dx, 0, z, x + dx, 0, z + length - 1, f'spruce_trapdoor[facing={tr},half=bottom,open=true]')

# Console (受付端末): desk at (x,z), screen one block behind, light cap above the screen.
CONSOLES = []
def console(x, z, face, title, sub, action, icon, color='aqua', cap=BR_LIGHT, panel_tint=None):
    dx, dz = DIR[face]
    sx, sz = x - dx, z - dz
    put(x, 0, z, DARK); put(x, 1, z, WHITE_S)
    box(sx, 0, sz, sx, 0, sz, DARK); box(sx, 1, sz, sx, 2, sz, SCREEN); put(sx, 3, sz, cap)
    if panel_tint: put(sx, 4, sz, panel_tint)
    # floor light in front of the desk (flush)
    put(x + dx, -1, z + dz, cap)
    cxs, czs = sx + 0.5 + dx * 0.52, sz + 0.5 + dz * 0.52
    assert len(title) <= 5 and len(sub) <= 8, (title, sub)
    text(cxs, 2.0, czs, [{'text': title + '\n', 'color': color, 'bold': True}, {'text': sub, 'color': 'white'}], face, 0.5 if len(sub) > 6 else 0.56, tags=['oa.screen.' + action], width=150, bg=0)
    text(cxs, 1.2, czs, {'text': '右クリック', 'color': 'gray'}, face, 0.42, width=120)
    if isinstance(icon, tuple):   # weapon model
        p = placement('oa:item/' + icon[1], target=0.42, tilt=25)
        item(x + 0.5, 1.5, z + 0.5, oa_item(icon[1]), face, p)
    else:
        p = placement(None, target=0.3, tilt=40, block_item=True)
        item(x + 0.5, 1.5, z + 0.5, {'id': 'minecraft:' + icon, 'count': 1}, face, p)
    # Interaction: covers desk + screen face (box front plane at desk front, back plane 0.06 into the screen block).
    icx, icz = x + 0.5 - dx * 0.03, z + 0.5 - dz * 0.03
    interaction(icx, 0, icz, 1.0, 3.0, action, title)
    CONSOLES.append((x, z, face, action))

# ======================================================================= build
for t in ['oa.lobby_label', 'oa.lobby_exhibit', 'oa.terminal', 'oa.button_lobby', 'oa.button_mapsel', 'oa.map_native1981',
          'oa.map_panel1116', 'tdm.station', 'oa.gallery', 'oa.board_stats', 'oa.board_last', 'oa.board_ach', 'oa.rank_holo']:
    pass  # killing is emitted in both functions below

# --- clear envelope and ground
for y in range(0, 45, 4): box(-40, y, -40, 40, min(y + 3, 44), 40, 'air')
box(-40, -3, -40, 40, -2, 40, 'stone_bricks')
box(-40, -1, -40, 40, -1, 40, 'grass_block')

# --- perimeter: hedge on a dark plinth, lamp every 10
for (x1, z1, x2, z2) in [(-40, -40, 40, -40), (-40, 40, 40, 40), (-40, -39, -40, 39), (40, -39, 40, 39)]:
    box(x1, -1, z1, x2, -1, z2, DARK)
    box(x1, 0, z1, x2, 1, z2, LEAF)

# ---------------------------------------------------------------- plaza (到着広場)
box(-15, -1, -10, 15, -1, 12, 'calcite')
for x in (-15, 15): box(x, -1, -10, x, -1, 12, WHITE)
for z in (-10, 12): box(-15, -1, z, 15, -1, z, WHITE)
for x in (-10, -5, 5, 10): box(x, -1, -9, x, -1, 11, 'polished_andesite')
for z in (-5, 0): box(-14, -1, z, 14, -1, z, 'polished_andesite')
# compass rose around the arrival point (0,5)
for x in range(-7, 8):
    for z in range(-2, 13):
        r = math.hypot(x, z - 5)
        if 5.5 <= r < 6.6: put(x, -1, z, TILE)
        elif 3.4 <= r < 4.2: put(x, -1, z, 'polished_deepslate')
        elif r < 3.4: put(x, -1, z, WHITE)
for a in range(8):
    x = round(6 * math.sin(a * math.pi / 4)); z = 5 + round(6 * math.cos(a * math.pi / 4))
    put(x, -1, z, BR_LIGHT)
put(0, -1, 5, 'oxidized_cut_copper')
# forward spoke: the BR/TDM split line starts here
box(0, -1, 9, 0, -1, 16, 'cyan_concrete')
for z in (11, 14): put(0, -1, z, BR_LIGHT)
# plaza planters with seating, framing the side entrances, clear of the 7-wide forward route
for side in (-1, 1):
    planter(side * 11, -7, 1)
    planter(side * 11, 9, 1)
    # benches facing the plaza centre along the wing walls (x=±14)
    face = 'w' if side > 0 else 'e'
    bench(side * 14, -3, 3, face)
    bench(side * 14, 3, 3, face)
    lamp_post(side * 13, -9)
    lamp_post(side * 13, 11)
# plaza corner fill light (flush)
for x, z in [(-8, -8), (8, -8), (-8, 2), (8, 2)]: put(x, -1, z, BR_LIGHT)

# ---------------------------------------------------------------- back garden & fountain
box(-6, -1, -11, 6, -1, -39, 'calcite')            # central path
for x in (-6, 6): box(x, -1, -11, x, -1, -39, WHITE)
FC = (0, -22)
for x in range(-7, 8):
    for z in range(-29, -14):
        r = math.hypot(x - FC[0], z - FC[1])
        if r < 7.5: put(x, -1, z, 'calcite' if r >= 6.4 else WHITE)
for x in range(-6, 7):
    for z in range(-28, -15):
        r = math.hypot(x - FC[0], z - FC[1])
        if 4.5 <= r < 5.5:
            put(x, -2, z, DARK); put(x, -1, z, DARK); put(x, 0, z, DARK); put(x, 1, z, WHITE_S)
        elif r < 4.5:
            put(x, -2, z, 'prismarine_bricks'); put(x, -1, z, 'water')
for dx, dz in [(2, 0), (-2, 0), (0, 2), (0, -2)]: put(FC[0] + dx, -2, FC[1] + dz, BR_LIGHT)
box(0, -1, -22, 0, 1, -22, PILLAR); put(0, 2, -22, BR_LIGHT); put(0, 3, -22, WHITE_S)
# garden trees and seating
for side in (-1, 1):
    for z in (-15, -33):
        tree(side * 11, z)
    bench(side * 8 - (2 if side > 0 else 0), -30, 3, 'n')
    for z in (-14, -38):
        lamp_post(side * 7, z)
# pergola over the far bench row
for x in (-8, -3, 3, 8):
    box(x, 0, -35, x, 4, -35, 'dark_oak_log[axis=y]')
box(-9, 5, -36, 9, 5, -34, 'dark_oak_slab[type=bottom]')
for x in range(-8, 9, 2): put(x, 4, -36, LEAF)
bench(-5, -36, 3, 'n'); bench(3, -36, 3, 'n')
put(0, -1, -35, BR_LIGHT); put(-6 + 1, -1, -35, BR_LIGHT); put(5, -1, -35, BR_LIGHT)

# ---------------------------------------------------------------- departure hall (出撃ホール)
HX, HZ0, HZ1 = 25, 13, 35        # outer x ±25, z 13..35
box(-24, -1, 14, 24, -1, 34, WHITE)                    # interior floor
box(-24, -1, 14, 24, -1, 14, DARK)
for x in (-24, 24): box(x, -1, 14, x, -1, 34, DARK)
box(-24, -1, 34, 24, -1, 34, DARK)
for x in (-9, 9): box(x, -1, 15, x, -1, 33, TILE)      # colonnade bands
box(-5, -1, 13, 5, -1, 13, DARK)                        # threshold
box(-25, -1, 13, 25, -1, 13, TILE)
# guide lines: shared cyan spine → BR (left, +X, blue) / TDM (right, -X, orange)
box(0, -1, 14, 0, -1, 17, 'cyan_concrete')
box(1, -1, 17, 16, -1, 17, BR_C); box(16, -1, 18, 16, -1, 19, BR_C)
box(-16, -1, 17, -1, -1, 17, TDM_C); box(-16, -1, 18, -16, -1, 19, TDM_C)
for x in (4, 8, 12): put(x, -1, 17, BR_LIGHT); put(-x, -1, 17, TDM_LIGHT)
put(0, -1, 17, BR_LIGHT)
# reception floors
box(10, -1, 15, 23, -1, 33, 'polished_diorite'); box(-23, -1, 15, -10, -1, 33, 'polished_granite')
for z in (15, 33): box(10, -1, z, 23, -1, z, BR_C); box(-23, -1, z, -10, -1, z, TDM_C)
box(1, -1, 17, 16, -1, 17, BR_C); box(-16, -1, 17, -1, -1, 17, TDM_C)
for x in (4, 8, 12): put(x, -1, 17, BR_LIGHT); put(-x, -1, 17, TDM_LIGHT)
box(16, -1, 18, 16, -1, 19, BR_C); box(-16, -1, 18, -16, -1, 19, TDM_C)

# walls: side (2 thick), back (2 thick)
for side in (-1, 1):
    xo, xi = side * 25, side * 24
    box(xo, 0, 13, xo, 11, 35, BRICK); box(xi, 0, 15, xi, 11, 34, WHITE)
    box(xo, 0, 13, xo, 0, 35, DARK)
    # tall windows between pilasters on the outer side wall
    for z0 in (16, 22, 28):
        box(xo, 2, z0, xo, 8, z0 + 3, GLASS_PANE); box(xi, 2, z0, xi, 8, z0 + 3, 'air')
        box(xi, 1, z0, xi, 1, z0 + 3, WHITE_S)            # sill (inner)
        box(xo, 9, z0 - 1, xo, 9, z0 + 4, DARK)           # head
    for z in (15, 21, 27, 33):
        box(xo, 1, z, xo, 10, z, 'polished_deepslate_wall')   # exterior pilasters (wall posts)
box(-25, 0, 35, 25, 11, 35, BRICK); box(-24, 0, 34, 24, 11, 34, WHITE)
box(-25, 0, 35, 25, 0, 35, DARK)
# front colonnade (z=13): open bays, deep lintel
for x in (-24, -19, -13, -7, 7, 13, 19, 24):
    column(x, 13, 9)
box(-25, 10, 13, 25, 11, 13, DARK); box(-24, 10, 14, 24, 11, 14, WHITE)
box(-25, 12, 13, 25, 12, 13, DARK_S)
# entrance canopy (庇) over the arrival axis, carried on two columns + beams
for x in (-10, 10): column(x, 9, 8)
box(-10, 9, 8, 10, 9, 12, WHITE); box(-11, 9, 7, 11, 9, 7, DARK_S)
box(-11, 9, 8, -11, 9, 12, DARK_S); box(11, 9, 8, 11, 9, 12, DARK_S)
box(-9, 8, 9, 9, 8, 9, BEAM_X); box(-9, 8, 11, 9, 8, 11, BEAM_X)
for x in (-6, -2, 2, 6):
    put(x, 8, 10, BR_LIGHT)                                 # recessed soffit lights
# roof: aisles at y=12 (ceiling), nave raised to y=17 with clerestory
box(-24, 12, 14, -9, 12, 34, WHITE); box(9, 12, 14, 24, 12, 34, WHITE)
box(-25, 13, 13, -9, 13, 35, TILE_S); box(9, 13, 13, 25, 13, 35, TILE_S)
for side in (-1, 1):
    box(side * 25, 12, 13, side * 25, 12, 35, DARK)
    box(side * 26, 12, 13, side * 26, 12, 35, DARK_T)       # eave
    xc = side * 9
    box(xc, 12, 14, xc, 12, 34, DARK)                       # clerestory beam
    for z in (14, 19, 25, 31, 34):
        box(xc, 13, z, xc, 16, z, PILLAR)
    for z0, z1 in ((15, 18), (20, 24), (26, 30), (32, 33)):
        box(xc, 13, z0, xc, 16, z1, GLASS_PANE)
    box(xc, 17, 13, xc, 17, 35, DARK)
box(-9, 12, 13, 9, 16, 13, WHITE); box(-9, 12, 35, 9, 16, 35, WHITE)
box(-8, 17, 13, 8, 17, 35, WHITE); box(-9, 18, 13, 9, 18, 35, DARK_S)
for z0 in (17, 23, 29):
    box(-6, 17, z0, 6, 17, z0 + 2, SKY)                     # skylight strips
    box(-6, 18, z0, 6, 18, z0 + 2, 'air')
# interior columns on the nave line
for side in (-1, 1):
    for z in (19, 25, 31):
        column(side * 9, z, 11)
# beams and ceiling lights
for z in (16, 22, 28):
    box(-23, 11, z, -10, 11, z, BEAM_X); box(10, 11, z, 23, 11, z, BEAM_X)
    box(-8, 16, z, 8, 16, z, BEAM_X)
for side in (-1, 1):
    for z in (19, 25, 31):
        for x in (12, 17, 21):
            put(side * x, 11, z, BR_LIGHT if side > 0 else TDM_LIGHT)
for z in (16, 22, 28, 34 - 1):
    for x in (-4, 4):
        put(x, 16, z if z < 33 else 32, BR_LIGHT)

# ---------------------------------------------------------------- shared departure board (centre back)
box(-8, 2, 33, 8, 10, 33, DARK)                 # board frame
box(-7, 3, 33, 7, 9, 33, 'black_concrete')
box(-8, 1, 32, 8, 1, 32, WHITE_T)               # ledge
for x in (-8, 8): box(x, 2, 32, x, 10, 32, PILLAR)
box(-8, 11, 32, 8, 11, 32, DARK_S)
for x in (-6, -2, 2, 6): put(x, 10, 32, BR_LIGHT)
# departure gate relief under the board: recessed blue doorway (flush, not walkable through)
box(-2, 0, 33, 2, 0, 33, DARK); box(-1, 0, 32, 1, 0, 32, DARK_S)
text(0.5, 7.9, 32.9, [{'text': 'OA 出撃ターミナル', 'color': 'aqua', 'bold': True}], 'n', 3.0, width=400)
text(0.5, 5.2, 32.9, {'text': '待機中', 'color': 'white'}, 'n', 1.6, tags=['oa.terminal.status'], width=400)
text(0.5, 3.3, 32.9, [{'text': '← バトルロワイヤル受付　　　チームデスマッチ受付 →\n', 'color': 'white'}, {'text': 'メニューは /oa', 'color': 'gray'}], 'n', 1.0, width=500)
# nave benches & planters between columns (out of the 9-wide centre aisle)
for side in (-1, 1):
    for z in (22, 28):
        put(side * 8, 0, z, 'moss_block'); put(side * 8, 1, z, 'azalea')
        put(side * 8, -1, z, DARK)

# ---------------------------------------------------------------- receptions
def reception(side):
    s = side
    ttl = 'バトルロワイヤル' if s > 0 else 'チームデスマッチ'
    sub = 'BR 受付｜ソロ・チーム戦' if s > 0 else 'TDM 受付｜赤・青 5分間'
    col = 'aqua' if s > 0 else 'gold'
    light = BR_LIGHT if s > 0 else TDM_LIGHT
    # hanging header board (chains to the z=22 beam above)
    box(s * 11, 7, 23, s * 21, 9, 23, DARK)
    box(min(s * 10, s * 22), 10, 23, max(s * 10, s * 22), 10, 23, BEAM_X)
    for x in (10, 22): box(s * x, 7, 23, s * x, 9, 23, PILLAR)
    box(min(s * 10, s * 22), 6, 23, max(s * 10, s * 22), 6, 23, DARK_T)
    cx = s * 16 + 0.5
    text(cx, 8.25, 22.47, [{'text': ttl, 'color': col, 'bold': True}], 'n', 2.6, width=400)
    text(cx, 7.6, 22.47, {'text': sub, 'color': 'white'}, 'n', 0.85, width=400)
    text(cx, 7.05, 22.47, {'text': '準備中', 'color': 'gray'}, 'n', 0.75, tags=['oa.terminal.' + ('br_status' if s > 0 else 'tdm_status')], width=420)
    # support: beam at y=10 spans to the clerestory column line (x=±9) and the side wall (x=±24)
    box(min(s * 9, s * 24), 10, 23, max(s * 9, s * 24), 10, 23, BEAM_X)
    for x in (10, 22): put(s * x, 6, 22, light)     # under-board downlights face the counter
    # counter wall behind the map / team consoles (z=22) with gaps for the desks
reception(1); reception(-1)

# BR consoles (z=21, screens at z=22, operated from z<=20 facing +Z)
console(11, 21, 'n', 'チーム', 'BRチーム選択', 'br_team', 'light_blue_wool')
console(14, 21, 'n', '地上', 'マップ', 'br_map.0', 'grass_block')
console(16, 21, 'n', 'ネザー', 'マップ', 'br_map.1', 'crimson_nylium')
console(18, 21, 'n', '地下', '古代都市', 'br_map.2', 'sculk')
console(21, 21, 'n', '出撃設定', '形式・開始', 'br_host', 'lodestone')
box(15, 0, 22, 15, 3, 22, DARK); box(17, 0, 22, 17, 3, 22, DARK)       # map counter frame between screens
box(13, 3, 22, 19, 3, 22, DARK); put(14, 3, 22, BR_LIGHT); put(16, 3, 22, BR_LIGHT); put(18, 3, 22, BR_LIGHT)
box(13, 0, 22, 13, 3, 22, DARK); box(19, 0, 22, 19, 3, 22, DARK)
# TDM consoles (mirrored)
console(-11, 21, 'n', '会場案内', '立体工廠', 'tdm_info', 'waxed_cut_copper', 'gold', TDM_LIGHT)
console(-14, 21, 'n', '赤チーム', '希望する', 'tdm_red', 'red_wool', 'red', TDM_LIGHT)
console(-16, 21, 'n', '出撃武器', '固有武器を選ぶ', 'tdm_weapon', ('m', 'hotchikisu'), 'gold', TDM_LIGHT)
console(-18, 21, 'n', '青チーム', '希望する', 'tdm_blue', 'blue_wool', 'blue', TDM_LIGHT)
console(-21, 21, 'n', '出撃設定', 'モード・開始', 'tdm_host', 'target', 'gold', TDM_LIGHT)
box(-15, 0, 22, -15, 3, 22, DARK); box(-17, 0, 22, -17, 3, 22, DARK)
box(-19, 3, 22, -13, 3, 22, DARK); put(-14, 3, 22, TDM_LIGHT); put(-16, 3, 22, TDM_LIGHT); put(-18, 3, 22, TDM_LIGHT)
box(-13, 0, 22, -13, 3, 22, DARK); box(-19, 0, 22, -19, 3, 22, DARK)

# BR display: map panel on the back wall (shows the selected BR map)
box(11, 3, 33, 21, 10, 33, DARK); box(12, 4, 33, 20, 9, 33, 'black_concrete')
for x in (11, 21): box(x, 2, 32, x, 10, 32, PILLAR)
box(11, 1, 32, 21, 1, 32, WHITE_T); box(11, 11, 32, 21, 11, 32, DARK_S)
for x in (13, 16, 19): put(x, 2, 33, BR_LIGHT)
item(16.5, 6.5, 32.95, {'id': 'minecraft:carrot_on_a_stick', 'count': 1, 'components': {'minecraft:item_model': 'oa:lobby_map_panel'}}, 'n',
     {'scale': 5.6, 'translation': [0, 0, 0], 'left_rotation': [0, 0, 0, 1]}, tags=['oa.terminal.map_panel'], view=1.0)
text(16.5, 9.5, 32.9, {'text': '地上', 'color': 'aqua', 'bold': True}, 'n', 1.3, tags=['oa.terminal.map_name'])
# BR team banners above the side wall sills (10 colours)
for i, c in enumerate(['pink', 'cyan', 'red', 'blue', 'lime', 'yellow', 'purple', 'orange', 'white', 'black']):
    pass
# BR seating / waiting area in front of the panel
bench(13, 28, 3, 'n'); bench(18, 28, 3, 'n')
put(16, -1, 29, BR_LIGHT); put(12, -1, 25, BR_LIGHT); put(20, -1, 25, BR_LIGHT); put(16, -1, 25, BR_LIGHT)
put(22, -1, 18, BR_LIGHT)

# TDM display: red | blue wall and venue model
box(-21, 3, 33, -11, 10, 33, DARK)
box(-20, 4, 33, -17, 9, 33, 'red_concrete'); box(-15, 4, 33, -12, 9, 33, 'blue_concrete'); box(-16, 4, 33, -16, 9, 33, 'black_concrete')
for x in (-11, -21): box(x, 2, 32, x, 10, 32, PILLAR)
box(-21, 1, 32, -11, 1, 32, WHITE_T); box(-21, 11, 32, -11, 11, 32, DARK_S)
for x in (-19, -16, -13): put(x, 2, 33, TDM_LIGHT)
for x in (-20, -18): put(x, 8, 32, 'red_wall_banner[facing=north]')
for x in (-14, -12): put(x, 8, 32, 'blue_wall_banner[facing=north]')
text(-18.0, 5.6, 32.9, {'text': '赤', 'color': 'white', 'bold': True}, 'n', 5.5)
text(-13.0, 5.6, 32.9, {'text': '青', 'color': 'white', 'bold': True}, 'n', 5.5)
text(-15.5, 4.3, 32.9, {'text': '赤 0人　青 0人', 'color': 'white'}, 'n', 1.0, tags=['oa.terminal.tdm_counts'], width=300)
# venue miniature on a plinth (立体工廠: stacked copper decks)
box(-18, 0, 27, -14, 0, 29, DARK)
box(-17, 1, 28, -15, 1, 28, 'waxed_cut_copper'); put(-16, 2, 28, 'waxed_copper_grate'); put(-17, 2, 28, 'waxed_cut_copper_slab[type=bottom]'); put(-15, 2, 28, 'waxed_exposed_cut_copper_slab[type=bottom]')
put(-16, 3, 28, 'waxed_copper_bulb[lit=true,powered=false]')
put(-14, 1, 27, 'red_carpet'); put(-18, 1, 29, 'blue_carpet')
put(-16, -1, 26, TDM_LIGHT); put(-12, -1, 25, TDM_LIGHT); put(-20, -1, 25, TDM_LIGHT); put(-16, -1, 31, TDM_LIGHT)

# ---------------------------------------------------------------- wings (armory west, records east)
def wing_shell(side):
    s = side
    xo, xi = s * 17, s * 39               # inner wall (plaza side) x=±17, outer wall x=±39
    lo, hi = sorted((xo, xi))
    box(lo, -1, -31, hi, -1, 9, DARK)
    box(lo + 1, -1, -30, hi - 1, -1, 8, WHITE)
    # walls
    box(lo, 0, -31, hi, 7, -31, BRICK); box(lo, 0, 9, hi, 7, 9, BRICK)
    box(xi, 0, -31, xi, 7, 9, BRICK); box(xo, 0, -31, xo, 7, 9, BRICK)
    box(lo, 0, -31, hi, 0, -31, DARK); box(lo, 0, 9, hi, 0, 9, DARK)
    box(xi, 0, -31, xi, 0, 9, DARK); box(xo, 0, -31, xo, 0, 9, DARK)
    # corner piers
    for x in (lo, hi):
        for z in (-31, 9):
            box(x, 0, z, x, 8, z, DARK)
    # roof: ceiling y=8, parapet y=9; clerestory over the nave x = s*25..s*31, ceiling y=11
    box(lo, 8, -31, hi, 8, 9, WHITE)
    box(lo, 9, -31, hi, 9, 9, TILE_S)
    for x in (lo, hi): box(x, 9, -31, x, 9, 9, 'polished_deepslate_wall')
    for z in (-31, 9): box(lo, 9, z, hi, 9, z, 'polished_deepslate_wall')
    n0, n1 = sorted((s * 24, s * 32))
    box(n0 + 1, 8, -30, n1 - 1, 8, 8, 'air')
    for x in (n0, n1):
        box(x, 8, -31, x, 10, 9, DARK)
        for z0 in range(-29, 8, 6):
            box(x, 9, z0, x, 10, z0 + 3, GLASS_PANE)
    box(n0, 11, -31, n1, 11, 9, WHITE); box(n0, 12, -31, n1, 12, 9, DARK_S)
    for z0 in range(-28, 8, 9):
        box(n0 + 2, 11, z0, n1 - 2, 11, z0 + 2, SKY); box(n0 + 2, 12, z0, n1 - 2, 12, z0 + 2, 'air')
    for z in range(-28, 8, 6):
        box(n0 + 1, 10, z, n1 - 1, 10, z, BEAM_X)
    # exterior pilasters & windows on the outer wall
    for z0 in range(-28, 7, 6):
        box(xi, 2, z0, xi, 5, z0 + 2, GLASS_PANE)
    # entrance from the plaza (z = 3..7 in the inner wall) with portico
    box(xo, 0, 3, xo, 4, 7, 'air'); box(xo, 0, 3, xo, 0, 7, 'air')
    put(xo, -1, 3, DARK); box(xo, -1, 4, xo, -1, 6, WHITE); put(xo, -1, 7, DARK)
    box(xo, 5, 2, xo, 5, 8, DARK)
    px = s * 16
    for z in (2, 8): column(px, z, 5)
    box(px, 6, 2, px, 6, 8, WHITE); box(s * 15, 6, 1, s * 15, 6, 9, DARK_S)
    box(px, 6, 1, px, 6, 1, DARK_S); box(px, 6, 9, px, 6, 9, DARK_S)
    for z in (4, 6): put(px, 5, z, BR_LIGHT)
    # opening to the arcade / hall at the north wall (x = s*20..s*24)
    a0, a1 = sorted((s * 20, s * 24))
    box(a0, 0, 9, a1, 4, 9, 'air'); box(a0, -1, 9, a1, -1, 9, WHITE)
    # nave floor band and pilaster lines
    box(n0 + 1, -1, -30, n1 - 1, -1, 8, 'polished_diorite' if s < 0 else 'polished_andesite')
    box(n0 + 1, -1, -30, n0 + 1, -1, 8, DARK); box(n1 - 1, -1, -30, n1 - 1, -1, 8, DARK)
wing_shell(-1); wing_shell(1)

# arcades (回廊) linking wings and hall: z=10..12, x = ±17..±25
for side in (-1, 1):
    a0, a1 = sorted((side * 17, side * 25))
    box(a0, -1, 10, a1, -1, 12, WHITE)
    box(a0, 6, 10, a1, 6, 12, WHITE); box(a0, 7, 10, a1, 7, 12, DARK_S)
    for x in (side * 17, side * 21):
        column(x, 10, 5)
    box(a0, 5, 10, a1, 5, 10, DARK)
    put(side * 19, 6, 11, BR_LIGHT); put(side * 23, 6, 11, BR_LIGHT)
    box(a0, -1, 13, a1, -1, 13, TILE)

# ---------------------------------------------------------------- armory (武器展示室, west wing)
WEAPONS = [  # (model, name, subtitle, info id)
    ('yuua', 'ゆうあ', 'ピンク帯の麦わら帽子', 2), ('pichipichi', 'ぴちぴち', '冷凍さかな', 1),
    ('raji', 'lazi', '防音マイク付きマスク', 5), ('nero', 'ネロ', 'ペスト医師の杖', 7),
    ('killing', 'キリング', '呪いの「き」マスク', 4), ('yuttari', 'ゆったり', '瞬間奇襲アイテム', 3),
    ('hotchikisu', 'ほちきす', 'ホッチキス', 9), ('komame', 'こまめ', '小豆バー', 6),
    ('tayayuyu', 'たやゆゆ', '変態ガチャ', 10), ('itori', 'いとり', '昭心', 12),
    ('yu', 'ゆー', 'オーバーワーク', 8), ('furoball', 'ふろボール', '投てき武器', 11)]
SHOW_Z = [-26, -20, -14, -8, -2, 4]
for i, (model, name, subtitle, info) in enumerate(WEAPONS):
    row = 0 if i < 6 else 1
    z = SHOW_Z[i % 6] if row == 0 else SHOW_Z[5 - i % 6]
    px = -35 if row == 0 else -21          # pedestal column
    face = 'e' if row == 0 else 'w'        # display faces the nave
    wall = -38 if row == 0 else -18        # bay back wall
    # bay: pilasters, warm back panel, sconce, floor inlay
    for dz in (-2, 2): box(wall, 0, z + dz, wall, 6, z + dz, PILLAR)
    box(wall, 1, z - 1, wall, 5, z + 1, 'stripped_dark_oak_wood[axis=y]')
    put(wall, 6, z, BR_LIGHT); box(wall, 6, z - 1, wall, 6, z - 1, DARK); box(wall, 6, z + 1, wall, 6, z + 1, DARK)
    box(px - 1, -1, z - 1, px + 1, -1, z + 1, TILE); put(px, -1, z, DARK)
    put(px, 0, z, CAP)
    tx = px + (1 if face == 'e' else -1)
    put(tx, -1, z, BR_LIGHT)                      # floor uplight in front
    # weapon
    if model == 'furoball':
        p = {'scale': 1.0, 'translation': [0, 0.47, 0], 'left_rotation': [0, 0, 0, 1], 'top': 0.5}   # vanilla fire charge: centred 16px sprite
        p = dict(p); p['top'] = 0.5
    else:
        p = placement('oa:item/' + model, target=0.9 if model not in ('yuua', 'killing', 'raji') else 0.75, tilt=20)
    item(px + 0.5, 1.0, z + 0.5, oa_item(model), face, p, tags=['oa.exhibit.' + str(info)])
    meta['exhibits'].append({'model': model, 'x': px + 0.5, 'z': z + 0.5, 'top': 1.0 + p['top'], 'scale': p['scale'], 'translation': p['translation']})
    # name plate on the back wall, same Z axis as the pedestal
    nx = wall + (1.02 if face == 'e' else -0.02)
    text(nx, 3.55, z + 0.5, {'text': name, 'color': 'gold', 'bold': True}, face, 1.15, width=160)
    text(nx, 3.1, z + 0.5, {'text': subtitle, 'color': 'white'}, face, 0.62, width=200)
    interaction(px + 0.5, 0, z + 0.5, 1.0, round(1.0 + p['top'] + 0.12, 2), 'exhibit.' + str(info), name)
# overhead pendant lights along the nave
for z in range(-27, 8, 6):
    for x in (-30, -26):
        put(x, 10, z, BR_LIGHT)
# practice gate at the south end (z=-31 wall): arch + console
box(-31, 0, -31, -25, 6, -31, BRICK)
box(-30, 1, -31, -26, 5, -31, 'cyan_stained_glass')
for x in (-31, -25): box(x, 0, -30, x, 6, -30, PILLAR)
box(-31, 7, -30, -25, 7, -30, DARK); box(-30, 6, -30, -26, 6, -30, WHITE_T)
for x in (-29, -27): put(x, 6, -29, 'air')
console(-28, -28, 's', '練習場', '荷物を預けて入場', 'practice', 'target')
put(-30, -1, -29, BR_LIGHT); put(-26, -1, -29, BR_LIGHT)
text(-27.5, 5.0, -30.45, [{'text': '練習場ゲート\n', 'color': 'aqua', 'bold': True}, {'text': '展示の武器をすぐ試せます', 'color': 'white'}], 's', 1.1, width=260)
# wing title over the plaza portico
text(-15.45, 7.35, 5.5, [{'text': '武器展示室\n', 'color': 'aqua', 'bold': True}, {'text': '固有武器・練習場', 'color': 'white'}], 'e', 1.3, width=260)

# ---------------------------------------------------------------- records gallery (戦績ギャラリー, east wing)
# podium for the latest match (south end): 2nd | 1st | 3rd, centred on x=28
box(24, -1, -29, 32, -1, -26, TILE)
box(27, 0, -29, 29, 1, -27, 'gold_block'); box(24, 0, -29, 26, 0, -27, 'iron_block'); box(30, 0, -29, 32, 0, -27, 'waxed_copper_block')
box(27, 2, -29, 29, 2, -29, 'air')
box(23, 0, -30, 33, 9, -30, DARK); box(24, 2, -30, 32, 8, -30, 'black_concrete')
for x in (23, 33): box(x, 0, -29, x, 8, -29, PILLAR)
box(23, 9, -29, 33, 9, -29, DARK_S)
for x in (25, 28, 31): put(x, 9, -30, BR_LIGHT)
for x in (25, 28, 31): put(x, -1, -25, BR_LIGHT)
text(28.5, 7.35, -29.45, [{'text': '前回のバトルロワイヤル', 'color': 'gold', 'bold': True}], 's', 1.6, width=300)
text(28.5, 6.75, -29.45, {'text': '記録なし', 'color': 'gray'}, 's', 0.9, tags=['oa.gallery.last_title'], width=400)
for x, h, tag in ((28.5, 2.0, 'oa.gallery.p1'), (25.5, 1.0, 'oa.gallery.p2'), (31.5, 1.0, 'oa.gallery.p3')):
    text(x, h + 0.35, -27.5, {'text': '—', 'color': 'gray'}, 's', 0.9, tags=[tag], width=150)
text(28.5, 3.9, -29.45, {'text': '', 'color': 'white'}, 's', 0.62, tags=['oa.gallery.last_rows'], width=420)
# ranking boards on the east wall (face west), achievements on the west wall (face east)
def board(x_wall, zc, face, title, tag, col):
    s = 1 if face == 'w' else -1      # wall at +x when facing west
    box(x_wall, 1, zc - 3, x_wall, 6, zc + 3, DARK)
    box(x_wall, 2, zc - 2, x_wall, 5, zc + 2, 'black_concrete')
    put(x_wall, 7, zc, BR_LIGHT); put(x_wall, 7, zc - 2, DARK); put(x_wall, 7, zc + 2, DARK)
    put(x_wall - s, -1, zc, BR_LIGHT)
    tx = x_wall - s * 0.53 + (0.5 if s < 0 else 0.5)
    tx = (x_wall + 0.5) - s * 0.52
    text(tx, 5.0, zc + 0.5, [{'text': title, 'color': col, 'bold': True}], face, 1.45, width=300)
    text(tx, 2.35, zc + 0.5, {'text': 'まだ記録がありません', 'color': 'gray'}, face, 0.8, tags=[tag], width=300)
board(38, -19, 'w', '優勝ランキング', 'oa.gallery.wins', 'gold')
board(38, -8, 'w', 'キルランキング', 'oa.gallery.kills', 'red')
board(18, -14, 'e', '実績ランキング', 'oa.gallery.ach', 'green')
# champion spotlight (most wins overall) above the podium wall top
# my-records terminal near the entrance, facing the door
console(28, 2, 's', '自分の戦績', '戦績・実績を開く', 'records', 'gold_block', 'gold')
for z in range(-27, 8, 6):
    for x in (26, 30):
        put(x, 10, z, BR_LIGHT)
text(15.45 + 0.1, 7.35, 5.5, [{'text': '戦績ギャラリー\n', 'color': 'gold', 'bold': True}, {'text': 'ランキング・前回の結果', 'color': 'white'}], 'w', 1.3, width=260)
# gallery banners between boards (decor)
for z in (-25, -1):          # on the pilasters (solid wall behind)
    put(38, 5, z, 'yellow_wall_banner[facing=west]'); put(18, 5, z, 'yellow_wall_banner[facing=east]')

# ---------------------------------------------------------------- outer gardens (front corners and sides)
for side in (-1, 1):
    for z in (18, 26, 34):
        tree(side * 33, z, 5)
    for z in (16, 30):
        lamp_post(side * 29, z)
    for z in (-36, -34):
        pass
    tree(side * 28, -36, 4); tree(side * 36, -35, 4)
    lamp_post(side * 22, -35); lamp_post(side * 34, 12)
    # paved path from the plaza along the arcade front to the garden
    a0, a1 = sorted((side * 26, side * 38))
    box(a0, -1, 11, a1, -1, 12, 'calcite')
for x in range(-20, 21, 10): lamp_post(x, 38) if abs(x) > 5 else None
box(-24, -1, 36, 24, -1, 37, 'calcite')
for x in (-12, 0, 12): tree(x, 38, 4)


# ---------------------------------------------------------------- facades: white upper walls, dark base & pilasters
for side in (-1, 1):
    lo, hi = sorted((side * 17, side * 39))
    for (a, b2, c, d) in ((lo, -31, hi, -31), (lo, 9, hi, 9), (side * 39, -31, side * 39, 9), (side * 17, -31, side * 17, 9)):
        repl(a, 1, b2, c, 6, d, BRICK, WHITE)
    # pilasters every 6 on the long walls (flush), dark band under the cornice
    for z in range(-31, 10, 6):
        for x in (side * 17, side * 39):
            repl(x, 1, z, x, 6, z, WHITE, TILE)
    for x in range(lo, hi + 1, 6):
        for z in (-31, 9):
            repl(x, 1, z, x, 6, z, WHITE, TILE)
    repl(lo, 7, -31, hi, 7, 9, BRICK, DARK)
    # plaza-side windows into the wings (between pilasters, clear of the doorway z=3..7)
    for z0 in (-29, -23, -17, -11, -5):
        repl(side * 17, 2, z0, side * 17, 4, z0 + 2, WHITE, GLASS_PANE)
    # hall side walls
    repl(side * 25, 1, 13, side * 25, 9, 35, BRICK, WHITE)
repl(-25, 1, 35, 25, 9, 35, BRICK, WHITE)
for x in range(-24, 25, 6):
    repl(x, 1, 35, x, 9, 35, WHITE, TILE)

# ---------------------------------------------------------------- lighting pass (visible fixtures)
def inlay(x, z, light=BR_LIGHT):
    put(x, -1, z, light)
# plaza grid intersections and border
for x in (-10, -5, 5, 10):
    for z in (-5, 0):
        inlay(x, z)
for x in (-10, 10):
    for z in (5, 10):
        inlay(x, z)
for z in (-9, 11):
    for x in (-5, 5):
        inlay(x, z)
# hall: column bands and nave lanes
for side in (-1, 1):
    for z in (16, 22, 28):
        inlay(side * 9, z, BR_LIGHT)
    for z in (20, 24, 28, 32):
        inlay(side * 4, z)
    for z in (26, 30):
        inlay(side * 12, z, BR_LIGHT if side > 0 else TDM_LIGHT); inlay(side * 22, z, BR_LIGHT if side > 0 else TDM_LIGHT)
    inlay(side * 23, 18, BR_LIGHT if side > 0 else TDM_LIGHT); inlay(side * 23, 31, BR_LIGHT if side > 0 else TDM_LIGHT)
# pendant lanterns from the nave beams (supported by chains)
for z in (16, 22, 28):
    for x in (-3, 3):
        lantern_hang(x, z, 15, 6)
# wings: nave centre line, aisles beside the bays
for side in (-1, 1):
    for z in range(-29, 9, 4):
        inlay(side * 28, z)
# arcades
for side in (-1, 1):
    inlay(side * 19, 11); inlay(side * 23, 11)
# garden paths
for z in (-12, -17, -27, -32, -37):
    inlay(-4, z); inlay(4, z)


# gallery aisles and plaza edges
for x in (21, 35):
    for z in (-25, -19, -13, -7, -1, 5):
        inlay(x, z)
for side in (-1, 1):
    for z in (-7, 1, 9):
        inlay(side * 13, z) if z != 9 else None


def bollard(x, z):
    put(x, 0, z, 'polished_deepslate_wall'); put(x, 1, z, 'lantern[hanging=false]')
for side in (-1, 1):
    bollard(side * 9, -12); bollard(side * 23, -37)

# ======================================================================= post-process
# Connection states for panes / fences / walls computed from the final neighbours.
CONNECT_NONFULL = ('slab', 'stairs', 'fence', 'wall', 'pane', 'bars', 'trapdoor', 'lantern', 'chain', 'button', 'carpet', 'banner',
                   'leaves', 'azalea', 'glass_pane', 'water', 'air', 'light', 'bulb')
def is_full(b):
    n = base(b)
    if n in ('air', 'water'): return False
    if n in ('sea_lantern',): return True
    return not any(k in n for k in ('slab', 'stairs', 'fence', 'wall', 'pane', 'bars', 'trapdoor', 'lantern', 'chain', 'button',
                                    'carpet', 'banner', 'leaves', 'azalea', 'grate'))
def is_wallblock(n): return n.endswith('_wall') and 'banner' not in n
def connects(kind, nb):
    n = base(nb)
    if kind == 'pane': return n.endswith('pane') or n.endswith('glass') or n == 'iron_bars' or is_full(nb)
    if kind == 'fence': return n.endswith('fence') or n.endswith('fence_gate') or is_full(nb)
    if kind == 'wall': return is_wallblock(n) or is_full(nb) or n.endswith('pane')
fixes = []
for (x, y, z), b in list(blocks.items()):
    n = base(b)
    kind = 'pane' if n.endswith('pane') else 'fence' if n.endswith('fence') else 'wall' if is_wallblock(n) else None
    if not kind: continue
    c = {d: connects(kind, at(x + dx, y, z + dz)) for d, (dx, dz) in {'north': (0, -1), 'south': (0, 1), 'east': (1, 0), 'west': (-1, 0)}.items()}
    if kind == 'wall':
        above = at(x, y + 1, z)
        tall = is_full(above) or is_wallblock(base(above))
        props = {d: ('tall' if tall else 'low') if v else 'none' for d, v in c.items()}
        straight = (c['north'] and c['south'] and not c['east'] and not c['west']) or (c['east'] and c['west'] and not c['north'] and not c['south'])
        props['up'] = 'false' if straight and not (is_wallblock(base(above))) else 'true'
        props['waterlogged'] = 'false'
    else:
        props = {d: 'true' if v else 'false' for d, v in c.items()}
        props['waterlogged'] = 'false'
    nb = n + '[' + ','.join(f'{k}={v}' for k, v in sorted(props.items())) + ']'
    blocks[x, y, z] = nb
    fixes.append((x, y, z, nb))

# ======================================================================= checks
OPAQUE_SKIP = ('glass', 'leaves', 'slab', 'stairs', 'fence', 'wall', 'pane', 'bars', 'trapdoor', 'lantern', 'chain', 'button', 'carpet',
               'banner', 'azalea', 'water', 'light', 'grate', 'copper_bulb')
LIGHT = {'sea_lantern': 15, 'shroomlight': 15, 'lantern': 15, 'glowstone': 15, 'ochre_froglight': 15, 'pearlescent_froglight': 15,
         'waxed_copper_bulb': 15, 'end_rod': 14, 'soul_lantern': 10}
def opaque(b):
    n = base(b)
    if n in ('air',): return False
    return not any(k in n for k in OPAQUE_SKIP) and n not in LIGHT
def solid_floor(b):
    n = base(b)
    return n not in ('air', 'water', 'light') and 'carpet' not in n and 'banner' not in n and 'button' not in n
def passable(b):
    n = base(b)
    return n in ('air', 'light', 'azalea_flower') or 'carpet' in n or 'banner' in n or n in ('short_grass',)

# block light (BFS, 15 at source, -1 per step through non-opaque cells)
X0, X1, Y0, Y1 = -LIM, LIM, YMIN, YMAX
lvl = {}
q = deque()
for p, b in blocks.items():
    v = LIGHT.get(base(b))
    if v and 'lit=false' not in b:
        lvl[p] = v; q.append(p)
while q:
    p = q.popleft(); v = lvl[p] - 1
    if v <= 0: continue
    x, y, z = p
    for dx, dy, dz in ((1, 0, 0), (-1, 0, 0), (0, 1, 0), (0, -1, 0), (0, 0, 1), (0, 0, -1)):
        n = (x + dx, y + dy, z + dz)
        if not (X0 <= n[0] <= X1 and Y0 <= n[1] <= Y1 and X0 <= n[2] <= X1): continue
        if opaque(at(*n)): continue
        if lvl.get(n, 0) < v:
            lvl[n] = v; q.append(n)

# walkable cells at y=0 (feet), floor at y=-1, 2 blocks of headroom (3 on main routes)
def walk_ok(x, z, head=2):
    return solid_floor(at(x, -1, z)) and all(passable(at(x, y, z)) for y in range(0, head))
start = (0, 5)
seen = {start}; q = deque([start])
while q:
    x, z = q.popleft()
    for dx, dz in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        n = (x + dx, z + dz)
        if n in seen or not (-39 <= n[0] <= 39 and -39 <= n[1] <= 39): continue
        if walk_ok(*n):
            seen.add(n); q.append(n)
reach = seen

# 1) main approach: 7 wide from arrival to the hall, headroom 3
for x in range(-3, 4):
    for z in range(0, 21):
        if z >= 13 and abs(x) > 3: continue
        assert walk_ok(x, z, 3), ('main approach blocked', x, z, at(x, -1, z), [at(x, y, z) for y in range(3)])
# 2) every console / exhibit / interaction has a reachable standing cell right in front of it
problems = []
for it in meta['interactions']:
    cx, cz = (it['x0'] + it['x1']) / 2, (it['z0'] + it['z1']) / 2
    bx, bz = math.floor(cx), math.floor(cz)
    ok = False
    for dx, dz in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        if (bx + dx, bz + dz) in reach: ok = True
    if not ok: problems.append(('unreachable', it['label'], bx, bz))
assert not problems, problems
# 3) interactions never overlap
ints = meta['interactions']
for i in range(len(ints)):
    for j in range(i + 1, len(ints)):
        a, b = ints[i], ints[j]
        if a['x0'] < b['x1'] and b['x0'] < a['x1'] and a['z0'] < b['z1'] and b['z0'] < a['z1'] and a['y0'] < b['y1'] and b['y0'] < a['y1']:
            raise AssertionError(('interaction overlap', a['label'], b['label']))
# 4) consoles: desk / screen / cap stacked, standing cell in front reachable and lit
for x, z, face, action in CONSOLES:
    dx, dz = DIR[face]
    assert (x + dx, z + dz) in reach, ('console not reachable', action)
    assert lvl.get((x + dx, 0, z + dz), 0) >= 13, ('console approach dark', action, lvl.get((x + dx, 0, z + dz), 0))
# 5) lighting at every reachable cell (feet level) – no dark corners

def compute_light():
    lv = {}
    qq = deque()
    for p_, b_ in blocks.items():
        v_ = LIGHT.get(base(b_))
        if v_: lv[p_] = v_; qq.append(p_)
    while qq:
        p_ = qq.popleft(); v_ = lv[p_] - 1
        if v_ <= 0: continue
        x_, y_, z_ = p_
        for dx_, dy_, dz_ in ((1, 0, 0), (-1, 0, 0), (0, 1, 0), (0, -1, 0), (0, 0, 1), (0, 0, -1)):
            n_ = (x_ + dx_, y_ + dy_, z_ + dz_)
            if not (X0 <= n_[0] <= X1 and Y0 <= n_[1] <= Y1 and X0 <= n_[2] <= X1): continue
            if opaque(at(*n_)): continue
            if lv.get(n_, 0) < v_: lv[n_] = v_; qq.append(n_)
    return lv
AUTO = []
for _round in range(12):
    need = [(lvl.get((x, 0, z), 0), x, z) for x, z in reach
            if lvl.get((x, 0, z), 0) < (7 if base(at(x, -1, z)) == 'grass_block' else 9)]
    if not need: break
    need.sort()
    taken = []
    for v, x, z in need:
        if any(abs(x - a) + abs(z - b) < 7 for a, b in taken): continue
        # keep fixtures off the 7-wide main approach and away from walls/doors: snap to an even grid
        gx, gz = x - (x % 2), z - (z % 2)
        def okb(a, c):
            return base(at(a, -1, c)) == 'grass_block' and all(passable(at(a + dx, y, c + dz)) for dx in (-1, 0, 1) for dz in (-1, 0, 1) for y in (0, 1))
        placed = False
        for mx in sorted({gx, -gx}):              # mirror across X so the gardens stay symmetric
            if okb(mx, gz):
                put(mx, 0, gz, 'polished_deepslate_wall'); put(mx, 1, gz, 'lantern[hanging=false]')
                blocks[mx, 0, gz] = 'polished_deepslate_wall[east=none,north=none,south=none,up=true,waterlogged=false,west=none]'
                fixes.append((mx, 0, gz, blocks[mx, 0, gz]))
                AUTO.append(('bollard', mx, gz)); placed = True; taken.append((mx, gz))
        if not placed:
            for mx in sorted({x, -x}):
                if base(at(mx, -1, z)) != 'grass_block' and solid_floor(at(mx, -1, z)) and base(at(mx, -1, z)) not in LIGHT:
                    put(mx, -1, z, BR_LIGHT); AUTO.append(('inlay', mx, z)); placed = True; taken.append((mx, z))
        if not placed: continue
    lvl = compute_light()
    seen = {start}; q = deque([start])
    while q:
        x, z = q.popleft()
        for dx, dz in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            n = (x + dx, z + dz)
            if n in seen or not (-39 <= n[0] <= 39 and -39 <= n[1] <= 39): continue
            if walk_ok(*n): seen.add(n); q.append(n)
    reach = seen

dark = sorted(((lvl.get((x, 0, z), 0), x, z) for x, z in reach))
low = [d for d in dark if d[0] < (7 if base(at(d[1], -1, d[2])) == 'grass_block' else 9)]
FAIL = []
if low: FAIL.append(('dark cells', low[:12], len(low)))
# 6) nothing floats: every non-air block above the ground is supported (below, or by a neighbour for hanging/attached parts)
HANGING = ('chain', 'lantern', 'banner', 'leaves', 'azalea_leaves', 'button')
floating = []
for (x, y, z), b in blocks.items():
    if y <= -1: continue
    n = base(b)
    if any(k in n for k in ('leaves',)): continue
    if at(x, y - 1, z) != 'air': continue
    if 'lantern' in n and 'hanging=true' in b and base(at(x, y + 1, z)) == 'iron_chain': continue
    if n == 'iron_chain' and at(x, y + 1, z) != 'air': continue
    if is_full(b) and at(x, y + 1, z) != 'air': continue      # recessed into a ceiling / beam above
    if 'wall_banner' in n:
        fdx, fdz = {'north': (0, -1), 'south': (0, 1), 'east': (1, 0), 'west': (-1, 0)}[b.split('facing=')[1].split(',')[0].rstrip(']')]
        if not is_full(at(x - fdx, y, z - fdz)): floating.append((x, y, z, b + ' (no wall behind)'))
        continue
    # attached sideways to something solid (beams, slabs, roof decks)
    if any(at(x + dx, y, z + dz) != 'air' for dx, dz in ((1, 0), (-1, 0), (0, 1), (0, -1))): continue
    floating.append((x, y, z, b))
if floating: FAIL.append(('floating blocks', floating[:12], len(floating)))
# 7) desks: icon sits exactly on the desk top (y=1.5) — enforced by construction; exhibits on pedestal top (y=1.0)
for e in meta['exhibits']:
    assert abs(e['x'] % 1 - 0.5) < 1e-9 and abs(e['z'] % 1 - 0.5) < 1e-9, e

# ======================================================================= write
KILL = ['oa.lobby_label', 'oa.lobby_exhibit', 'oa.terminal', 'oa.button_lobby', 'oa.button_mapsel', 'oa.map_native1981', 'oa.map_panel1116',
        'tdm.station', 'oa.gallery', 'oa.board_stats', 'oa.board_last', 'oa.board_ach', 'oa.rank_holo', 'oa.practice_entry']
def kill_lines():
    # Only inside this lobby's envelope (box from -41..41, y -4..46).
    return [f'execute positioned ~-41 ~-4 ~-41 run kill @e[tag={t},type=!minecraft:player,dx=82,dy=50,dz=82]' for t in KILL]

head = ['# Generated by scripts/gen_lobby_terminal.py (OA 出撃ターミナル v%d); do not edit.' % VER]
build = head + kill_lines()
for (x1, y1, z1, x2, y2, z2, b) in ops:
    if (x1, y1, z1) == (x2, y2, z2): build.append(f'setblock ~{x1} ~{y1} ~{z1} minecraft:{b}')
    else: build.append(f'fill ~{x1} ~{y1} ~{z1} ~{x2} ~{y2} ~{z2} minecraft:{b}')
for (x, y, z, b) in fixes:
    build.append(f'setblock ~{x} ~{y} ~{z} minecraft:{b}')
build += ['function oa:lobby/terminal/entities',
          'data modify storage oa:lobby tdm_station set value 1b',
          'data modify storage oa:lobby optout_pad set value 1b',
          'data remove storage oa:lobby board_built',
          'data remove storage oa:lobby board_at']
(OUT / 'build.mcfunction').write_text('\n'.join(build) + '\n', encoding='utf-8')
(OUT / 'entities.mcfunction').write_text('\n'.join(head + kill_lines() + ents) + '\n', encoding='utf-8')

# reports for the validation json / preview
work = ROOT / 'work'; work.mkdir(exist_ok=True)
(work / 'lobby-terminal-blocks.json').write_text(json.dumps([[*k, v] for k, v in blocks.items()]), encoding='utf-8')
report = {'version': VER, 'commands': len(build), 'entity_commands': len(ents), 'blocks': len(blocks), 'texts': meta['texts'], 'items': meta['items'],
          'interactions': meta['interactions'], 'exhibits': meta['exhibits'], 'reachable_cells': len(reach),
          'min_block_light_walkable': dark[0][0], 'auto_fixtures': AUTO, 'light_histogram': {str(v): sum(1 for d in dark if d[0] == v) for v in range(0, 16)}}
(work / 'lobby-terminal-report.json').write_text(json.dumps(report, ensure_ascii=False, indent=1), encoding='utf-8')
print(f'Terminal v{VER}: {len(build)} build commands, {len(ents)} entities ({meta["texts"]} text, {meta["items"]} item, {len(meta["interactions"])} interaction), '
      f'{len(blocks)} blocks, {len(reach)} walkable cells, min light {dark[0][0]}')
light_dump = {f'{x},{z}': lvl.get((x, 0, z), 0) for x, z in reach}
(work / 'lobby-terminal-light.json').write_text(json.dumps(light_dump), encoding='utf-8')
if FAIL and '--no-check' not in sys.argv:
    raise SystemExit('CHECK FAILED: ' + repr(FAIL))
