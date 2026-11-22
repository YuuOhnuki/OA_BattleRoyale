#!/usr/bin/env python3
"""OA Battle Royale 1.9.230: 浮遊島マップ2種類の生成（天空都市 sky ＝ oa:br_sky、異界 end ＝ oa:br_end）。
使い方: py -3 scripts/build_map_float.py <repo root> sky|end [--png 出力PNG]

洞窟（build_map_cave.py）と同じく、会場を 100 区画のタイル関数（data/oa/function/maps/<key>/tiles/{preload,wait,release,apply,place}/N）に
書き出し、管理者の「会場を生成／再生成」（oa:map/do {key:"sky"|"end",op:"create"|"rebuild"}）が1区画ずつ置いて、チェスト・鉱石を登録する。

毎回の生成で変わるところ（「スロット」方式）：
- 外周の8つの島（スロット）は、形と位置・橋は固定で、上に載るもの（島の種類・建物・チェスト・開始地点・地点の名前）を
  生成のたびに3種類から抽選する（maps/<key>/roll。#sv0〜#sv7 oa.map2）。橋・島の土台は固定なので、どの組み合わせでも
  中央へ必ず2本以上の道がある（中央への橋＋左右の島への橋）。
- 試合のあとに自動で作り直す（プラグインの map/MapRerollService）。手作業で保存した会場（/oaplugin map save）があればそちらが優先。

座標は中心(0,0)基準 x,z∈[-152,152]、y∈[-40,40]（会場の原点 y=80 に置く。島の上面 y=0 ＝絶対80、立ち位置は絶対81）。
特殊な仕掛けはマーカー（タグ oa.gim）で置き、動きはプラグイン（map/MapGimmickService）：
- oa.gim_tp_<dx>_<dy>_<dz>：転移装置（マーカーからの相対位置へ。双方向は2つ置く）
- oa.gim_up_<h>：上昇気流（マーカーから高さ h まで持ち上げる。島の下の救済用の足場から）
- oa.gim_grav_<r>：重力異常エリア（半径 r。異界のみ）
- oa.gim_warp：空間の歪みの演出（紫の粒・音。異界のみ）
ジャンプ台は既存のもの（石の感圧板＋下にレンガ。jumppad 名前空間）。
"""
import sys, os, re, glob, json, math
import numpy as np

ROOT = sys.argv[1]
KEY = sys.argv[2]
assert KEY in ('sky', 'end')
PNG = sys.argv[sys.argv.index('--png') + 1] if '--png' in sys.argv else None
DIM = {'sky': 'oa:br_sky', 'end': 'oa:br_end'}[KEY]
LABEL = {'sky': '天空都市', 'end': '異界'}[KEY]
OUT = f"{ROOT}/data/oa/function/maps/{KEY}/tiles"
SRC = f"{ROOT}/data/oa/function/map/internal/tiles"
SEED = {'sky': 20261123, 'end': 20261124}[KEY]
rng = np.random.default_rng(SEED)
N = 305; OFF = 152; Y0 = -40; NY = 81; TOP = 40
NSLOT = 8; NVAR = 3

# ======================================================================== 材料（テーマ）
if KEY == 'sky':
    T = dict(top='minecraft:grass_block', sub='minecraft:dirt', rock='minecraft:stone', rock2='minecraft:andesite', under='minecraft:tuff',
             wall='minecraft:stone_bricks', wall2='minecraft:mossy_stone_bricks', trim='minecraft:polished_andesite', floor='minecraft:smooth_stone',
             roof='minecraft:dark_oak_planks', roof_st='minecraft:dark_oak_stairs', light='minecraft:lantern', glass='minecraft:glass_pane',
             pillar='minecraft:quartz_pillar', path='minecraft:dirt_path', fence='minecraft:oak_fence', wallblk='minecraft:stone_brick_wall',
             wood='minecraft:oak_planks', log='minecraft:oak_log', leaves='minecraft:oak_leaves[persistent=true]', slab='minecraft:stone_brick_slab',
             accent='minecraft:gold_block', tp_pad='minecraft:crying_obsidian', ore_host='minecraft:stone')
else:
    T = dict(top='minecraft:end_stone', sub='minecraft:end_stone', rock='minecraft:end_stone', rock2='minecraft:end_stone_bricks', under='minecraft:obsidian',
             wall='minecraft:end_stone_bricks', wall2='minecraft:purpur_block', trim='minecraft:purpur_pillar', floor='minecraft:end_stone_bricks',
             roof='minecraft:purpur_block', roof_st='minecraft:purpur_stairs', light='minecraft:end_rod', glass='minecraft:purple_stained_glass_pane',
             pillar='minecraft:obsidian', path='minecraft:end_stone_bricks', fence='minecraft:end_stone_brick_wall', wallblk='minecraft:end_stone_brick_wall',
             wood='minecraft:purpur_block', log='minecraft:purpur_pillar', leaves='minecraft:chorus_flower[age=5]', slab='minecraft:end_stone_brick_slab',
             accent='minecraft:amethyst_block', tp_pad='minecraft:crying_obsidian', ore_host='minecraft:end_stone')

# ======================================================================== 格子
pal = ['minecraft:air']; pid = {'minecraft:air': 0}
def P(b):
    if b not in pid: pid[b] = len(pal); pal.append(b)
    return pid[b]

class Canvas:
    """ブロックを置く面。base は会場全体、スロットの種類（variant）はスロットの範囲だけ。"""
    def __init__(self, x1, z1, x2, z2):
        self.x1, self.z1, self.x2, self.z2 = x1, z1, x2, z2
        self.g = np.zeros((x2 - x1 + 1, z2 - z1 + 1, NY), np.uint16)
        self.chests = []; self.riches = []; self.ores = []; self.spawns = []; self.gims = []; self.places = []
    def inb(self, x, z): return self.x1 <= x <= self.x2 and self.z1 <= z <= self.z2
    def put(self, x, y, z, b):
        if self.inb(x, z) and Y0 <= y <= TOP: self.g[x - self.x1, z - self.z1, y - Y0] = P(b)
    def get(self, x, y, z):
        if self.inb(x, z) and Y0 <= y <= TOP: return pal[self.g[x - self.x1, z - self.z1, y - Y0]]
        return None

base = Canvas(-OFF, -OFF, OFF, OFF)
cur = base   # 今書いている面（スロットの種類を作るときに切り替える）
RES = set()  # スロットの中身が触らない柱（橋の付け根・転移装置）
def put(x, y, z, b):
    if cur is not base:
        if (x, z) in RES: return
        if b == 'minecraft:air': b = 'minecraft:cave_air'   # 土台を削る（0 は「何も置かない」）
    cur.put(x, y, z, b)
def getb(x, y, z):
    """今の面（なければ base）のブロック。スロットの面では base と重ねて見る。"""
    if cur is not base:
        v = cur.get(x, y, z)
        if v == 'minecraft:cave_air': return 'minecraft:air'
        if v is not None and v != 'minecraft:air': return v
    v = base.get(x, y, z)
    return 'minecraft:air' if v is None else v
def reserve(x, z, rad):
    for dx in range(-rad, rad + 1):
        for dz in range(-rad, rad + 1): RES.add((round(x) + dx, round(z) + dz))
def box(x1, y1, z1, x2, y2, z2, b):
    for x in range(min(x1, x2), max(x1, x2) + 1):
        for z in range(min(z1, z2), max(z1, z2) + 1):
            for y in range(min(y1, y2), max(y1, y2) + 1): put(x, y, z, b)
def hollow(x1, y1, z1, x2, y2, z2, b):
    box(x1, y1, z1, x2, y2, z1, b); box(x1, y1, z2, x2, y2, z2, b); box(x1, y1, z1, x1, y2, z2, b); box(x2, y1, z1, x2, y2, z2, b)
def clear(x1, y1, z1, x2, y2, z2): box(x1, y1, z1, x2, y2, z2, 'minecraft:air')
def chest(x, y, z, rich=False, face='north'):
    put(x, y, z, f'minecraft:chest[facing={face}]')
    if (cur.get(x, y, z) or '').startswith('minecraft:chest'): (cur.riches if rich else cur.chests).append((x, y, z))
def ore(x, y, z, k):
    b = 'minecraft:coal_ore' if k == 1 else 'minecraft:redstone_ore'; put(x, y, z, b)
    if cur.get(x, y, z) == b: cur.ores.append((x, y, z, k))
def drop_overwritten():
    """あとから別のブロックで上書きされたチェスト・鉱石を一覧から外す。"""
    cur.chests[:] = [c for c in cur.chests if (cur.get(*c) or '').startswith('minecraft:chest')]
    cur.riches[:] = [c for c in cur.riches if (cur.get(*c) or '').startswith('minecraft:chest')]
    cur.ores[:] = [o for o in cur.ores if cur.get(o[0], o[1], o[2]) in ('minecraft:coal_ore', 'minecraft:redstone_ore')]
def gim(x, y, z, tags): cur.gims.append((x, y, z, tags))
def place_name(x, z, name): cur.places.append((x, z, name))

def smooth(scale, seed, n=N):
    r = np.random.default_rng(seed); k = n // scale + 3; a = r.random((k, k))
    xs = np.linspace(0, k - 3, n); i = xs.astype(int); f = xs - i
    return (a[i][:, i] * (1 - f)[:, None] * (1 - f)[None, :] + a[i + 1][:, i] * f[:, None] * (1 - f)[None, :]
            + a[i][:, i + 1] * (1 - f)[:, None] * f[None, :] + a[i + 1][:, i + 1] * f[:, None] * f[None, :])
NOISE = smooth(12, SEED + 1)
def nz(x, z): return NOISE[(x + OFF) % N, (z + OFF) % N]

# ======================================================================== 島
ISLANDS = []   # (cx, cz, r, kind)
def island(cx, cz, r, depth, top=0, wob=0.18):
    """上面が平らな浮遊島（上面 y=top）。下へいくほど細くなる。縁は少しでこぼこ。"""
    for x in range(int(cx - r * 1.3) - 1, int(cx + r * 1.3) + 2):
        for z in range(int(cz - r * 1.3) - 1, int(cz + r * 1.3) + 2):
            d = math.hypot(x - cx, z - cz) / (r * (1 + wob * (nz(x, z) - 0.5) * 2))
            if d > 1: continue
            put(x, top, z, T['top'])
            for y in range(top - 1, top - 3, -1): put(x, y, z, T['sub'])
            bottom = top - 2 - int(depth * math.sqrt(max(0.0, 1 - d * d)) * (0.75 + 0.5 * nz(z, x)))
            for y in range(top - 3, bottom - 1, -1):
                put(x, y, z, T['under'] if y < top - depth * 0.6 else (T['rock2'] if nz(x + y, z) > 0.62 else T['rock']))
    ISLANDS.append((cx, cz, r))

def on_island(x, z, margin=0.0):
    return any(math.hypot(x - cx, z - cz) <= r - margin for cx, cz, r in ISLANDS)

# ======================================================================== 橋
BRIDGES = []
def bridge(ax, az, bx, bz, kind, y=0):
    """(ax,az)→(bx,bz) の橋。島の縁から縁まで。歩く面は y（=島の上面）。種類：stone 幅4・wood 幅3・rope 幅2・broken 幅3（1マスの切れ目あり、跳べば渡れる）"""
    L = math.hypot(bx - ax, bz - az); n = int(L * 2) + 1
    ux, uz = (bx - ax) / L, (bz - az) / L; px, pz = -uz, ux
    w = {'stone': 4, 'wood': 3, 'rope': 2, 'broken': 3}[kind]
    deck = {'stone': T['wall'], 'wood': T['wood'] if KEY == 'sky' else T['wall'], 'rope': 'minecraft:spruce_planks' if KEY == 'sky' else T['wall2'],
            'broken': T['wall2']}[kind]
    rail = {'stone': T['wallblk'], 'wood': T['fence'], 'rope': T['fence'], 'broken': None}[kind]
    for i in range(n):
        t = i / (n - 1); cx_, cz_ = ax + (bx - ax) * t, az + (bz - az) * t
        seg = int(t * L)
        if kind == 'broken' and seg % 9 == 4 and 3 < t * L < L - 3: continue   # 1マスの切れ目
        for k in np.linspace(-(w - 1) / 2, (w - 1) / 2, w * 2):
            x, z = round(cx_ + px * k), round(cz_ + pz * k)
            if getb(x, y, z) == T['top']: continue
            put(x, y, z, deck)
            if kind == 'stone': put(x, y - 1, z, T['trim'])
        if rail:
            for sgn in (-1, 1):
                x, z = round(cx_ + px * sgn * (w / 2 + 0.5)), round(cz_ + pz * sgn * (w / 2 + 0.5))
                if getb(x, y, z) == T['top'] or on_island(x, z, -0.5): continue
                if getb(x, y, z) == 'minecraft:air': put(x, y + 1, z, rail); put(x, y, z, deck)
        if kind in ('stone', 'wood') and seg % 12 == 6:
            for sgn in (-1, 1):
                x, z = round(cx_ + px * sgn * (w / 2 + 0.5)), round(cz_ + pz * sgn * (w / 2 + 0.5))
                if getb(x, y + 1, z) == rail: put(x, y + 2, z, T['light'] if KEY == 'end' else 'minecraft:lantern')
    reserve(ax, az, 4); reserve(bx, bz, 4)
    BRIDGES.append(((ax, az), (bx, bz), kind))

def edge_point(cx, cz, r, tx, tz, inset=6.0):
    d = math.hypot(tx - cx, tz - cz); return cx + (tx - cx) / d * (r - inset), cz + (tz - cz) / d * (r - inset)

# ======================================================================== 共通の建物
def tower(x, z, y0, h, rad=3, roof=True, chest_top=True, door_face=None):
    """丸い塔（はしごで上がる）。上に低い胸壁と屋根。高すぎないよう h は 14 まで。"""
    for xx in range(x - rad, x + rad + 1):
        for zz in range(z - rad, z + rad + 1):
            d = math.hypot(xx - x, zz - z)
            if d <= rad + 0.3:
                put(xx, y0, zz, T['floor'])
                for y in range(y0 + 1, y0 + h):
                    put(xx, y, zz, T['wall'] if d > rad - 0.8 else 'minecraft:air')
                put(xx, y0 + h, zz, T['floor'])
                if d > rad - 0.8: put(xx, y0 + h + 1, zz, T['wallblk'])
    # 入口（4方向のうち2つ）とはしご
    for (dx, dz) in ((1, 0), (-1, 0)) if door_face is None else door_face:
        clear(x + dx * rad, y0 + 1, z + dz * rad, x + dx * rad, y0 + 2, z + dz * rad)
    for y in range(y0 + 1, y0 + h + 1): put(x, y, z - rad + 1, 'minecraft:ladder[facing=south]')
    put(x, y0 + h, z - rad + 1, 'minecraft:ladder[facing=south]')
    # 窓（中から外が見える）
    for y in range(y0 + 4, y0 + h - 1, 4):
        put(x, y, z + rad, T['glass']); put(x + rad, y, z, T['glass'])
    if roof:
        for k in range(0, rad + 1):
            for xx in range(x - rad + k, x + rad - k + 1):
                for zz in range(z - rad + k, z + rad - k + 1):
                    if math.hypot(xx - x, zz - z) <= rad - k + 0.3 and (xx, zz) != (x, z - rad + 1):
                        put(xx, y0 + h + 4 + k, zz, T['roof'])
        for dx, dz in ((rad, rad), (-rad, rad), (rad, -rad), (-rad, -rad)):
            for y in range(y0 + h + 1, y0 + h + 4): put(x + dx * 0 + (dx > 0) * 0 + int(dx * 0.7), y, z + int(dz * 0.7), T['pillar'])
    if chest_top: chest(x + 1, y0 + h + 1, z + 1)

def house(x, z, y0, w, d, h=4, chests=1, face='south'):
    hollow(x, y0 + 1, z, x + w - 1, y0 + h, z + d - 1, T['wall'] if KEY == 'end' else T['wood'])
    box(x, y0, z, x + w - 1, y0, z + d - 1, T['floor'])
    for xx in (x, x + w - 1):
        for zz in (z, z + d - 1): box(xx, y0 + 1, zz, xx, y0 + h, zz, T['log'])
    box(x - 1, y0 + h + 1, z - 1, x + w, y0 + h + 1, z + d, T['roof'])
    mx = x + w // 2
    clear(mx, y0 + 1, z + d - 1, mx, y0 + 2, z + d - 1)            # 戸口（南）
    clear(x, y0 + 2, z + d // 2, x, y0 + 2, z + d // 2); put(x, y0 + 2, z + d // 2, T['glass'])
    put(x + w - 1, y0 + 2, z + d // 2, T['glass'])
    put(mx, y0 + h, z + d // 2, T['light'] if KEY == 'end' else 'minecraft:lantern[hanging=true]')
    for i in range(chests): chest(x + 1 + i * 2, y0 + 1, z + 1, face='south')

def ruin_wall(x, z, y0, length, axis, h):
    for i in range(length):
        hh = max(1, int(h * (0.4 + 0.6 * nz(x + i * 3, z + i * 5))))
        for y in range(y0 + 1, y0 + 1 + hh):
            xx, zz = (x + i, z) if axis == 'x' else (x, z + i)
            put(xx, y, zz, T['wall2'] if (i + y) % 3 == 0 else T['wall'])

def tree(x, z, y0, h=5):
    if KEY == 'sky':
        for y in range(y0 + 1, y0 + h + 1): put(x, y, z, T['log'])
        for dx in range(-2, 3):
            for dz in range(-2, 3):
                for dy in range(h - 1, h + 2):
                    if abs(dx) + abs(dz) + max(0, dy - h) <= 3 and (dx, dz) != (0, 0) or dy == h + 1 and abs(dx) + abs(dz) <= 1:
                        if getb(x + dx, y0 + dy, z + dz) == 'minecraft:air': put(x + dx, y0 + dy, z + dz, T['leaves'])
    else:   # 異界：コーラスの木
        for y in range(y0 + 1, y0 + h + 1): put(x, y, z, 'minecraft:chorus_plant[up=true,down=true]')
        put(x, y0 + h + 1, z, 'minecraft:chorus_flower[age=5]')
        for dx, dz in ((1, 0), (-1, 0), (0, 1)):
            put(x + dx, y0 + h - 1, z + dz, 'minecraft:chorus_plant[down=true]'); put(x + dx, y0 + h, z + dz, 'minecraft:chorus_flower[age=5]')

def pad(x, y, z):
    """既存のジャンプ台（石の感圧板＋下にレンガ）。"""
    put(x, y, z, 'minecraft:bricks'); put(x, y + 1, z, 'minecraft:stone_pressure_plate')
    for dx, dz in ((1, 0), (-1, 0), (0, 1), (0, -1)): put(x + dx, y, z + dz, T['accent'])

def teleporter_pair(a, b):
    """双方向の転移装置。a,b は立ち位置の (x, y, z)（y は乗る面＝島の上面）。床に crying_obsidian、マーカーは床の1つ上。"""
    for (p, q) in ((a, b), (b, a)):
        x, y, z = p
        for dx in (-1, 0, 1):
            for dz in (-1, 0, 1): put(x + dx, y, z + dz, T['accent'] if (dx or dz) else T['tp_pad'])
        for dx, dz in ((2, 2), (-2, 2), (2, -2), (-2, -2)):
            put(x + dx, y + 1, z + dz, T['pillar']); put(x + dx, y + 2, z + dz, T['light'] if KEY == 'end' else 'minecraft:lantern')
        gim(x, y + 1, z, ['oa.gim', 'oa.gim_tp', f'oa.gim_tp_{q[0] - x}_{q[1] - y}_{q[2] - z}'])
        reserve(x, z, 3)

def ore_rocks(cx, cz, r, n, seed):
    """島の上に鉱石の混じった岩を置く（地面から掘れる高さ）。"""
    rr = np.random.default_rng(seed); placed = 0; tries = 0
    while placed < n and tries < n * 40:
        tries += 1
        a = rr.random() * 2 * math.pi; d = r * (0.3 + 0.6 * rr.random())
        x, z = round(cx + math.cos(a) * d), round(cz + math.sin(a) * d)
        if getb(x, 1, z) != 'minecraft:air' or getb(x, 0, z) == 'minecraft:air': continue
        if any(abs(x - o[0]) + abs(z - o[2]) < 3 for o in cur.ores + base.ores): continue
        put(x, 1, z, T['ore_host'])
        ox, oz = x + (1 if rr.random() < .5 else 0), z + (0 if rr.random() < .5 else 1)
        if getb(ox, 1, oz) not in ('minecraft:air', T['ore_host']) or getb(ox, 0, oz) == 'minecraft:air': ox, oz = x, z
        ore(ox, 1, oz, 1 if placed % 9 < 5 else 3)
        placed += 1

# ======================================================================== 中央（天空城／異界神殿）
CR = 42   # 中央の島の半径
cur = base
island(0, 0, CR, 30)
ISL_CENTER = (0, 0, CR)
if KEY == 'sky':
    # 城壁（半径26、高さ6、胸壁つき）と4つの門
    for x in range(-28, 29):
        for z in range(-28, 29):
            d = math.hypot(x, z)
            if 25.2 <= d <= 27.2:
                gate = min(abs(x), abs(z)) <= 2
                if not gate:
                    for y in range(1, 7): put(x, y, z, T['wall'] if (x + z + y) % 7 else T['wall2'])
                    if (x + z) % 2 == 0: put(x, 7, z, T['wallblk'])
                else:
                    put(x, 5, z, T['wall']); put(x, 6, z, T['wall'])      # 門の上の梁（くぐれる高さ4）
    # 城壁の上の通路（内側の足場）と階段
    for x in range(-28, 29):
        for z in range(-28, 29):
            if 24.0 <= math.hypot(x, z) < 25.2 and min(abs(x), abs(z)) > 3: put(x, 5, z, T['slab'] + '[type=top]')
    for a in (45, 135, 225, 315):   # 内側から城壁の上へ上がる階段
        ux, uz = math.cos(math.radians(a)), math.sin(math.radians(a))
        for i in range(5):
            x, z = round(ux * (19 + i)), round(uz * (19 + i))
            box(x, 1, z, x, i + 1, z, T['wall'])
    # 4つの角の塔
    for a in (45, 135, 225, 315):
        tower(round(math.cos(math.radians(a)) * 26), round(math.sin(math.radians(a)) * 26), 0, 12, rad=3)
    # 中央の天守（3階建て、各階にチェスト。屋上は胸壁つき）
    hollow(-8, 1, -8, 8, 15, 8, T['wall'])
    for fy in (5, 10): box(-7, fy, -7, 7, fy, 7, T['floor'])
    box(-8, 16, -8, 8, 16, 8, T['floor'])
    for x in range(-8, 9):
        for z in (-8, 8):
            if x % 2 == 0: put(x, 17, z, T['wallblk']); put(z, 17, x, T['wallblk'])
    for (dx, dz) in ((0, 8), (0, -8), (8, 0), (-8, 0)):   # 4方向の入口
        clear(dx - (1 if dz else 0), 1, dz - (1 if dx else 0), dx + (1 if dz else 0), 3, dz + (1 if dx else 0))
    for fy in (5, 10, 16):   # はしごの穴（2か所）
        for (lx, lz, f) in ((-6, -7, 'south'), (6, 7, 'north')):
            clear(lx, fy, lz, lx, fy, lz)
    for (lx, lz, f) in ((-6, -7, 'south'), (6, 7, 'north')):
        for y in range(1, 17): put(lx, y, lz, f'minecraft:ladder[facing={f}]')
    for y in (3, 8, 13):
        for (wx, wz) in ((-8, -3), (-8, 3), (8, -3), (8, 3), (-3, -8), (3, 8)): put(wx, y, wz, T['glass'])
    for (fy, n) in ((1, 2), (6, 2), (11, 2)):
        chest(-5, fy, 5, rich=(fy == 11)); chest(5, fy, -5, rich=(fy == 6))
    put(0, 5, 0, 'minecraft:lantern'); put(0, 10, 0, 'minecraft:lantern')
    place_name(0, 0, '天空城')
    # 中庭：噴水と生け垣（遮蔽物）
    box(-2, 0, 12, 2, 0, 16, 'minecraft:water'); hollow(-3, 1, 11, 3, 1, 17, T['trim'])
    for (hx, hz) in ((-15, -4), (15, 4), (-4, -15), (4, 15), (-14, 12), (14, -12)):
        box(hx - 2, 1, hz, hx + 2, 2, hz, T['leaves'])
    # 地下の隠し通路：天守の床下から島の東の崖へ
    box(-3, -6, -3, 3, -2, 3, 'minecraft:air'); hollow(-4, -6, -4, 4, -2, 4, T['wall'])
    box(-3, -7, -3, 3, -7, 3, T['floor'])
    for y in range(-6, 1): put(0, y, -2, 'minecraft:ladder[facing=south]')
    clear(0, 0, -2, 0, 0, -2)
    box(0, -6, -3, 0, -1, -3, T['wall'])
    for x in range(4, 39):
        box(x, -6, -1, x, -4, 1, 'minecraft:air'); box(x, -7, -1, x, -7, 1, T['floor'])
        box(x, -3, -2, x, -3, 2, T['wall']); box(x, -6, -2, x, -4, -2, T['wall']); box(x, -6, 2, x, -4, 2, T['wall'])
        if x % 6 == 0: put(x, -4, 0, 'minecraft:lantern[hanging=true]')
    chest(-2, -6, 2, rich=True); chest(2, -6, -2)
    # 崖の出口（はしごで上へ）
    for y in range(-6, 1): put(38, y, 0, 'minecraft:ladder[facing=west]')
    clear(38, 0, 0, 38, 2, 0)
else:
    # 異界神殿：黒曜石の巨大な柱8本、エンドストーンレンガの神殿（2層＋地下の遺跡）、空中の足場
    for k in range(8):
        a = math.radians(k * 45 + 22.5); x, z = round(math.cos(a) * 30), round(math.sin(a) * 30)
        box(x - 1, 1, z - 1, x + 1, 13, z + 1, T['pillar'])
        put(x, 14, z, 'minecraft:end_rod[facing=up]')
    hollow(-11, 1, -11, 11, 8, 11, T['wall'])
    box(-11, 9, -11, 11, 9, 11, T['floor']); box(-10, 1, -10, 10, 1, 10, 'minecraft:air')
    box(-11, 0, -11, 11, 0, 11, T['floor'])
    for (dx, dz) in ((0, 11), (0, -11), (11, 0), (-11, 0)):
        clear(dx - (2 if dz else 0), 1, dz - (2 if dx else 0), dx + (2 if dz else 0), 4, dz + (2 if dx else 0))
    for x in range(-11, 12):
        for z in (-11, 11):
            if x % 3 == 0: put(x, 5, z, T['glass']); put(z, 5, x, T['glass'])
    # 2階（中央は吹き抜け）と屋上の胸壁
    box(-10, 5, -10, 10, 5, 10, T['wall2']); box(-4, 5, -4, 4, 5, 4, 'minecraft:air')
    for x in range(-11, 12):
        for z in (-11, 11):
            if x % 2 == 0: put(x, 10, z, T['wallblk']); put(z, 10, x, T['wallblk'])
    for (lx, lz, f) in ((-9, -10, 'south'), (9, 10, 'north')):
        clear(lx, 5, lz, lx, 5, lz); clear(lx, 9, lz, lx, 9, lz)
        for y in range(1, 10): put(lx, y, lz, f'minecraft:ladder[facing={f}]')
    put(0, 4, 0, 'minecraft:end_rod[facing=down]')
    chest(-7, 1, 7); chest(7, 1, -7, rich=True); chest(-7, 6, -7, rich=True); chest(7, 6, 7); chest(0, 10, 6); chest(0, 10, -6)
    # 中央の広場（神殿の外）：低い遮蔽物（紫のガラスと柱）
    for (hx, hz) in ((-18, 0), (18, 0), (0, -18), (0, 18), (-15, -15), (15, 15), (15, -15), (-15, 15)):
        box(hx - 1, 1, hz, hx + 1, 2, hz, T['wall2'])
    # 空中の足場（低い。上下2段、はしご付き）
    for (sx, sz) in ((-24, 0), (24, 0)):
        box(sx - 2, 6, sz - 2, sx + 2, 6, sz + 2, T['wall2'])
        for y in range(1, 7): put(sx, y, sz - 3, 'minecraft:ladder[facing=north]')
        put(sx, 5, sz - 3, 'minecraft:ladder[facing=north]'); box(sx, 1, sz - 3, sx, 6, sz - 3, 'minecraft:ladder[facing=north]')
        box(sx, 1, sz - 2, sx, 5, sz - 2, T['wall']); chest(sx, 7, sz)
    # 地下の遺跡：神殿の床下の部屋と、北の崖へ出る通路
    hollow(-6, -7, -6, 6, -2, 6, T['wall2']); box(-5, -6, -5, 5, -3, 5, 'minecraft:air'); box(-6, -8, -6, 6, -8, 6, T['floor'])
    box(-5, -7, -5, 5, -7, 5, T['floor'])
    for y in range(-6, 1): put(3, y, 3, 'minecraft:ladder[facing=north]')
    clear(3, 0, 3, 3, 0, 3)
    chest(-4, -6, -4, rich=True); chest(4, -6, -4)
    for z in range(-39, -5):
        box(-1, -6, z, 1, -4, z, 'minecraft:air'); box(-1, -7, z, 1, -7, z, T['floor'])
        box(-2, -3, z, 2, -3, z, T['wall']); box(-2, -6, z, -2, -4, z, T['wall']); box(2, -6, z, 2, -4, z, T['wall'])
        if z % 6 == 0: put(0, -4, z, 'minecraft:end_rod[facing=down]')
    for y in range(-6, 1): put(0, y, -39, 'minecraft:ladder[facing=south]')
    clear(0, 0, -39, 0, 2, -39)
    place_name(0, 0, '異界神殿')
    # 中央の島の空間の歪み（演出だけ）
    gim(-30, 2, 30, ['oa.gim', 'oa.gim_warp'])
# 中央の島のチェスト（建物の外。広場の端・木陰）
for (x, z) in ((-20, 20), (20, -20), (34, 10), (-34, -10), (10, 34), (-10, -34), (30, 22), (-30, -22)):
    if getb(x, 1, z) == 'minecraft:air' and getb(x, 0, z) != 'minecraft:air': chest(x, 1, z)
ore_rocks(0, 0, CR - 6, 8, SEED + 5)

# ======================================================================== 外周の8つの島（スロット）
SLOT_R = 96
slots = []
for k in range(NSLOT):
    a = math.radians(k * 45 + 10 * (rng.random() - 0.5))
    rad = SLOT_R + (rng.random() - 0.5) * 10
    cx, cz = round(math.cos(a) * rad), round(math.sin(a) * rad)
    r = 19 + int(rng.random() * 4)
    slots.append((cx, cz, r))
    island(cx, cz, r, 18 + int(rng.random() * 6))
# 角の4つの小島（外周の探索エリア）
corners = []
for k in range(4):
    a = math.radians(45 + 90 * k); cx, cz = (125 if math.cos(a) > 0 else -125), (125 if math.sin(a) > 0 else -125)
    corners.append((cx, cz, 13)); island(cx, cz, 13, 12)
# 浮遊する小さな岩（飾りと足場。島と島の間）
for k in range(18):
    a = rng.random() * 2 * math.pi; d = 55 + rng.random() * 85
    x, z = round(math.cos(a) * d), round(math.sin(a) * d)
    if any(math.hypot(x - cx, z - cz) < r + 6 for cx, cz, r in ISLANDS): continue
    y = int(rng.integers(-14, 10)); s = 1 + int(rng.random() * 2)
    for dx in range(-s, s + 1):
        for dz in range(-s, s + 1):
            if abs(dx) + abs(dz) <= s:
                for dy in range(-s, 1): put(x + dx, y + dy, z + dz, T['rock'] if KEY == 'sky' else T['under'])

# 橋：中央へ（スポーク）・隣の島へ（環）・角の小島へ。種類は場所ごとに変える
kinds = ['stone', 'wood', 'rope', 'broken']
for k, (cx, cz, r) in enumerate(slots):
    a1 = edge_point(cx, cz, r, 0, 0); a2 = edge_point(0, 0, CR, cx, cz)
    bridge(a1[0], a1[1], a2[0], a2[1], 'stone' if k % 2 == 0 else 'wood')
    nx_, nz_, nr = slots[(k + 1) % NSLOT]
    b1 = edge_point(cx, cz, r, nx_, nz_); b2 = edge_point(nx_, nz_, nr, cx, cz)
    bridge(b1[0], b1[1], b2[0], b2[1], kinds[(k + 2) % 4])
for k, (cx, cz, r) in enumerate(corners):
    near = sorted(slots, key=lambda s: math.hypot(s[0] - cx, s[1] - cz))[:2]
    for j, (sx, sz, sr) in enumerate(near):
        e1 = edge_point(cx, cz, r, sx, sz); e2 = edge_point(sx, sz, sr, cx, cz)
        if math.hypot(e1[0] - e2[0], e1[1] - e2[1]) < 70: bridge(e1[0], e1[1], e2[0], e2[1], 'rope' if j else 'wood')

# 角の小島の中身（固定）：見張り小屋とチェスト3つ・鉱石・ジャンプ台
for k, (cx, cz, r) in enumerate(corners):
    house(cx - 3, cz - 3, 0, 6, 6, chests=1)
    chest(cx + 6, 1, cz - 4); chest(cx - 6, 1, cz + 5)
    ore_rocks(cx, cz, r - 2, 3, SEED + 40 + k)
    dx, dz = (-1 if cx > 0 else 1), (-1 if cz > 0 else 1)
    pad(cx + dx * 8, 0, cz + dz * 8)
    place_name(cx, cz, ('北東', '北西', '南西', '南東')[k] + 'の小島' if KEY == 'sky' else ('北東', '北西', '南西', '南東')[k] + 'の浮岩')

# 救済用の足場と上昇気流（中央への橋の真下。落ちても戻れる場所がある）
for k, (cx, cz, r) in enumerate(slots):
    if k % 2: continue
    mx, mz = (cx * 0.62), (cz * 0.62)
    px_, pz_ = round(mx + (-cz) / math.hypot(cx, cz) * 6), round(mz + cx / math.hypot(cx, cz) * 6)
    box(px_ - 3, -26, pz_ - 3, px_ + 3, -26, pz_ + 3, T['rock'] if KEY == 'sky' else T['under'])
    box(px_ - 3, -27, pz_ - 3, px_ + 3, -27, pz_ + 3, T['under'])
    put(px_, -26, pz_, T['accent'])
    gim(px_, -25, pz_, ['oa.gim', 'oa.gim_up', 'oa.gim_up_31'])
    ore(px_ + 2, -25, pz_ + 2, 3); put(px_ + 2, -26, pz_ + 2, T['rock'])
    chest(px_ - 2, -25, pz_ - 2)

# 転移装置（離れた島どうし。双方向）。異界は「異界ポータル」
TP = []
for (i, j) in ((0, 4), (2, 6)):
    (ax, az, ar), (bx, bz, br) = slots[i], slots[j]
    pa = (round(ax - ax / math.hypot(ax, az) * (ar - 5)), 0, round(az - az / math.hypot(ax, az) * (ar - 5)))
    pb = (round(bx - bx / math.hypot(bx, bz) * (br - 5)), 0, round(bz - bz / math.hypot(bx, bz) * (br - 5)))
    teleporter_pair(pa, pb); TP.append((pa, pb))
# 異界：重力異常エリア（中央と2つの島の間の広い場所）・歪み
if KEY == 'end':
    for k in (1, 5):
        cx, cz, r = slots[k]; gim(cx, 1, cz, ['oa.gim', 'oa.gim_grav', 'oa.gim_grav_9'])
    for k in (3, 7):
        cx, cz, r = slots[k]; gim(round(cx * 0.6), 2, round(cz * 0.6), ['oa.gim', 'oa.gim_warp'])

# ======================================================================== スロットの種類（生成のたびに3つから抽選）
SKY_TYPES = ['forest', 'ruins', 'garden', 'watch', 'village', 'temple', 'rocky']
END_TYPES = ['wilds', 'obsidian', 'city', 'chorus', 'ruins', 'crystal', 'tower']
NAMES = {'forest': '森林の島', 'ruins': '廃墟の島', 'garden': '庭園の島', 'watch': '見張り塔の島', 'village': '集落の島',
         'temple': '神殿の島', 'rocky': '崩れた岩の島',
         'wilds': 'エンドストーンの荒野', 'obsidian': '黒曜石の森', 'city': '崩れたエンドシティ', 'chorus': '紫の草の島',
         'crystal': '結晶の洞窟', 'tower': '異界の塔'}
TYPES = SKY_TYPES if KEY == 'sky' else END_TYPES
CH_PER_SLOT = 7

def theme(kind, cx, cz, r, seed):
    """スロット1つの中身（cur の面に書く）。チェストは必ず CH_PER_SLOT 個（特別チェストは神殿・結晶だけ1つ含む）。"""
    rr = np.random.default_rng(seed)
    def spot(margin=4, tries=200):
        for _ in range(tries):
            a = rr.random() * 2 * math.pi; d = (r - margin) * math.sqrt(rr.random())
            x, z = round(cx + math.cos(a) * d), round(cz + math.sin(a) * d)
            if any((x + dx, z + dz) in RES for dx in (-1, 0, 1) for dz in (-1, 0, 1)): continue
            if getb(x, 0, z) != 'minecraft:air' and getb(x, 1, z) == 'minecraft:air' and getb(x, 2, z) == 'minecraft:air': return x, z
        return None
    n_rich = 0
    if kind in ('forest', 'chorus', 'obsidian'):
        for _ in range(14):
            s = spot(3)
            if not s: continue
            if kind == 'obsidian':
                x, z = s; h = 4 + int(rr.random() * 5); box(x, 1, z, x, h, z, T['pillar'])
                if rr.random() < .5: put(x, h + 1, z, 'minecraft:end_rod[facing=up]')
            else: tree(s[0], s[1], 0, 4 + int(rr.random() * 3))
        if kind == 'forest': house(cx - 3, cz - 2, 0, 6, 5, chests=2)
        else: hollow(cx - 3, 1, cz - 3, cx + 3, 3, cz + 3, T['wall']); clear(cx, 1, cz + 3, cx, 2, cz + 3); chest(cx - 1, 1, cz - 1); chest(cx + 1, 1, cz - 1)
    elif kind in ('ruins', 'city', 'wilds'):
        for k in range(5):
            s = spot(5)
            if s: ruin_wall(s[0], s[1], 0, 4 + int(rr.random() * 5), 'x' if k % 2 else 'z', 4)
        if kind == 'city':
            hollow(cx - 4, 1, cz - 4, cx + 4, 7, cz + 4, T['wall2']); box(cx - 4, 8, cz - 4, cx + 4, 8, cz + 4, T['roof'])
            clear(cx, 1, cz + 4, cx + 1, 3, cz + 4); clear(cx - 4, 4, cz, cx - 4, 7, cz + 2)   # 崩れた壁
            box(cx - 3, 4, cz - 3, cx + 3, 4, cz + 3, T['floor']); clear(cx + 2, 4, cz + 2, cx + 3, 4, cz + 3)
            box(cx + 3, 1, cz + 3, cx + 3, 4, cz + 3, 'minecraft:ladder[facing=north]')
            chest(cx - 2, 1, cz - 2); chest(cx - 2, 5, cz - 2)
        else:
            house(cx - 3, cz - 3, 0, 6, 6, chests=1); clear(cx - 3, 3, cz - 3, cx, 4, cz)   # 屋根の崩れ
            chest(cx + 1, 1, cz - 2)
    elif kind in ('garden',):
        for x in range(cx - 8, cx + 9):
            for z in range(cz - 8, cz + 9):
                if (x + z) % 4 == 0 and getb(x, 0, z) != 'minecraft:air': put(x, 0, z, T['path'])
                elif rr.random() < 0.12 and getb(x, 1, z) == 'minecraft:air' and getb(x, 0, z) == T['top']:
                    put(x, 1, z, rr.choice(['minecraft:poppy', 'minecraft:dandelion', 'minecraft:azure_bluet', 'minecraft:oxeye_daisy']))
        for (hx, hz) in ((-6, 0), (6, 0), (0, -6), (0, 6)): box(cx + hx - 1, 1, cz + hz, cx + hx + 1, 2, cz + hz, T['leaves'])
        box(cx - 1, 0, cz - 1, cx + 1, 0, cz + 1, 'minecraft:water'); hollow(cx - 2, 1, cz - 2, cx + 2, 1, cz + 2, T['trim'])
        chest(cx - 4, 1, cz - 4); chest(cx + 4, 1, cz + 4); chest(cx + 4, 1, cz - 4)
    elif kind in ('watch', 'tower'):
        tower(cx, cz, 0, 12 if kind == 'watch' else 14, rad=3, door_face=((1, 0), (-1, 0), (0, 1)))
        chest(cx + 1, 1, cz + 1)
        for s in (spot(6), spot(6)):
            if s: box(s[0], 1, s[1], s[0] + 1, 2, s[1], T['wall'])   # 低い遮蔽物
    elif kind in ('village',):
        house(cx - 9, cz - 6, 0, 5, 5, chests=1); house(cx + 3, cz - 6, 0, 6, 5, chests=1); house(cx - 3, cz + 4, 0, 6, 5, chests=1)
        box(cx - 1, 0, cz - 1, cx + 1, 0, cz + 1, T['path']); put(cx, 1, cz, 'minecraft:lantern')
    elif kind in ('temple', 'crystal'):
        if kind == 'temple':
            box(cx - 6, 0, cz - 6, cx + 6, 0, cz + 6, T['floor'])
            for (px, pz) in ((-5, -5), (5, -5), (-5, 5), (5, 5), (0, -5), (0, 5), (-5, 0), (5, 0)): box(cx + px, 1, cz + pz, cx + px, 5, cz + pz, T['pillar'])
            box(cx - 6, 6, cz - 6, cx + 6, 6, cz + 6, T['slab'] + '[type=bottom]'); clear(cx - 3, 6, cz - 3, cx + 3, 6, cz + 3)
            chest(cx, 1, cz, rich=True); n_rich = 1
        else:
            # 結晶の洞窟：島の中に半球の空洞（2か所の入口）、紫水晶
            for x in range(cx - 7, cx + 8):
                for z in range(cz - 7, cz + 8):
                    for y in range(-7, 0):
                        d = math.hypot(x - cx, z - cz, (y + 3) * 1.4)
                        if d < 7: put(x, y, z, 'minecraft:air')
                        elif d < 8.2 and getb(x, y, z) != 'minecraft:air': put(x, y, z, 'minecraft:amethyst_block' if (x + y + z) % 3 else 'minecraft:budding_amethyst')
            for (ex, ez) in ((cx + 7, cz), (cx - 7, cz)):
                for i in range(0, 5): clear(ex + (i if ex > cx else -i), -2 + min(i, 2), ez - 1, ex + (i if ex > cx else -i), 0 + min(i, 2), ez + 1)
            box(cx - 5, -7, cz - 5, cx + 5, -7, cz + 5, T['floor'])
            for (ax_, az_) in ((-3, -3), (3, 3), (3, -3)): put(cx + ax_, -6, cz + az_, 'minecraft:amethyst_cluster[facing=up]')
            for y in range(-6, 1): put(cx, y, cz + 6, 'minecraft:ladder[facing=north]')
            clear(cx, 0, cz + 6, cx, 0, cz + 6)
            chest(cx - 2, -6, cz, rich=True); chest(cx + 2, -6, cz - 2); n_rich = 1
    elif kind in ('rocky',):
        for k in range(10):
            s = spot(3)
            if s:
                h = 1 + int(rr.random() * 3); box(s[0], 1, s[1], s[0] + int(rr.random() * 2), h, s[1] + int(rr.random() * 2), T['rock2'])
        for k in range(6):   # 崩れた縁（穴。足場は残す）
            a = rr.random() * 2 * math.pi; x, z = round(cx + math.cos(a) * (r - 1)), round(cz + math.sin(a) * (r - 1))
            if any((x + dx, z + dz) in RES for dx in range(-3, 4) for dz in range(-3, 4)): continue
            box(x - 1, -3, z - 1, x + 1, 0, z + 1, 'minecraft:air')
    drop_overwritten()
    # チェストの数をそろえる（足りない分は島の上の空いた場所。木陰・岩陰）
    while len(cur.chests) + len(cur.riches) < CH_PER_SLOT:
        s = spot(4)
        if not s: break
        chest(s[0], 1, s[1])
    while len(cur.chests) + len(cur.riches) > CH_PER_SLOT and cur.chests:
        x, y, z = cur.chests.pop(); put(x, y, z, 'minecraft:air')
    ore_rocks(cx, cz, r - 3, 5, seed + 7)
    # 開始地点（島の上の平らで、頭上が空いた所。5か所）
    got = 0
    for _ in range(400):
        s = spot(3)
        if not s: break
        x, z = s
        if all(getb(x + dx, 0, z + dz) not in ('minecraft:air', 'minecraft:water') and getb(x + dx, 1, z + dz) == 'minecraft:air'
               and getb(x + dx, 2, z + dz) == 'minecraft:air' for dx in (-1, 0, 1) for dz in (-1, 0, 1)) \
           and all(math.hypot(x - a, z - b) > 6 for a, _, b in cur.spawns):
            cur.spawns.append((x, 1, z)); got += 1
            if got >= 5: break
    place_name(cx, cz, NAMES[kind])

variants = []   # variants[k][v] = Canvas
for k, (cx, cz, r) in enumerate(slots):
    pick = list(rng.choice(len(TYPES), size=NVAR, replace=False))
    vs = []
    for v in range(NVAR):
        cv = Canvas(cx - r - 8, cz - r - 8, cx + r + 8, cz + r + 8)
        cur = cv
        theme(TYPES[pick[v]], cx, cz, r, SEED * 31 + k * 7 + v)
        cv.kind = TYPES[pick[v]]
        vs.append(cv)
    variants.append(vs)
    cur = base
# 固定の開始地点（中央の島の外周・角の小島）
cur = base
drop_overwritten()
def base_spawn(x, z):
    if getb(x, 0, z) != 'minecraft:air' and getb(x, 1, z) == 'minecraft:air' and getb(x, 2, z) == 'minecraft:air': base.spawns.append((x, 1, z))
for k in range(12):
    a = math.radians(k * 30 + 15); base_spawn(round(math.cos(a) * 35), round(math.sin(a) * 35))
for (cx, cz, r) in corners:
    base_spawn(cx + 3, cz + 7); base_spawn(cx - 7, cz - 2)

# ======================================================================== 検査
def chk(c, x, y, z, want_chest=True):
    b = c.get(x, y, z) if c is not base else base.get(x, y, z)
    return b is not None and (not want_chest or b.startswith('minecraft:chest'))
assert all(chk(base, x, y, z) for x, y, z in base.chests + base.riches)
for vs in variants:
    for cv in vs:
        assert len(cv.chests) + len(cv.riches) == CH_PER_SLOT, (cv.kind, len(cv.chests), len(cv.riches))
        bad = [(x, y, z, cv.get(x, y, z)) for x, y, z in cv.chests + cv.riches if not cv.get(x, y, z).startswith('minecraft:chest')]
        assert not bad, (cv.kind, bad)
        assert len(cv.spawns) >= 3, (cv.kind, len(cv.spawns))
n_base = len(base.chests) + len(base.riches)
print(KEY, 'base chests', n_base, 'rich', len(base.riches), 'ores', len(base.ores), 'spawns', len(base.spawns),
      'slot chests', NSLOT * CH_PER_SLOT, 'variants', [[cv.kind for cv in vs] for vs in variants])

# ======================================================================== 書き出し（洞窟と同じ形。スロットの中身は #sv<k> oa.map2 で分ける）
os.makedirs(OUT, exist_ok=True)
for d in ('preload', 'wait', 'release', 'apply', 'place'): os.makedirs(f"{OUT}/{d}", exist_ok=True)
rects = {}
for p in glob.glob(SRC + '/preload/*.mcfunction'):
    n = int(os.path.basename(p)[:-11]); s = open(p, encoding='utf8').read()
    m = re.search(r'forceload add ~(-?\d+) ~(-?\d+) ~(-?\d+) ~(-?\d+)', s); rects[n] = tuple(map(int, m.groups()))
    for d in ('preload', 'wait', 'release'):
        t = open(f"{SRC}/{d}/{n}.mcfunction", encoding='utf8').read().replace('oa:map/internal/tiles/', f'oa:maps/{KEY}/tiles/')
        open(f"{OUT}/{d}/{n}.mcfunction", 'w', encoding='utf8', newline='\n').write(t)
assert len(rects) == 100

def fills(arr, ox, oz, prefix=''):
    """arr（x,z,y）の空気でない部分を fill/setblock にする。ox,oz は arr[0,0] の会場座標。"""
    nx, nz, ny = arr.shape; rects_y = {}; lines = []
    for y in range(ny):
        layer = arr[:, :, y]
        if not layer.any(): continue
        rows = []
        for z in range(nz):
            runs = []; x = 0
            while x < nx:
                v = layer[x, z]
                if v == 0: x += 1; continue
                x2_ = x
                while x2_ + 1 < nx and layer[x2_ + 1, z] == v: x2_ += 1
                runs.append((x, x2_, int(v))); x = x2_ + 1
            rows.append(runs)
        curr = {}
        for z in range(nz + 1):
            now = set(rows[z]) if z < nz else set()
            for key in list(curr):
                if key not in now:
                    rects_y.setdefault((key[0], curr[key], key[1], z - 1, key[2]), []).append(y); del curr[key]
            for key in now:
                if key not in curr: curr[key] = z
    for (a, za, b, zb, v), ys in rects_y.items():
        ys.sort(); s = ys[0]; prev = ys[0]
        for yy in ys[1:] + [None]:
            if yy is not None and yy == prev + 1: prev = yy; continue
            X1, X2 = ox + a, ox + b; Z1, Z2 = oz + za, oz + zb; Y1, Y2 = Y0 + s, Y0 + prev
            bl = pal[v]; area = (X2 - X1 + 1) * (Z2 - Z1 + 1)
            if area * (Y2 - Y1 + 1) == 1: lines.append(f"{prefix}setblock ~{X1} ~{Y1} ~{Z1} {bl}")
            else:
                step = max(1, 32768 // area); yy0 = Y1
                while yy0 <= Y2:
                    yy1 = min(Y2, yy0 + step - 1)
                    lines.append(f"{prefix}fill ~{X1} ~{yy0} ~{Z1} ~{X2} ~{yy1} ~{Z2} {bl}"); yy0 = yy1 + 1
            if yy is not None: s = prev = yy
    return lines

def inrect(r, x, z): return r[0] <= x <= r[2] and r[1] <= z <= r[3]
def sub_of(c, r):
    """面 c のうち区画 r に入る部分（配列と左上の座標）。重ならなければ None。"""
    x1, z1, x2, z2 = max(r[0], c.x1), max(r[1], c.z1), min(r[2], c.x2), min(r[3], c.z2)
    if x1 > x2 or z1 > z2: return None
    return c.g[x1 - c.x1:x2 - c.x1 + 1, z1 - c.z1:z2 - c.z1 + 1, :], x1, z1

def reg_lines(c, r, cond=''):
    L = []; cs = [p for p in c.chests if inrect(r, p[0], p[2])]; rs_ = [p for p in c.riches if inrect(r, p[0], p[2])]
    os_ = [o for o in c.ores if inrect(r, o[0], o[2])]; gs = [g_ for g_ in c.gims if inrect(r, g_[0], g_[2])]
    pre = f"execute {cond} " if cond else "execute "
    for (x, y, z, k) in os_: L.append(f"{pre}positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:{'coal_ore' if k == 1 else 'redstone_ore'} align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_{k}")
    for (x, y, z) in rs_: L.append(f"{pre}positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich")
    for (x, y, z) in cs: L.append(f"{pre}positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest")
    for (x, y, z) in rs_: L.append(f"{pre}if score #mode oa.map2 matches 0 positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site")
    for (x, y, z) in cs: L.append(f"{pre}if score #mode oa.map2 matches 0 positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic")
    for (x, y, z, tags) in gs:
        L.append(f"{pre}positioned ~{x} ~{y} ~{z} align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:marker ~ ~ ~ {{Tags:[{','.join(json.dumps(t) for t in tags)}]}}")
    return L, len(cs) + len(rs_), len(os_)

for n in range(100):
    r = rects[n]; x1, z1, x2, z2 = r
    # 置く：まず区画を空にして（高さ81は3回に分ける）、土台、スロットの種類（抽選の結果だけ）
    lines = ['scoreboard players set #stage oa.map2 1']
    for (ya, yb) in ((-40, -14), (-13, 13), (14, 40)): lines.append(f"fill ~{x1} ~{ya} ~{z1} ~{x2} ~{yb} ~{z2} minecraft:air")
    sb = sub_of(base, r); lines += fills(sb[0], sb[1], sb[2])
    for k, vs in enumerate(variants):
        for v, cv in enumerate(vs):
            s_ = sub_of(cv, r)
            if s_ is None: continue
            lines += fills(s_[0], s_[1], s_[2], prefix=f"execute if score #sv{k} oa.map2 matches {v} run ")
    open(f"{OUT}/place/{n}.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(lines) + '\n')
    A = [f"execute if score #mode oa.map2 matches 0 run function oa:maps/{KEY}/tiles/place/{n}",
         "execute if score #state oa.map2 matches 2 run return 0",
         f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:marker,tag=br.chest,dx={x2 - x1},dy={NY - 1},dz={z2 - z1}]",
         f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:marker,tag=br.ore,dx={x2 - x1},dy={NY - 1},dz={z2 - z1}]",
         f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:marker,tag=oa.gim,dx={x2 - x1},dy={NY - 1},dz={z2 - z1}]",
         "scoreboard players set #stage oa.map2 2", "scoreboard players set #localc oa.map2 0", "scoreboard players set #localo oa.map2 0"]
    L, ec, eo = reg_lines(base, r)
    A += [f"scoreboard players set #expectedc oa.map2 {ec}", f"scoreboard players set #expectedo oa.map2 {eo}"] + L
    for k, vs in enumerate(variants):
        for v, cv in enumerate(vs):
            if sub_of(cv, r) is None: continue
            cond = f"if score #sv{k} oa.map2 matches {v}"
            L, ec, eo = reg_lines(cv, r, cond)
            if ec: A.append(f"execute {cond} run scoreboard players add #expectedc oa.map2 {ec}")
            if eo: A.append(f"execute {cond} run scoreboard players add #expectedo oa.map2 {eo}")
            A += L
    A += ["execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed",
          "execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed",
          "scoreboard players operation #chests oa.map2 += #localc oa.map2", "scoreboard players operation #ores oa.map2 += #localo oa.map2",
          f"function oa:maps/{KEY}/tiles/release/{n}", "scoreboard players add #tile oa.map2 1",
          "execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2",
          "execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish",
          "schedule function oa:map/internal/job/next 1t replace"]
    open(f"{OUT}/apply/{n}.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(A) + '\n')

MD = f"{ROOT}/data/oa/function/maps/{KEY}"
HEAD = f"# 生成: scripts/build_map_float.py {KEY}（直接編集しない）"
# 抽選（生成のはじめ。#mode 0＝作成・再生成のときだけ。登録だけのやり直しでは前回の結果を使う）
R = [HEAD + "。スロット（外周の8つの島）の中身を3種類から抽選する（map/internal/job/begin から）",
     "execute unless score #mode oa.map2 matches 0 run return 0"]
for k in range(NSLOT): R.append(f"execute store result score #sv{k} oa.map2 run random value 0..{NVAR - 1}")
R.append(f"function oa:maps/{KEY}/layout")
open(f"{MD}/roll.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(R) + '\n')
# 今の組み合わせ（地図の地点名・補給の場所名に使う）を storage oa:maps layout.<key> に書く
LY = [HEAD + "。今の組み合わせの地点名を storage oa:maps layout." + KEY + " に書く（地図・補給の場所名・プラグインが読む）",
      f"data modify storage oa:maps layout.{KEY} set value []"]
for (x, z, nm) in base.places: LY.append(f'data modify storage oa:maps layout.{KEY} append value {{x:{x},z:{z},name:"{nm}"}}')
for k, vs in enumerate(variants):
    for v, cv in enumerate(vs):
        for (x, z, nm) in cv.places:
            LY.append(f'execute if score #sv{k} oa.map2 matches {v} run data modify storage oa:maps layout.{KEY} append value {{x:{x},z:{z},name:"{nm}"}}')
open(f"{MD}/layout.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(LY) + '\n')
# 生成のあと：開始地点（固定＋今の組み合わせのもの）
def pts(lst): return ",".join(f"{{x:{x}.5d,y:{y + 80}.0d,z:{z}.5d}}" for x, y, z in lst)
PO = [HEAD + "。会場の生成完了後に呼ばれる（開始地点の登録・地点名）",
      f'data modify storage oa:spawn_points dim set value "{DIM}"',
      f"data modify storage oa:spawn_points points set value [{pts(base.spawns)}]"]
for k, vs in enumerate(variants):
    for v, cv in enumerate(vs):
        for p in cv.spawns: PO.append(f"execute if score #sv{k} oa.map2 matches {v} run data modify storage oa:spawn_points points append value {pts([p])}")
PO += [f"function oa:maps/{KEY}/layout",
       "execute store result score #sp_n oa.tmp run data get storage oa:spawn_points points",
       f'tellraw @a[tag=br.admin] [{{text:"{LABEL}の会場の開始地点を",color:"green"}},{{score:{{name:"#sp_n",objective:"oa.tmp"}},color:"green"}},{{text:"か所登録しました。",color:"green"}}]']
open(f"{MD}/post.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(PO) + '\n')
# 空中補給の場所名（いちばん近い地点）
SR = [HEAD + "。空中補給の場所名（中心からの相対座標 #rx,#rz は br/supply/region で計算済み）。いちばん近い地点（今の組み合わせ）の名前",
      "scoreboard players set #rbest br.tmp 2147483647",
      f'data modify storage oa:supply region set value "{LABEL}"']
def region_lines(x, z, nm, cond=''):
    pre = f"execute {cond} run " if cond else ""
    c2 = f"execute {cond} if score #rdx br.tmp < #rbest br.tmp run " if cond else "execute if score #rdx br.tmp < #rbest br.tmp run "
    return [f"{pre}scoreboard players operation #rdx br.tmp = #rx br.tmp",
            f"{pre}scoreboard players " + (f"remove #rdx br.tmp {x}" if x >= 0 else f"add #rdx br.tmp {-x}"),
            f"{pre}scoreboard players operation #rdx br.tmp *= #rdx br.tmp",
            f"{pre}scoreboard players operation #rdz br.tmp = #rz br.tmp",
            f"{pre}scoreboard players " + (f"remove #rdz br.tmp {z}" if z >= 0 else f"add #rdz br.tmp {-z}"),
            f"{pre}scoreboard players operation #rdz br.tmp *= #rdz br.tmp",
            f"{pre}scoreboard players operation #rdx br.tmp += #rdz br.tmp",
            f'{c2}data modify storage oa:supply region set value "{nm}のあたり"',
            f"{c2}scoreboard players operation #rbest br.tmp = #rdx br.tmp"]
for (x, z, nm) in base.places: SR += region_lines(x, z, nm)
for k, vs in enumerate(variants):
    for v, cv in enumerate(vs):
        for (x, z, nm) in cv.places: SR += region_lines(x, z, nm, f"if score #sv{k} oa.map2 matches {v}")
open(f"{MD}/supply_region.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(SR) + '\n')

# 確認用の画像と一覧
if PNG:
    from PIL import Image
    img = Image.new('RGB', (N, N), (20, 24, 40) if KEY == 'sky' else (12, 6, 18))
    px = img.load()
    for x in range(N):
        for z in range(N):
            col = base.g[x, z, :]; nzi = np.nonzero(col)[0]
            if len(nzi):
                b = pal[col[nzi[-1]]]
                px[x, z] = (90, 150, 70) if 'grass' in b else (200, 200, 150) if 'end_stone' in b else (150, 150, 150) if 'stone' in b else (140, 100, 160)
    for vs in variants:
        cv = vs[0]
        for x in range(cv.g.shape[0]):
            for z in range(cv.g.shape[1]):
                if cv.g[x, z, :].any(): px[x + cv.x1 + OFF, z + cv.z1 + OFF] = (220, 180, 60)
    img.resize((N * 2, N * 2)).save(PNG)
json.dump({"key": KEY, "seed": SEED, "slots": [{"c": [s[0], s[1]], "r": s[2], "types": [cv.kind for cv in variants[k]]} for k, s in enumerate(slots)],
           "corners": corners, "bridges": len(BRIDGES), "teleporters": TP, "base_chests": n_base, "slot_chests": CH_PER_SLOT,
           "spawns_base": len(base.spawns)}, open(f"{ROOT}/MAP_{KEY.upper()}_MANIFEST.json", "w", encoding="utf8"), ensure_ascii=False, indent=1, default=int)
print('ok', KEY)
