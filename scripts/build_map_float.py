#!/usr/bin/env python3
"""OA Battle Royale 1.9.231: 浮遊島マップ2種類の生成（天空島 sky ＝ oa:br_sky、異界 end ＝ oa:br_end）。
使い方: py -3 scripts/build_map_float.py <repo root> sky|end [--png 確認用PNG] [--panel ロビーの地図パネル PNG(512x512)]

洞窟（build_map_cave.py）と同じく、会場を 100 区画のタイル関数（data/oa/function/maps/<key>/tiles/{preload,wait,release,apply,place}/N）に
書き出し、管理者の「会場を生成／再生成」（oa:map/do {key:"sky"|"end",op:"create"|"rebuild"}）が1区画ずつ置いて、チェスト・鉱石を登録する。

1.9.231 で地形を作り直した：
- 島の上面に起伏（丘・段丘）。建物の立つ所（中央の城・各島の広場・橋の付け根・転移装置）だけ平らにする。
- 島の底は下へ尖り、ところどころ岩が垂れ下がる（浮遊島らしく）。
- 天空島：色の付いた屋根の家・市場・屋敷・飛行船の発着場。空に気球と飛行船（block_display、当たり判定なし＝足場にならない）。
- 異界：エンドストーンの段丘とコーラスの林、白い未来都市（白い塔・ガラスのドーム・発光）、空に浮かぶ結晶と円盤（block_display）。

毎回の生成で変わるところ（「スロット」方式）：
- 外周の8つの島（スロット）は、形と位置・橋は固定で、上に載るもの（島の種類・建物・チェスト・開始地点・地点の名前）を
  生成のたびに3種類から抽選する（maps/<key>/roll。#sv0〜#sv7 oa.map2）。橋・島の土台は固定なので、どの組み合わせでも
  中央へ必ず2本以上の道がある（中央への橋＋左右の島への橋）。
- 試合のあとに自動で作り直す（プラグインの map/MapRerollService）。手作業で保存した会場（/oaplugin map save）があればそちらが優先。

座標は中心(0,0)基準 x,z∈[-152,152]、y∈[-40,40]（会場の原点 y=80 に置く。平らな所の上面 y=0 ＝絶対80）。
特殊な仕掛けはマーカー（タグ oa.gim）で置き、動きはプラグイン（map/MapGimmickService）：
- oa.gim_tp_<dx>_<dy>_<dz>：転移装置（マーカーからの相対位置へ。双方向は2つ置く）
- oa.gim_up_<h>：上昇気流（マーカーから高さ h まで持ち上げる。島の下の救済用の足場から）
- oa.gim_grav_<r>：重力異常エリア（半径 r。異界のみ）
- oa.gim_warp：空間の歪みの演出（紫の粒・音。異界のみ）
飾り（気球・飛行船・結晶・円盤）は block_display（タグ oa.mdeco）。区画を置き直すたびに消して出し直す。
ジャンプ台は既存のもの（石の感圧板＋下にレンガ。jumppad 名前空間）。
"""
import sys, os, re, glob, json, math
import numpy as np

ROOT = sys.argv[1]
KEY = sys.argv[2]
assert KEY in ('sky', 'end')
if KEY == 'sky':
    sys.exit('1.9.233 から天空島は scripts/build_map_sky.py で生成する（このスクリプトは異界 end だけ）')
PNG = sys.argv[sys.argv.index('--png') + 1] if '--png' in sys.argv else None
PANEL = sys.argv[sys.argv.index('--panel') + 1] if '--panel' in sys.argv else None
DIM = {'sky': 'oa:br_sky', 'end': 'oa:br_end'}[KEY]
LABEL = {'sky': '天空島', 'end': '異界'}[KEY]
OUT = f"{ROOT}/data/oa/function/maps/{KEY}/tiles"
SRC = f"{ROOT}/data/oa/function/map/internal/tiles"
SEED = {'sky': 20261123, 'end': 20261124}[KEY]
rng = np.random.default_rng(SEED)
DR = np.random.default_rng(SEED + 77)   # 飾りの色などの抽選
N = 305; OFF = 152; Y0 = -40; NY = 81; TOP = 40
NSLOT = 8; NVAR = 3 if KEY == 'sky' else 1   # 1.9.232: 異界は外周の島の中身を固定（ユーザーの指示）

# ======================================================================== 材料（テーマ）
if KEY == 'sky':
    T = dict(top='minecraft:grass_block', sub='minecraft:dirt', rock='minecraft:stone', rock2='minecraft:andesite', under='minecraft:tuff',
             wall='minecraft:stone_bricks', wall2='minecraft:mossy_stone_bricks', trim='minecraft:polished_andesite', floor='minecraft:smooth_stone',
             roof='minecraft:red_terracotta', light='minecraft:lantern', glass='minecraft:glass_pane',
             pillar='minecraft:quartz_pillar', path='minecraft:dirt_path', fence='minecraft:oak_fence', wallblk='minecraft:stone_brick_wall',
             wood='minecraft:oak_planks', log='minecraft:dark_oak_log', leaves='minecraft:oak_leaves[persistent=true]', slab='minecraft:stone_brick_slab',
             accent='minecraft:gold_block', tp_pad='minecraft:crying_obsidian', ore_host='minecraft:stone')
    ROOFS = ['minecraft:red_terracotta', 'minecraft:blue_terracotta', 'minecraft:cyan_terracotta', 'minecraft:orange_terracotta', 'minecraft:light_blue_terracotta']
    WALLS = ['minecraft:white_terracotta', 'minecraft:bricks', 'minecraft:oak_planks', 'minecraft:smooth_sandstone', 'minecraft:spruce_planks']
else:
    T = dict(top='minecraft:end_stone', sub='minecraft:end_stone', rock='minecraft:end_stone', rock2='minecraft:end_stone', under='minecraft:obsidian',
             wall='minecraft:white_concrete', wall2='minecraft:smooth_quartz', trim='minecraft:quartz_pillar', floor='minecraft:quartz_bricks',
             roof='minecraft:smooth_quartz', light='minecraft:end_rod', glass='minecraft:light_blue_stained_glass_pane',
             pillar='minecraft:quartz_pillar', path='minecraft:quartz_bricks', fence='minecraft:end_stone_brick_wall', wallblk='minecraft:end_stone_brick_wall',
             wood='minecraft:purpur_block', log='minecraft:purpur_pillar', leaves='minecraft:chorus_flower[age=5]', slab='minecraft:smooth_quartz_slab',
             accent='minecraft:sea_lantern', tp_pad='minecraft:crying_obsidian', ore_host='minecraft:end_stone')
    ROOFS = ['minecraft:smooth_quartz']
    WALLS = ['minecraft:white_concrete', 'minecraft:quartz_block']
PASS = {'minecraft:air', 'minecraft:cave_air', 'minecraft:short_grass', 'minecraft:poppy', 'minecraft:dandelion', 'minecraft:azure_bluet',
        'minecraft:oxeye_daisy', 'minecraft:cornflower'}

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
        self.chests = []; self.riches = []; self.ores = []; self.spawns = []; self.gims = []; self.places = []; self.decos = []
    def inb(self, x, z): return self.x1 <= x <= self.x2 and self.z1 <= z <= self.z2
    def put(self, x, y, z, b):
        if self.inb(x, z) and Y0 <= y <= TOP: self.g[x - self.x1, z - self.z1, y - Y0] = P(b)
    def get(self, x, y, z):
        if self.inb(x, z) and Y0 <= y <= TOP: return pal[self.g[x - self.x1, z - self.z1, y - Y0]]
        return None

base = Canvas(-OFF, -OFF, OFF, OFF)
cur = base   # 今書いている面（スロットの種類を作るときに切り替える）
RES = set()  # スロットの中身が触らない柱（橋の付け根・転移装置）
SURF = {}    # 土台の地形の上面の高さ（x,z）→ y
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
def free(x, y, z): return getb(x, y, z) in PASS
def gy(x, z): return SURF.get((x, z))
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
def foundation(x1, z1, x2, z2, y0, b=None):
    """建物の床（y0）の下の、地形との隙間を埋める（斜面に建てても浮かない）。"""
    for x in range(x1, x2 + 1):
        for z in range(z1, z2 + 1):
            g = gy(x, z)
            if g is None: continue
            for y in range(g + 1, y0): put(x, y, z, b or T['rock'])

def smooth(scale, seed, n=N):
    r = np.random.default_rng(seed); k = n // scale + 3; a = r.random((k, k))
    xs = np.linspace(0, k - 3, n); i = xs.astype(int); f = xs - i
    return (a[i][:, i] * (1 - f)[:, None] * (1 - f)[None, :] + a[i + 1][:, i] * f[:, None] * (1 - f)[None, :]
            + a[i][:, i + 1] * (1 - f)[:, None] * f[None, :] + a[i + 1][:, i + 1] * f[:, None] * f[None, :])
NOISE = smooth(12, SEED + 1); HILL = smooth(11, SEED + 2); SPIKE = smooth(3, SEED + 3); HILL2 = smooth(5, SEED + 4)
def nz(x, z): return NOISE[(x + OFF) % N, (z + OFF) % N]
def hl(x, z): return 0.7 * HILL[(x + OFF) % N, (z + OFF) % N] + 0.3 * HILL2[(x + OFF) % N, (z + OFF) % N]
def sp(x, z): return SPIKE[(x + OFF) % N, (z + OFF) % N]

# ======================================================================== 島
ISLANDS = []   # (cx, cz, r)
def island(cx, cz, r, depth, amp=0, flats=(), wob=0.26):
    """浮遊島。上面は起伏（amp：丘の高さ。flats＝(x,z,半径) の中は平らで y=0）。底は下へ尖り、ところどころ岩が垂れ下がる。"""
    for x in range(int(cx - r * 1.35) - 1, int(cx + r * 1.35) + 2):
        for z in range(int(cz - r * 1.35) - 1, int(cz + r * 1.35) + 2):
            d = math.hypot(x - cx, z - cz) / (r * (1 + wob * (nz(x, z) - 0.5) * 2))
            if d > 1: continue
            h = 0
            if amp:
                v = max(0.0, (hl(x, z) - 0.28) / 0.5)
                f = min(1.0, (1 - d) / 0.28)
                for fx, fz, fr in flats:
                    f *= min(1.0, max(0.0, (math.hypot(x - fx, z - fz) - fr) / 6.0))
                h = int(round(amp * min(1.0, v) * f))
            put(x, h, z, T['top'])
            for y in range(h - 1, h - 3, -1): put(x, y, z, T['sub'])
            # 底：中心ほど深く、下へ尖る。ところどころ垂れ下がる岩
            bottom = -2 - int(depth * ((1 - d) ** 0.55) * (0.72 + 0.56 * nz(z, x)))
            s = sp(x, z)
            if s > 0.66: bottom -= int(min(16, (s - 0.66) * 70 * (0.4 + (1 - d))))
            for y in range(h - 3, bottom - 1, -1):
                if KEY == 'sky':
                    m = T['under'] if y < -depth * 0.55 else (T['rock2'] if nz(x + y, z) > 0.62 else T['rock'])
                    if y >= -5 and nz(x - y, z + y) > 0.7: m = 'minecraft:dirt'
                else:
                    m = T['under'] if y < -depth * 0.7 else T['rock']
                put(x, y, z, m)
            SURF[(x, z)] = h
    ISLANDS.append((cx, cz, r))

def on_island(x, z, margin=0.0):
    return any(math.hypot(x - cx, z - cz) <= r - margin for cx, cz, r in ISLANDS)

# ======================================================================== 橋
BRIDGES = []
def bridge(ax, az, bx, bz, kind, y=0):
    """(ax,az)→(bx,bz) の橋。島の縁から縁まで。歩く面は y（=付け根の平らな所の上面）。種類：stone 幅4・wood 幅3・rope 幅2・broken 幅3（1マスの切れ目あり、跳べば渡れる）"""
    L = math.hypot(bx - ax, bz - az); n = int(L * 2) + 1
    ux, uz = (bx - ax) / L, (bz - az) / L; px, pz = -uz, ux
    w = {'stone': 4, 'wood': 3, 'rope': 2, 'broken': 3}[kind]
    if KEY == 'sky':
        deck = {'stone': T['wall'], 'wood': 'minecraft:spruce_planks', 'rope': 'minecraft:spruce_planks', 'broken': T['wall2']}[kind]
    else:
        deck = {'stone': T['floor'], 'wood': 'minecraft:purpur_block', 'rope': T['wall2'], 'broken': 'minecraft:end_stone_bricks'}[kind]
    rail = {'stone': T['wallblk'], 'wood': T['fence'], 'rope': T['fence'], 'broken': None}[kind]
    if KEY == 'end' and kind in ('rope', 'wood'): rail = 'minecraft:white_stained_glass_pane'
    for i in range(n):
        t = i / (n - 1); cx_, cz_ = ax + (bx - ax) * t, az + (bz - az) * t
        seg = int(t * L)
        if kind == 'broken' and seg % 9 == 4 and 3 < t * L < L - 3: continue   # 1マスの切れ目
        for k in np.linspace(-(w - 1) / 2, (w - 1) / 2, w * 2):
            x, z = round(cx_ + px * k), round(cz_ + pz * k)
            if getb(x, y, z) == T['top']: continue
            put(x, y, z, deck)
            if kind == 'stone': put(x, y - 1, z, T['trim'])
            if kind == 'wood' and seg % 4 == 0 and KEY == 'sky': put(x, y - 1, z, 'minecraft:dark_oak_planks')
        if rail:
            for sgn in (-1, 1):
                x, z = round(cx_ + px * sgn * (w / 2 + 0.5)), round(cz_ + pz * sgn * (w / 2 + 0.5))
                if getb(x, y, z) == T['top'] or on_island(x, z, -0.5): continue
                if getb(x, y, z) == 'minecraft:air': put(x, y + 1, z, rail); put(x, y, z, deck)
        if kind in ('stone', 'wood') and seg % 12 == 6:
            for sgn in (-1, 1):
                x, z = round(cx_ + px * sgn * (w / 2 + 0.5)), round(cz_ + pz * sgn * (w / 2 + 0.5))
                if getb(x, y + 1, z) == rail: put(x, y + 2, z, T['light'] if KEY == 'end' else 'minecraft:lantern')
        # 石橋の下のアーチ（飾り）
        if kind == 'stone' and seg % 10 in (0, 1) and 4 < t * L < L - 4:
            for sgn in (-1, 1):
                x, z = round(cx_ + px * sgn * (w / 2 - 0.5)), round(cz_ + pz * sgn * (w / 2 - 0.5))
                for yy in range(y - 4, y - 1): put(x, yy, z, T['trim'])
    reserve(ax, az, 4); reserve(bx, bz, 4)
    BRIDGES.append(((ax, az), (bx, bz), kind))

def edge_point(cx, cz, r, tx, tz, inset=6.0):
    d = math.hypot(tx - cx, tz - cz); return cx + (tx - cx) / d * (r - inset), cz + (tz - cz) / d * (r - inset)

# ======================================================================== 飾り（block_display。当たり判定がないので足場にならない）
def ent(x, y, z, etype, nbt):
    """飾りのエンティティ（タグ oa.mdeco。区画を置き直すたびに消して出し直す）。"""
    cur.decos.append((x, y, z, nbt, etype))

SPIKES = []   # 黒曜石の柱の頂上（x, 結晶の高さ y, z）。災害「塔の砲撃」の発射点
def spike(x, z, r, h, cage=False):
    """黒曜石の柱（エンドの柱のような円柱）。頂上に岩盤とエンドクリスタル（無敵・壊れない）。cage で鉄格子の籠。"""
    gs_ = [gy(xx, zz) for xx in range(x - r, x + r + 1) for zz in range(z - r, z + r + 1) if gy(xx, zz) is not None]
    g0 = min(gs_) if gs_ else 0
    for xx in range(x - r, x + r + 1):
        for zz in range(z - r, z + r + 1):
            if math.hypot(xx - x, zz - z) <= r + 0.35:
                for y in range(g0 - 3, h + 1): put(xx, y, zz, 'minecraft:obsidian')
    put(x, h + 1, z, 'minecraft:bedrock')
    if cage:
        for xx in range(x - 2, x + 3):
            for zz in range(z - 2, z + 3):
                if max(abs(xx - x), abs(zz - z)) == 2:
                    for y in range(h + 1, h + 5): put(xx, y, zz, 'minecraft:iron_bars')
                put(xx, h + 5, zz, 'minecraft:iron_bars')
    ent(x, h + 2, z, 'end_crystal', 'Invulnerable:1b,ShowBottom:0b')
    SPIKES.append((x, h + 3, z))

def bd(x, y, z, block, sx, sy, sz, ox=0.0, oy=0.0, oz=0.0, yaw=0.0, glow=False, rot=None):
    """(x,y,z) の位置（ブロックの中心）に、大きさ sx,sy,sz の箱を置く。ox,oy,oz は中心からのずれ（向き yaw で回る）。"""
    q = rot or [0.0, 0.0, 0.0, 1.0]
    nbt = (f'block_state:"{block}",view_range:6.0f,Rotation:[{yaw:.1f}f,0.0f],'
           f'transformation:{{translation:[{-sx / 2 + ox:.3f}f,{oy:.3f}f,{-sz / 2 + oz:.3f}f],left_rotation:[{q[0]:.4f}f,{q[1]:.4f}f,{q[2]:.4f}f,{q[3]:.4f}f],'
           f'scale:[{sx:.3f}f,{sy:.3f}f,{sz:.3f}f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}')
    if glow: nbt += ',brightness:{block:15,sky:15}'
    cur.decos.append((x, y, z, nbt, 'block_display'))

def balloon(x, y, z, c1, c2, yaw=0.0):
    """熱気球（天空島）。"""
    bd(x, y, z, c1, 5.0, 5.0, 5.0, oy=0.5); bd(x, y, z, c2, 6.0, 3.0, 4.0, oy=1.5, yaw=yaw); bd(x, y, z, c2, 4.0, 3.0, 6.0, oy=1.5, yaw=yaw)
    bd(x, y, z, c1, 3.6, 1.2, 3.6, oy=5.5); bd(x, y, z, c1, 3.0, 1.0, 3.0, oy=-0.6)
    for (dx, dz) in ((-0.9, -0.9), (0.9, -0.9), (-0.9, 0.9), (0.9, 0.9)): bd(x, y, z, 'minecraft:oak_fence', 0.12, 2.6, 0.12, ox=dx, oy=-3.2, oz=dz)
    bd(x, y, z, 'minecraft:spruce_planks', 2.0, 1.0, 2.0, oy=-4.0)

def airship(x, y, z, yaw, c=('minecraft:white_wool', 'minecraft:red_wool')):
    """飛行船（天空島）。"""
    bd(x, y, z, 'minecraft:dark_oak_planks', 3.0, 1.6, 10.0, yaw=yaw); bd(x, y, z, 'minecraft:dark_oak_planks', 2.0, 1.0, 12.0, oy=-0.6, yaw=yaw)
    bd(x, y, z, 'minecraft:spruce_planks', 3.4, 0.25, 10.4, oy=1.6, yaw=yaw)
    bd(x, y, z, c[0], 5.0, 4.5, 13.0, oy=4.8, yaw=yaw); bd(x, y, z, c[0], 3.6, 3.0, 15.0, oy=5.5, yaw=yaw)
    bd(x, y, z, c[1], 5.2, 0.8, 13.2, oy=6.2, yaw=yaw)
    bd(x, y, z, c[1], 0.3, 2.6, 2.4, oy=4.6, oz=-7.0, yaw=yaw); bd(x, y, z, c[1], 3.4, 0.3, 2.4, oy=5.6, oz=-7.0, yaw=yaw)
    bd(x, y, z, 'minecraft:gold_block', 0.6, 0.6, 0.6, oy=0.4, oz=-5.6, yaw=yaw)
    for oz in (-3.0, 3.0): bd(x, y, z, 'minecraft:oak_fence', 0.15, 2.2, 0.15, oy=1.8, oz=oz, yaw=yaw)

def crystal(x, y, z, block='minecraft:amethyst_block', s=2.6):
    """浮かぶ結晶（異界）。45度傾けた箱。"""
    q = [0.2706, 0.0, 0.2706, 0.9239]
    bd(x, y, z, block, s, s, s, oy=0.0, glow=True, rot=q); bd(x, y, z, 'minecraft:end_rod', 0.3, s * 2.2, 0.3, oy=-s * 0.6, glow=True)

def saucer(x, y, z, yaw=0.0):
    """浮かぶ円盤（異界の未来都市）。"""
    bd(x, y, z, 'minecraft:smooth_quartz', 9.0, 0.8, 9.0, yaw=yaw); bd(x, y, z, 'minecraft:smooth_quartz', 6.4, 0.8, 6.4, oy=0.6, yaw=yaw + 45)
    bd(x, y, z, 'minecraft:white_concrete', 11.0, 0.3, 3.0, oy=0.25, yaw=yaw); bd(x, y, z, 'minecraft:white_concrete', 3.0, 0.3, 11.0, oy=0.25, yaw=yaw)
    bd(x, y, z, 'minecraft:light_blue_stained_glass', 3.6, 2.2, 3.6, oy=1.3, yaw=yaw)
    bd(x, y, z, 'minecraft:sea_lantern', 3.0, 0.4, 3.0, oy=-0.4, glow=True, yaw=yaw)

# ======================================================================== 共通の建物
def flag(x, y, z, c):
    """旗（柵の竿と羊毛2つ）。y は竿の根元。"""
    for yy in range(y, y + 3): put(x, yy, z, T['fence'] if KEY == 'sky' else 'minecraft:end_rod[facing=up]')
    if KEY == 'sky': put(x + 1, y + 2, z, c); put(x + 2, y + 2, z, c)

def tower(x, z, y0, h, rad=3, roof=True, chest_top=True, door_face=None, roofm=None):
    """丸い塔（はしごで上がる）。上に低い胸壁と屋根。"""
    foundation(x - rad, z - rad, x + rad, z + rad, y0)
    for xx in range(x - rad, x + rad + 1):
        for zz in range(z - rad, z + rad + 1):
            d = math.hypot(xx - x, zz - z)
            if d <= rad + 0.3:
                put(xx, y0, zz, T['floor'])
                for y in range(y0 + 1, y0 + h):
                    put(xx, y, zz, T['wall'] if d > rad - 0.8 else 'minecraft:air')
                put(xx, y0 + h, zz, T['floor'])
                if d > rad - 0.8: put(xx, y0 + h + 1, zz, T['wallblk'])
    for (dx, dz) in ((1, 0), (-1, 0)) if door_face is None else door_face:
        clear(x + dx * rad, y0 + 1, z + dz * rad, x + dx * rad, y0 + 2, z + dz * rad)
    for y in range(y0 + 1, y0 + h + 1): put(x, y, z - rad + 1, 'minecraft:ladder[facing=south]')
    for y in range(y0 + 4, y0 + h - 1, 4):
        put(x, y, z + rad, T['glass']); put(x + rad, y, z, T['glass'])
        if KEY == 'end': put(x - rad, y, z, T['glass']); put(x, y + 1, z + rad, T['glass'])
    if roof:
        rm = roofm or T['roof']
        for k in range(0, rad + 1):
            for xx in range(x - rad + k, x + rad - k + 1):
                for zz in range(z - rad + k, z + rad - k + 1):
                    if math.hypot(xx - x, zz - z) <= rad - k + 0.3 and (xx, zz) != (x, z - rad + 1):
                        put(xx, y0 + h + 4 + k, zz, rm)
        for dx, dz in ((rad, rad), (-rad, rad), (rad, -rad), (-rad, -rad)):
            for y in range(y0 + h + 1, y0 + h + 4): put(x + int(dx * 0.7), y, z + int(dz * 0.7), T['pillar'])
        if KEY == 'sky': flag(x, y0 + h + 5 + rad, z, DR.choice(['minecraft:red_wool', 'minecraft:blue_wool', 'minecraft:yellow_wool']))
        else: put(x, y0 + h + 5 + rad, z, 'minecraft:end_rod[facing=up]'); put(x, y0 + h + 6 + rad, z, 'minecraft:end_rod[facing=up]')
    if chest_top: chest(x + 1, y0 + h + 1, z + 1)

def house(x, z, y0, w, d, h=4, chests=1, face='south', wallm=None, roofm=None):
    """家。天空島は色の付いた寄棟屋根、異界は白い壁と平らな屋根（発光の縁取り）。"""
    wallm = wallm or str(DR.choice(WALLS)); roofm = roofm or str(DR.choice(ROOFS))
    foundation(x, z, x + w - 1, z + d - 1, y0)
    hollow(x, y0 + 1, z, x + w - 1, y0 + h, z + d - 1, wallm)
    box(x, y0, z, x + w - 1, y0, z + d - 1, T['floor'])
    for xx in (x, x + w - 1):
        for zz in (z, z + d - 1): box(xx, y0 + 1, zz, xx, y0 + h, zz, T['log'] if KEY == 'sky' else T['trim'])
    if KEY == 'sky':
        k = 0
        while x - 1 + k <= x + w - k and z - 1 + k <= z + d - k:
            box(x - 1 + k, y0 + h + 1 + k, z - 1 + k, x + w - k, y0 + h + 1 + k, z + d - k, roofm); k += 1
    else:
        box(x - 1, y0 + h + 1, z - 1, x + w, y0 + h + 1, z + d, roofm)
        for xx in (x - 1, x + w):
            for zz in (z - 1, z + d): put(xx, y0 + h + 1, zz, 'minecraft:sea_lantern')
    mx = x + w // 2
    clear(mx, y0 + 1, z + d - 1, mx, y0 + 2, z + d - 1)            # 戸口（南）
    put(x, y0 + 2, z + d // 2, T['glass']); put(x + w - 1, y0 + 2, z + d // 2, T['glass'])
    if w >= 6: put(x + 1, y0 + 2, z + d - 1, T['glass']); put(x + w - 2, y0 + 2, z + d - 1, T['glass'])
    put(mx, y0 + h, z + d // 2, T['light'] if KEY == 'end' else 'minecraft:lantern[hanging=true]')
    for i in range(chests): chest(x + 1 + i * 2, y0 + 1, z + 1, face='south')

def ruin_wall(x, z, length, axis, h):
    for i in range(length):
        xx, zz = (x + i, z) if axis == 'x' else (x, z + i)
        g = gy(xx, zz)
        if g is None or (xx, zz) in RES: continue
        hh = max(1, int(h * (0.4 + 0.6 * nz(x + i * 3, z + i * 5))))
        for y in range(g + 1, g + 1 + hh): put(xx, y, zz, T['wall2'] if (i + y) % 3 == 0 else T['wall'])

def tree(x, z, y0, h=5, rr=None):
    rr = rr or DR
    if KEY == 'sky':
        for y in range(y0 + 1, y0 + h + 1): put(x, y, z, T['log'] if h > 5 else 'minecraft:oak_log')
        lv = 'minecraft:oak_leaves[persistent=true]' if rr.random() < 0.7 else 'minecraft:azalea_leaves[persistent=true]'
        for dx in range(-2, 3):
            for dz in range(-2, 3):
                for dy in range(h - 1, h + 2):
                    if abs(dx) + abs(dz) + max(0, dy - h) <= 3 and (dx, dz) != (0, 0) or dy == h + 1 and abs(dx) + abs(dz) <= 1:
                        if free(x + dx, y0 + dy, z + dz): put(x + dx, y0 + dy, z + dz, lv)
    else:   # 異界：枝分かれするコーラスの木
        def grow(px, py, pz, n, depth):
            for i in range(n):
                put(px, py + i, pz, 'minecraft:chorus_plant[up=true,down=true]')
            top = py + n - 1
            if depth >= 2 or rr.random() < 0.25:
                put(px, top + 1, pz, 'minecraft:chorus_flower[age=5]'); return
            for (dx, dz) in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                if rr.random() < 0.45:
                    bx_, bz_ = px + dx, pz + dz
                    if not free(bx_, top, bz_): continue
                    put(bx_, top, bz_, 'minecraft:chorus_plant[up=true]')
                    grow(bx_, top + 1, bz_, 1 + int(rr.random() * 3), depth + 1)
            put(px, top + 1, pz, 'minecraft:chorus_flower[age=5]')
        grow(x, y0 + 1, z, h - 1, 0)

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
        g = gy(x, z)
        if g is None or (x, z) in RES or not free(x, g + 1, z) or free(x, g, z): continue
        if any(abs(x - o[0]) + abs(z - o[2]) < 3 for o in cur.ores + base.ores): continue
        put(x, g + 1, z, T['ore_host'])
        ox, oz = x + (1 if rr.random() < .5 else 0), z + (0 if rr.random() < .5 else 1)
        if gy(ox, oz) != g or (ox, oz) in RES or getb(ox, g + 1, oz) not in PASS | {T['ore_host']} or free(ox, g, oz): ox, oz = x, z
        ore(ox, g + 1, oz, 1 if placed % 9 < 5 else 3)
        placed += 1

# ======================================================================== 配置の計画（島の位置・橋の付け根・転移装置を先に決め、そこを平らにする）
CR = 46   # 中央の島の半径
SLOT_R = 98 if KEY == 'sky' else 80   # 1.9.232: 異界は島どうしの間隔を狭める
CORN = 126 if KEY == 'sky' else 104
slots = []
for k in range(NSLOT):
    a = math.radians(k * 45 + 10 * (rng.random() - 0.5))
    rad = SLOT_R + (rng.random() - 0.5) * 10
    cx, cz = round(math.cos(a) * rad), round(math.sin(a) * rad)
    r = 19 + int(rng.random() * 4)
    slots.append((cx, cz, r, 18 + int(rng.random() * 6)))
corners = []
for k in range(4):
    a = math.radians(45 + 90 * k); cx, cz = (CORN if math.cos(a) > 0 else -CORN), (CORN if math.sin(a) > 0 else -CORN)
    corners.append((cx, cz, 13))
PLAN = []   # (ax, az, bx, bz, kind)
kinds = ['stone', 'wood', 'rope', 'broken']
for k, (cx, cz, r, _) in enumerate(slots):
    a1 = edge_point(cx, cz, r, 0, 0); a2 = edge_point(0, 0, CR, cx, cz)
    PLAN.append((a1[0], a1[1], a2[0], a2[1], 'stone' if k % 2 == 0 else 'wood'))
    nx_, nz_, nr, _ = slots[(k + 1) % NSLOT]
    b1 = edge_point(cx, cz, r, nx_, nz_); b2 = edge_point(nx_, nz_, nr, cx, cz)
    PLAN.append((b1[0], b1[1], b2[0], b2[1], kinds[(k + 2) % 4]))
for k, (cx, cz, r) in enumerate(corners):
    near = sorted(slots, key=lambda s: math.hypot(s[0] - cx, s[1] - cz))[:2]
    for j, (sx, sz, sr, _) in enumerate(near):
        e1 = edge_point(cx, cz, r, sx, sz); e2 = edge_point(sx, sz, sr, cx, cz)
        if math.hypot(e1[0] - e2[0], e1[1] - e2[1]) < 70: PLAN.append((e1[0], e1[1], e2[0], e2[1], 'rope' if j else 'wood'))
ENDS = [(p[0], p[1]) for p in PLAN] + [(p[2], p[3]) for p in PLAN]
# 転移装置：島の中心から、中央への向きを 55度回した方向の縁の近く
TPP = []
for (i, j) in ((0, 4), (2, 6)):
    pts_ = []
    for s in (i, j):
        cx, cz, r, _ = slots[s]; a = math.atan2(-cz, -cx) + math.radians(55)
        pts_.append((round(cx + math.cos(a) * (r - 6)), 0, round(cz + math.sin(a) * (r - 6))))
    TPP.append(tuple(pts_))
TP_FLATS = [(p[0], p[2], 4) for pr in TPP for p in pr]
def flats_for(cx, cz, r, center_r):
    fl = [(cx, cz, center_r)] if center_r else []
    fl += [(ex, ez, 6) for ex, ez in ENDS if math.hypot(ex - cx, ez - cz) < r + 2]
    fl += [f for f in TP_FLATS if math.hypot(f[0] - cx, f[1] - cz) < r + 2]
    return fl
def free_dir(cx, cz, r):
    """島の縁のうち、橋の付け根・転移装置からいちばん離れた向き（ラジアン）。"""
    used = [math.atan2(ez - cz, ex - cx) for ex, ez in ENDS if math.hypot(ex - cx, ez - cz) < r + 2]
    used += [math.atan2(f[1] - cz, f[0] - cx) for f in TP_FLATS if math.hypot(f[0] - cx, f[1] - cz) < r + 2]
    best, bd_ = 0.0, -1
    for deg in range(0, 360, 10):
        a = math.radians(deg)
        m = min([abs((a - u + math.pi) % (2 * math.pi) - math.pi) for u in used] or [math.pi])
        if m > bd_: best, bd_ = a, m
    return best

# ======================================================================== 中央（天空城／異界神殿）
cur = base
island(0, 0, CR, 32, amp=9, flats=flats_for(0, 0, CR, 31))
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
    for x in range(-28, 29):
        for z in range(-28, 29):
            if 24.0 <= math.hypot(x, z) < 25.2 and min(abs(x), abs(z)) > 3: put(x, 5, z, T['slab'] + '[type=top]')
    for a in (45, 135, 225, 315):   # 内側から城壁の上へ上がる階段
        ux, uz = math.cos(math.radians(a)), math.sin(math.radians(a))
        for i in range(5):
            x, z = round(ux * (19 + i)), round(uz * (19 + i))
            box(x, 1, z, x, i + 1, z, T['wall'])
    # 4つの角の塔（色の付いた屋根と旗）
    for j, a in enumerate((45, 135, 225, 315)):
        tower(round(math.cos(math.radians(a)) * 26), round(math.sin(math.radians(a)) * 26), 0, 12, rad=3, roofm=ROOFS[j % 2])
    # 中央の天守（3階建て、各階にチェスト。屋上は胸壁つき）
    hollow(-8, 1, -8, 8, 15, 8, 'minecraft:white_terracotta')
    for y in (1, 6, 11): hollow(-8, y, -8, 8, y, 8, T['wall'])
    for x in (-8, 8):
        for z in (-8, 8): box(x, 1, z, x, 16, z, T['pillar'])
    for fy in (5, 10): box(-7, fy, -7, 7, fy, 7, T['floor'])
    box(-8, 16, -8, 8, 16, 8, T['floor'])
    for x in range(-8, 9):
        for z in (-8, 8):
            if x % 2 == 0: put(x, 17, z, T['wallblk']); put(z, 17, x, T['wallblk'])
    # 天守の上の時計塔（入れない。旗は柵）
    box(-2, 17, -2, 2, 22, 2, 'minecraft:white_terracotta'); box(-3, 23, -3, 3, 23, 3, 'minecraft:blue_terracotta')
    for k in range(1, 4): box(-3 + k, 23 + k, -3 + k, 3 - k, 23 + k, 3 - k, 'minecraft:blue_terracotta')
    for (cx_, cz_) in ((0, -3), (0, 3), (-3, 0), (3, 0)): put(cx_, 20, cz_, 'minecraft:gold_block')
    flag(0, 27, 0, 'minecraft:red_wool')
    for (dx, dz) in ((0, 8), (0, -8), (8, 0), (-8, 0)):   # 4方向の入口
        clear(dx - (1 if dz else 0), 1, dz - (1 if dx else 0), dx + (1 if dz else 0), 3, dz + (1 if dx else 0))
    for fy in (5, 10, 16):   # はしごの穴（2か所）
        for (lx, lz, f) in ((-6, -7, 'south'), (6, 7, 'north')):
            clear(lx, fy, lz, lx, fy, lz)
    for (lx, lz, f) in ((-6, -7, 'south'), (6, 7, 'north')):
        for y in range(1, 17): put(lx, y, lz, f'minecraft:ladder[facing={f}]')
    for y in (3, 8, 13):
        for (wx, wz) in ((-8, -3), (-8, 3), (8, -3), (8, 3), (-3, -8), (3, 8)): put(wx, y, wz, T['glass'])
    for fy in (1, 6, 11):
        chest(-5, fy, 5, rich=(fy == 11)); chest(5, fy, -5, rich=(fy == 6))
    put(0, 5, 0, 'minecraft:lantern'); put(0, 10, 0, 'minecraft:lantern')
    place_name(0, 0, '天空城')
    # 中庭：噴水・生け垣・市場の屋台（色の付いた日よけ）
    box(-2, 0, 12, 2, 0, 16, 'minecraft:water'); hollow(-3, 1, 11, 3, 1, 17, T['trim'])
    for (hx, hz) in ((-15, -4), (15, 4), (-4, -15), (4, 15)):
        box(hx - 2, 1, hz, hx + 2, 2, hz, T['leaves'])
    for j, (sx, sz) in enumerate(((-14, 12), (14, -12), (-12, -14), (12, 14))):
        for (dx, dz) in ((-1, -1), (1, -1), (-1, 1), (1, 1)): box(sx + dx, 1, sz + dz, sx + dx, 3, sz + dz, T['fence'])
        box(sx - 2, 4, sz - 2, sx + 2, 4, sz + 2, ['minecraft:red_wool', 'minecraft:white_wool', 'minecraft:blue_wool', 'minecraft:yellow_wool'][j])
        put(sx, 1, sz, 'minecraft:barrel[facing=up]')
    # 地下の隠し通路：天守の床下から島の東の崖へ
    box(-3, -6, -3, 3, -2, 3, 'minecraft:air'); hollow(-4, -6, -4, 4, -2, 4, T['wall'])
    box(-3, -7, -3, 3, -7, 3, T['floor'])
    for y in range(-6, 1): put(0, y, -2, 'minecraft:ladder[facing=south]')
    clear(0, 0, -2, 0, 0, -2)
    box(0, -6, -3, 0, -1, -3, T['wall'])
    for x in range(4, 43):
        box(x, -6, -1, x, -4, 1, 'minecraft:air'); box(x, -7, -1, x, -7, 1, T['floor'])
        box(x, -3, -2, x, -3, 2, T['wall']); box(x, -6, -2, x, -4, -2, T['wall']); box(x, -6, 2, x, -4, 2, T['wall'])
        if x % 6 == 0: put(x, -4, 0, 'minecraft:lantern[hanging=true]')
    chest(-2, -6, 2, rich=True); chest(2, -6, -2)
    ex_ = 42   # 崖の出口（はしごで上へ）
    for y in range(-6, (gy(ex_, 0) or 0) + 1): put(ex_, y, 0, 'minecraft:ladder[facing=west]')
    clear(ex_, (gy(ex_, 0) or 0), 0, ex_, (gy(ex_, 0) or 0) + 2, 0)
    # 空の飾り：気球と飛行船
    for j, (bx_, by_, bz_) in enumerate(((-34, 30, 18), (30, 33, -30), (8, 36, 40), (-60, 26, -58), (70, 30, 52), (-112, 32, 40), (110, 28, -40), (20, 34, -118))):
        cs = [('minecraft:red_wool', 'minecraft:white_wool'), ('minecraft:blue_wool', 'minecraft:yellow_wool'), ('minecraft:orange_wool', 'minecraft:white_wool'),
              ('minecraft:light_blue_wool', 'minecraft:white_wool')][j % 4]
        balloon(bx_, by_, bz_, cs[0], cs[1], yaw=j * 20.0)
    airship(-48, 24, 64, 30.0); airship(64, 22, -64, 210.0, ('minecraft:white_wool', 'minecraft:blue_wool')); airship(-130, 18, -90, 100.0)
else:
    # 1.9.232: 中央は「竜の祭壇」。岩盤の構造物（帰還ポータルのような窪みと中央の柱、松明）にチェスト、頂点にドラゴンの卵。
    # まわりに黒曜石の柱（エンドの柱）8本。広場に低い遮蔽物とコーラスの木
    for x in range(-9, 10):
        for z in range(-9, 10):
            d = math.hypot(x, z)
            if d <= 5.4: put(x, 0, z, 'minecraft:bedrock'); put(x, -1, z, 'minecraft:bedrock')
            elif d <= 8.5 and nz(x * 5, z * 5) > 0.55: put(x, 0, z, 'minecraft:bedrock')
            if d <= 3.4: put(x, 0, z, 'minecraft:air'); put(x, -1, z, 'minecraft:bedrock'); put(x, -2, z, 'minecraft:bedrock')
    box(0, 0, 0, 0, 4, 0, 'minecraft:bedrock')
    for (dx, dz, f) in ((0, -1, 'north'), (0, 1, 'south'), (1, 0, 'east'), (-1, 0, 'west')): put(dx, 2, dz, f'minecraft:wall_torch[facing={f}]')
    put(0, 5, 0, 'minecraft:dragon_egg')
    chest(2, 0, 2, rich=True, face='south'); chest(-2, 0, -2, face='north'); chest(2, 0, -2, face='east'); chest(-2, 0, 2, face='west')
    place_name(0, 0, '竜の祭壇')
    # 黒曜石の柱（スポークの橋を避けて、間の方向）
    for k in range(8):
        a = math.radians(k * 45 + 22.5); rr_ = 35 + (k % 2) * 3
        x, z = round(math.cos(a) * rr_), round(math.sin(a) * rr_)
        spike(x, z, 2 + (k * 5) % 3, (18, 30, 24, 34, 20, 28, 22, 32)[k], cage=k in (1, 6))
    # 広場の遮蔽物（低い）とコーラスの木
    for k in range(8):
        a = math.radians(k * 45); x, z = round(math.cos(a) * 17), round(math.sin(a) * 17)
        box(x - 1, 1, z, x + 1, 2, z, 'minecraft:end_stone_bricks'); put(x, 3, z, 'minecraft:end_rod[facing=up]')
    for k in range(10):
        a = math.radians(k * 36 + 10); x, z = round(math.cos(a) * 24), round(math.sin(a) * 24)
        if free(x, 1, z): tree(x, z, 0, 5 + (k % 3))
    gim(-30, 2, 30, ['oa.gim', 'oa.gim_warp'])
    # 空の飾り：浮かぶ結晶
    for j, (bx_, by_, bz_) in enumerate(((-36, 30, -20), (34, 34, 26), (-10, 37, 44), (60, 28, -70), (-74, 32, 66), (100, 26, 20), (-100, 26, -24), (10, 32, -104))):
        crystal(bx_, by_, bz_, 'minecraft:amethyst_block' if j % 2 else 'minecraft:purpur_block')
# 中央の島のチェスト（建物の外。広場の端・丘の上）
for (x, z) in ((-20, 20), (20, -20), (36, 10), (-36, -10), (10, 36), (-10, -36), (32, 24), (-32, -24)):
    g = gy(x, z)
    if g is not None and free(x, g + 1, z) and not free(x, g, z): chest(x, g + 1, z)
ore_rocks(0, 0, CR - 6, 8, SEED + 5)

# ======================================================================== 外周の8つの島（スロット）・角の小島・浮岩
for k, (cx, cz, r, dep) in enumerate(slots):
    island(cx, cz, r, dep, amp=11 if KEY == 'sky' else 12, flats=flats_for(cx, cz, r, 12))
for k, (cx, cz, r) in enumerate(corners):
    island(cx, cz, r, 14, amp=5, flats=flats_for(cx, cz, r, 8))
# 浮遊する小さな岩（飾り。島と島の間）
for k in range(26):
    a = rng.random() * 2 * math.pi; d = 55 + rng.random() * 90
    x, z = round(math.cos(a) * d), round(math.sin(a) * d)
    if any(math.hypot(x - cx, z - cz) < r * 1.3 + 6 for cx, cz, r in ISLANDS): continue
    y = int(rng.integers(-18, 12)); s = 1 + int(rng.random() * 3)
    for dx in range(-s, s + 1):
        for dz in range(-s, s + 1):
            if abs(dx) + abs(dz) <= s:
                for dy in range(-(s - abs(dx) - abs(dz)) * 2 - 1, 1): put(x + dx, y + dy, z + dz, T['rock'] if KEY == 'sky' else T['under'])
                put(x + dx, y, z + dz, T['top'])

if KEY == 'end':
    ir = np.random.default_rng(SEED + 9)
    for k in range(40):
        a = ir.random() * 2 * math.pi; d = 70 + ir.random() * 80
        x, z = round(math.cos(a) * d), round(math.sin(a) * d)
        if abs(x) > 148 or abs(z) > 148 or any(math.hypot(x - cx, z - cz) < r * 1.3 + 7 for cx, cz, r in ISLANDS): continue
        if any(math.hypot(x - (ax + bx) / 2, z - (az + bz) / 2) < 8 for ax, az, bx, bz, _ in PLAN): continue
        y = int(ir.integers(-16, 8)); s_ = 2 + int(ir.random() * 4)
        for dx in range(-s_, s_ + 1):
            for dz in range(-s_, s_ + 1):
                dd = math.hypot(dx, dz)
                if dd > s_ + 0.3: continue
                for dy in range(-int((s_ - dd) * 1.6) - 1, 1): put(x + dx, y + dy, z + dz, 'minecraft:end_stone')

# 橋
for (ax, az, bx, bz, kd) in PLAN: bridge(ax, az, bx, bz, kd)

# 角の小島の中身（固定）：見張り小屋とチェスト3つ・鉱石・ジャンプ台
for k, (cx, cz, r) in enumerate(corners):
    house(cx - 3, cz - 3, 0, 6, 6, chests=1)
    for (x, z) in ((cx + 6, cz - 4), (cx - 6, cz + 5), (cx + 5, cz + 6), (cx - 5, cz - 7)):
        g = gy(x, z)
        if g is not None and (x, z) not in RES and free(x, g + 1, z) and len([c for c in base.chests if abs(c[0] - cx) < 15 and abs(c[2] - cz) < 15]) < 3:
            chest(x, g + 1, z)
    ore_rocks(cx, cz, r - 2, 3, SEED + 40 + k)
    dx, dz = (-1 if cx > 0 else 1), (-1 if cz > 0 else 1)
    pad(cx + dx * 6, 0, cz + dz * 6)
    place_name(cx, cz, ('南東', '南西', '北西', '北東')[k] + ('の小島' if KEY == 'sky' else 'の浮岩'))

# 救済用の足場と上昇気流（中央への橋の真下。落ちても戻れる場所がある）
for k, (cx, cz, r, _) in enumerate(slots):
    if k % 2: continue
    mx, mz = (cx * 0.64), (cz * 0.64)
    px_, pz_ = round(mx + (-cz) / math.hypot(cx, cz) * 6), round(mz + cx / math.hypot(cx, cz) * 6)
    box(px_ - 3, -26, pz_ - 3, px_ + 3, -26, pz_ + 3, T['rock'] if KEY == 'sky' else T['under'])
    box(px_ - 3, -27, pz_ - 3, px_ + 3, -27, pz_ + 3, T['under'])
    put(px_, -26, pz_, T['accent'])
    gim(px_, -25, pz_, ['oa.gim', 'oa.gim_up', 'oa.gim_up_31'])
    ore(px_ + 2, -25, pz_ + 2, 3); put(px_ + 2, -26, pz_ + 2, T['rock'])
    chest(px_ - 2, -25, pz_ - 2)

# 転移装置（離れた島どうし。双方向）。異界は「異界ポータル」
TP = []
for (pa, pb) in TPP:
    teleporter_pair(pa, pb); TP.append((pa, pb))
if KEY == 'end':
    for k in (1, 5):
        cx, cz, r, _ = slots[k]; gim(cx, 1, cz, ['oa.gim', 'oa.gim_grav', 'oa.gim_grav_9'])
    for k in (3, 7):
        cx, cz, r, _ = slots[k]; gim(round(cx * 0.6), 2, round(cz * 0.6), ['oa.gim', 'oa.gim_warp'])

# 土台の飾り（スロットの外：中央の島の外周・角の小島）。天空島は草花と木、異界はコーラスの木と黒曜石の斑
SLOT_BOX = [(cx - r - 8, cz - r - 8, cx + r + 8, cz + r + 8) for cx, cz, r, _ in slots]
def in_slot_box(x, z): return any(a <= x <= c and b <= z <= d for a, b, c, d in SLOT_BOX)
for (x, z), g in list(SURF.items()):
    if in_slot_box(x, z) or (x, z) in RES or base.get(x, g, z) != T['top'] or not free(x, g + 1, z): continue
    if math.hypot(x, z) < 29: continue
    v = DR.random()
    if KEY == 'sky':
        if v < 0.10: put(x, g + 1, z, 'minecraft:short_grass')
        elif v < 0.125: put(x, g + 1, z, str(DR.choice(['minecraft:poppy', 'minecraft:dandelion', 'minecraft:cornflower', 'minecraft:oxeye_daisy'])))
    else:
        if nz(x * 3, z * 3) > 0.78 and g > 0: put(x, g, z, 'minecraft:obsidian')
for (x, z) in [(x, z) for (x, z), g in SURF.items() if not in_slot_box(x, z) and math.hypot(x, z) > 33 and ((x * 7349 + z * 9151) % 997) < 9]:
    g = gy(x, z)
    if (x, z) in RES or any(abs(x - c[0]) < 3 and abs(z - c[2]) < 3 for c in base.chests + base.riches) or not free(x, g + 1, z) or free(x, g, z): continue
    if any(abs(x - ex) < 7 and abs(z - ez) < 7 for ex, ez in ENDS): continue
    tree(x, z, g, 5 + int(DR.random() * 3))

# ======================================================================== スロットの種類（生成のたびに3つから抽選）
SKY_TYPES = ['forest', 'ruins', 'garden', 'watch', 'village', 'temple', 'market', 'mansion', 'dock']
END_TYPES = ['wilds', 'obsidian', 'city', 'chorus', 'ruins', 'crystal', 'tower', 'spire', 'dome', 'pagoda']
END_FIXED = ['pagoda', 'chorus', 'city', 'pagoda', 'crystal', 'chorus', 'pagoda', 'obsidian']   # 1.9.232: 異界の外周の島（固定）
NAMES = {'forest': '森林の島', 'ruins': '廃墟の島', 'garden': '庭園の島', 'watch': '見張り塔の島', 'village': '集落の島',
         'temple': '神殿の島', 'market': '市場の島', 'mansion': '屋敷の島', 'dock': '飛行船の発着場',
         'wilds': 'エンドストーンの荒野', 'obsidian': '黒曜石の森', 'city': '崩れたエンドシティ', 'chorus': 'コーラスの林',
         'crystal': '結晶の洞窟', 'tower': '異界の塔', 'spire': '白い尖塔', 'dome': 'ガラスのドーム', 'pagoda': '異界の塔街'}
TYPES = SKY_TYPES if KEY == 'sky' else END_TYPES
CH_PER_SLOT = 7

def theme(kind, cx, cz, r, seed):
    """スロット1つの中身（cur の面に書く）。チェストは必ず CH_PER_SLOT 個（特別チェストは神殿・結晶・尖塔だけ1つ含む）。
    島の中心の半径12は平らな広場（y=0）、その外は起伏（gy で地面の高さ）。"""
    rr = np.random.default_rng(seed)
    def spot(margin=4, tries=300, rmin=0.0):
        for _ in range(tries):
            a = rr.random() * 2 * math.pi; d = rmin + (r - margin - rmin) * math.sqrt(rr.random())
            x, z = round(cx + math.cos(a) * d), round(cz + math.sin(a) * d)
            if any((x + dx, z + dz) in RES for dx in (-1, 0, 1) for dz in (-1, 0, 1)): continue
            g = gy(x, z)
            if g is None: continue
            if not free(x, g, z) and getb(x, g, z) != 'minecraft:water' and free(x, g + 1, z) and free(x, g + 2, z): return x, g, z
        return None
    if kind in ('forest', 'chorus', 'obsidian', 'wilds'):
        n = {'forest': 16, 'chorus': 22, 'obsidian': 14, 'wilds': 6}[kind]
        for _ in range(n):
            s = spot(3, rmin=7)
            if not s: continue
            x, g, z = s
            if kind == 'obsidian':
                h = 4 + int(rr.random() * 6); box(x, g + 1, z, x, g + h, z, 'minecraft:obsidian')
                if rr.random() < .5: put(x, g + h + 1, z, 'minecraft:end_rod[facing=up]')
                if rr.random() < .4: put(x + 1, g + h - 1, z, 'minecraft:crying_obsidian')
            else: tree(x, z, g, 4 + int(rr.random() * (5 if KEY == 'end' else 3)), rr)
        if KEY == 'end' and kind in ('chorus', 'obsidian'):
            s2 = spot(6, rmin=9)
            if s2: spike(s2[0], s2[2], 2, 16 + int(rr.random() * 10), cage=kind == 'obsidian')
        if kind == 'forest': house(cx - 3, cz - 2, 0, 6, 5, chests=2)
        elif kind == 'wilds':
            for k in range(5):
                s = spot(5)
                if s: ruin_wall(s[0], s[2], 4 + int(rr.random() * 5), 'x' if k % 2 else 'z', 4)
            hollow(cx - 3, 1, cz - 3, cx + 3, 3, cz + 3, 'minecraft:end_stone_bricks'); clear(cx, 1, cz + 3, cx, 2, cz + 3)
            chest(cx - 1, 1, cz - 1); chest(cx + 1, 1, cz - 1)
        else:
            hollow(cx - 3, 1, cz - 3, cx + 3, 3, cz + 3, T['wall'] if KEY == 'sky' else 'minecraft:purpur_block')
            box(cx - 3, 4, cz - 3, cx + 3, 4, cz + 3, T['wall2']); clear(cx, 1, cz + 3, cx, 2, cz + 3)
            chest(cx - 1, 1, cz - 1); chest(cx + 1, 1, cz - 1)
    elif kind in ('ruins', 'city'):
        for k in range(6):
            s = spot(5)
            if s: ruin_wall(s[0], s[2], 4 + int(rr.random() * 5), 'x' if k % 2 else 'z', 4)
        if kind == 'city':
            pb = 'minecraft:purpur_block'
            hollow(cx - 4, 1, cz - 4, cx + 4, 7, cz + 4, pb); box(cx - 4, 8, cz - 4, cx + 4, 8, cz + 4, 'minecraft:purpur_slab[type=bottom]')
            for (dx, dz) in ((-4, -4), (4, -4), (-4, 4), (4, 4)): box(cx + dx, 1, cz + dz, cx + dx, 9, cz + dz, 'minecraft:purpur_pillar')
            clear(cx, 1, cz + 4, cx + 1, 3, cz + 4); clear(cx - 4, 4, cz, cx - 4, 7, cz + 2)   # 崩れた壁
            box(cx - 3, 4, cz - 3, cx + 3, 4, cz + 3, T['floor']); clear(cx + 2, 4, cz + 2, cx + 3, 4, cz + 3)
            box(cx + 3, 1, cz + 3, cx + 3, 4, cz + 3, 'minecraft:ladder[facing=north]')
            put(cx, 7, cz, 'minecraft:end_rod[facing=down]')
            chest(cx - 2, 1, cz - 2); chest(cx - 2, 5, cz - 2)
        else:
            house(cx - 3, cz - 3, 0, 6, 6, chests=1); clear(cx - 3, 3, cz - 3, cx, 9, cz)   # 屋根の崩れ
            chest(cx + 1, 1, cz - 2)
    elif kind == 'garden':
        for x in range(cx - 9, cx + 10):
            for z in range(cz - 9, cz + 10):
                g = gy(x, z)
                if g is None or (x, z) in RES: continue
                if (x - cx) % 4 == 0 or (z - cz) % 4 == 0:
                    if g == 0 and getb(x, 0, z) == T['top']: put(x, 0, z, T['path'])
                elif rr.random() < 0.18 and free(x, g + 1, z) and getb(x, g, z) == T['top']:
                    put(x, g + 1, z, str(rr.choice(['minecraft:poppy', 'minecraft:dandelion', 'minecraft:azure_bluet', 'minecraft:oxeye_daisy', 'minecraft:cornflower'])))
        for (hx, hz) in ((-6, 0), (6, 0), (0, -6), (0, 6)): box(cx + hx - 1, 1, cz + hz, cx + hx + 1, 2, cz + hz, T['leaves'])
        box(cx - 1, 0, cz - 1, cx + 1, 0, cz + 1, 'minecraft:water'); hollow(cx - 2, 1, cz - 2, cx + 2, 1, cz + 2, T['trim'])
        # あずまや（柱と色の屋根）
        gx, gz = cx + 7, cz + 7
        for (dx, dz) in ((-2, -2), (2, -2), (-2, 2), (2, 2)): box(gx + dx, 1, gz + dz, gx + dx, 3, gz + dz, T['pillar'])
        rf = str(DR.choice(ROOFS)); box(gx - 3, 4, gz - 3, gx + 3, 4, gz + 3, rf); box(gx - 2, 5, gz - 2, gx + 2, 5, gz + 2, rf); put(gx, 6, gz, rf)
        chest(cx - 4, 1, cz - 4); chest(cx + 4, 1, cz - 4); chest(gx, 1, gz)
    elif kind in ('watch', 'tower', 'spire'):
        if kind == 'spire':
            # 白い尖塔（2階＋屋上、はしご。上に発光の尖り）
            R_ = 4; H = 16
            for x in range(cx - R_, cx + R_ + 1):
                for z in range(cz - R_, cz + R_ + 1):
                    d = math.hypot(x - cx, z - cz)
                    if d > R_ + 0.3: continue
                    put(x, 0, z, T['floor'])
                    for y in range(1, H):
                        if d > R_ - 0.8: put(x, y, z, 'minecraft:light_blue_stained_glass' if y % 5 == 2 else T['wall'])
                        else: put(x, y, z, 'minecraft:air')
                    put(x, 8, z, T['wall2']); put(x, H, z, T['wall2'])
                    if d > R_ - 0.8: put(x, H + 1, z, T['wallblk'])
            for (dx, dz) in ((1, 0), (-1, 0), (0, 1)): clear(cx + dx * R_, 1, cz + dz * R_, cx + dx * R_, 2, cz + dz * R_)
            box(cx, 1, cz - R_ + 1, cx, H, cz - R_ + 1, 'minecraft:ladder[facing=south]')
            box(cx - 1, H + 2, cz - 1, cx + 1, H + 3, cz + 1, 'minecraft:white_concrete'); box(cx, H + 4, cz, cx, H + 8, cz, 'minecraft:end_rod[facing=up]')
            put(cx, 7, cz, 'minecraft:sea_lantern'); put(cx, 15, cz, 'minecraft:sea_lantern')
            chest(cx + 2, 1, cz + 2, rich=True); chest(cx - 2, 9, cz + 2); chest(cx + 2, H + 1, cz + 2)
        else:
            tower(cx, cz, 0, 12 if kind == 'watch' else 14, rad=3, door_face=((1, 0), (-1, 0), (0, 1)))
            chest(cx + 1, 1, cz + 1)
        for s in (spot(6, rmin=7), spot(6, rmin=7)):
            if s: box(s[0], s[1] + 1, s[2], s[0] + 1, s[1] + 2, s[2], T['wall'])   # 低い遮蔽物
    elif kind == 'village':
        house(cx - 9, cz - 6, 0, 5, 5, chests=1); house(cx + 3, cz - 6, 0, 6, 5, chests=1); house(cx - 3, cz + 4, 0, 6, 5, chests=1)
        box(cx - 1, 0, cz - 1, cx + 1, 0, cz + 1, T['path']); put(cx, 1, cz, 'minecraft:lantern')
        for s in (spot(4, rmin=11), spot(4, rmin=11)):
            if s: tree(s[0], s[2], s[1], 5, rr)
    elif kind == 'market':
        # 市場：広場のまわりに色の日よけの屋台、真ん中に井戸
        box(cx - 9, 0, cz - 9, cx + 9, 0, cz + 9, 'minecraft:stone_bricks')
        for x in range(cx - 9, cx + 10):
            for z in range(cz - 9, cz + 10):
                if (x + z) % 3 == 0 and (x, z) not in RES: put(x, 0, z, 'minecraft:polished_andesite')
        cols = ['minecraft:red_wool', 'minecraft:white_wool', 'minecraft:blue_wool', 'minecraft:yellow_wool', 'minecraft:orange_wool', 'minecraft:light_blue_wool']
        for j, (sx, sz) in enumerate(((-6, -6), (0, -7), (6, -6), (-6, 6), (6, 6), (-7, 0))):
            x0, z0 = cx + sx, cz + sz
            for (dx, dz) in ((-1, -1), (1, -1), (-1, 1), (1, 1)): box(x0 + dx, 1, z0 + dz, x0 + dx, 2, z0 + dz, T['fence'])
            box(x0 - 2, 3, z0 - 2, x0 + 2, 3, z0 + 2, cols[j])
            put(x0, 1, z0, 'minecraft:barrel[facing=up]')
        hollow(cx - 1, 1, cz - 1, cx + 1, 1, cz + 1, T['wall']); put(cx, 0, cz, 'minecraft:water')
        for (dx, dz) in ((-1, -1), (1, 1)): box(cx + dx, 2, cz + dz, cx + dx, 3, cz + dz, T['fence'])
        box(cx - 1, 4, cz - 1, cx + 1, 4, cz + 1, 'minecraft:spruce_slab[type=bottom]')
        for (x, z) in ((cx - 6, cz - 4), (cx + 6, cz - 4), (cx - 6, cz + 4), (cx + 6, cz + 4), (cx + 3, cz + 7)): chest(x, 1, z)
    elif kind == 'mansion':
        # 屋敷（2階建て、色の寄棟屋根、2階へははしご）
        x0, z0, W, D = cx - 6, cz - 5, 13, 11
        wm = str(DR.choice(['minecraft:white_terracotta', 'minecraft:bricks'])); rf = str(DR.choice(ROOFS))
        house(x0, z0, 0, W, D, h=8, chests=2, wallm=wm, roofm=rf)
        box(x0 + 1, 4, z0 + 1, x0 + W - 2, 4, z0 + D - 2, 'minecraft:spruce_planks')
        clear(x0 + W - 3, 4, z0 + 1, x0 + W - 3, 4, z0 + 1); box(x0 + W - 3, 1, z0 + 1, x0 + W - 3, 4, z0 + 1, 'minecraft:ladder[facing=south]')
        for xx in range(x0 + 2, x0 + W - 2, 3): put(xx, 6, z0 + D - 1, T['glass']); put(xx, 6, z0, T['glass'])
        chest(x0 + 2, 5, z0 + D - 3); chest(x0 + W - 3, 5, z0 + D - 3)
        # 玄関の柱
        for dx in (-1, 1): box(cx + dx * 2, 1, z0 + D, cx + dx * 2, 3, z0 + D, T['pillar'])
        box(cx - 3, 4, z0 + D, cx + 3, 4, z0 + D + 1, rf)
    elif kind == 'dock':
        # 飛行船の発着場：島の空いている縁から外へ桟橋、横に停まった飛行船（甲板は歩ける）
        a = free_dir(cx, cz, r); ux, uz = math.cos(a), math.sin(a); px, pz = -uz, ux
        for t in range(0, r + 6):
            for w in (-1, 0, 1):
                x, z = round(cx + ux * t + px * w), round(cz + uz * t + pz * w)
                if t > 4 or w == 0: put(x, 0, z, 'minecraft:spruce_planks')
                g = gy(x, z)
                if g is not None and g > 0 and t > 4: clear(x, 1, z, x, g, z)
            if t % 5 == 0 and t > 8:
                for w in (-2, 2):
                    x, z = round(cx + ux * t + px * w), round(cz + uz * t + pz * w); put(x, 0, z, 'minecraft:spruce_planks'); put(x, 1, z, T['fence']); put(x, 2, z, 'minecraft:lantern')
        # 停まっている飛行船（桟橋の先の横。甲板 y=0、船体は下へ）
        sx, sz = cx + ux * (r + 2) + px * 4, cz + uz * (r + 2) + pz * 4
        for t in np.arange(-6, 6.5, 0.5):
            for w in np.arange(-2, 2.5, 0.5):
                x, z = round(sx + ux * t + px * w), round(sz + uz * t + pz * w)
                taper = abs(w) > 1.5 and abs(t) > 4.5
                if taper: continue
                put(x, 0, z, 'minecraft:spruce_planks')
                put(x, -1, z, 'minecraft:dark_oak_planks')
                if abs(w) < 1.2: put(x, -2, z, 'minecraft:dark_oak_planks')
                if abs(w) >= 1.6: put(x, 1, z, 'minecraft:dark_oak_fence')
        mxs, mzs = round(sx), round(sz)
        box(mxs, 1, mzs, mxs, 6, mzs, 'minecraft:dark_oak_fence')
        chest(round(sx + ux * 3), 1, round(sz + uz * 3)); chest(round(sx - ux * 3), 1, round(sz - uz * 3))
        bd(mxs, 7, mzs, 'minecraft:white_wool', 5.0, 4.5, 13.0, oy=0.0, yaw=-math.degrees(a) + 90.0)
        bd(mxs, 7, mzs, 'minecraft:red_wool', 5.2, 0.8, 13.2, oy=1.4, yaw=-math.degrees(a) + 90.0)
        # 倉庫
        house(cx - 3, cz - 3, 0, 6, 6, chests=1)
    elif kind in ('temple', 'crystal'):
        if kind == 'temple':
            box(cx - 6, 0, cz - 6, cx + 6, 0, cz + 6, T['floor'])
            for (px, pz) in ((-5, -5), (5, -5), (-5, 5), (5, 5), (0, -5), (0, 5), (-5, 0), (5, 0)): box(cx + px, 1, cz + pz, cx + px, 5, cz + pz, T['pillar'])
            box(cx - 6, 6, cz - 6, cx + 6, 6, cz + 6, T['slab'] + '[type=bottom]'); clear(cx - 3, 6, cz - 3, cx + 3, 6, cz + 3)
            chest(cx, 1, cz, rich=True)
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
            # 地上の結晶の柱
            for (ax_, az_) in ((-9, 4), (8, -6), (2, 10)):
                g = gy(cx + ax_, cz + az_)
                if g is not None and (cx + ax_, cz + az_) not in RES: box(cx + ax_, g + 1, cz + az_, cx + ax_, g + 3, cz + az_, 'minecraft:amethyst_block'); put(cx + ax_, g + 4, cz + az_, 'minecraft:amethyst_cluster[facing=up]')
            chest(cx - 2, -6, cz, rich=True); chest(cx + 2, -6, cz - 2)
    elif kind == 'pagoda':
        # 1.9.232: 密集した高い塔の街（真紅とプルプァと石英の帯、光る窓、反りの軒、尖った屋根）。下の2階だけ入れる
        def pagoda(x0, z0, w, h, cols):
            hw = w // 2
            for x in range(x0 - hw, x0 + hw + 1):
                for z in range(z0 - hw, z0 + hw + 1):
                    if (x, z) in RES: continue
                    edge = max(abs(x - x0), abs(z - z0)) == hw
                    corner = abs(x - x0) == hw and abs(z - z0) == hw
                    put(x, 0, z, 'minecraft:purpur_block')
                    for y in range(1, h + 1):
                        lv = (y - 1) // 6; yy = (y - 1) % 6
                        if corner: m = 'minecraft:stripped_crimson_stem'
                        elif edge:
                            if yy == 5: m = 'minecraft:smooth_quartz'
                            elif yy in (2, 3) and (x + z) % 2 == 0: m = 'minecraft:pearlescent_froglight' if (x * 3 + z + y) % 5 == 0 else 'minecraft:magenta_stained_glass'
                            else: m = cols[lv % len(cols)]
                        else: m = 'minecraft:purpur_block' if yy == 5 and lv < 2 else 'minecraft:air'
                        put(x, y, z, m)
            # 軒（各階の上、1つ外へ張り出す）
            for y in range(6, h + 1, 6):
                for x in range(x0 - hw - 1, x0 + hw + 2):
                    for z in range(z0 - hw - 1, z0 + hw + 2):
                        if max(abs(x - x0), abs(z - z0)) == hw + 1 and (x, z) not in RES:
                            put(x, y, z, 'minecraft:crimson_slab[type=bottom]')
                            if abs(x - x0) == hw + 1 and abs(z - z0) == hw + 1: put(x, y + 1, z, 'minecraft:end_rod[facing=up]')
            # 屋根（段々にすぼまる）と尖り
            k = 0
            while hw - k >= 0:
                box(x0 - hw + k, h + 1 + k, z0 - hw + k, x0 + hw - k, h + 1 + k, z0 + hw - k, 'minecraft:crimson_planks' if k % 2 == 0 else 'minecraft:purpur_block'); k += 1
            for y in range(h + 1 + k, min(TOP, h + 4 + k)): put(x0, y, z0, 'minecraft:end_rod[facing=up]')
            # 入口（4方向）と、2階へのはしご。2階より上は塞ぐ
            for (dx, dz) in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                clear(x0 + dx * hw, 1, z0 + dz * hw, x0 + dx * hw, 2, z0 + dz * hw)
            box(x0 - hw + 1, 1, z0 - hw + 1, x0 - hw + 1, 6, z0 - hw + 1, 'minecraft:ladder[facing=south]')
            box(x0 - hw + 1, 12, z0 - hw + 1, x0 + hw - 1, 12, z0 + hw - 1, 'minecraft:purpur_block')
            put(x0, 5, z0, 'minecraft:pearlescent_froglight'); put(x0, 11, z0, 'minecraft:pearlescent_froglight')
        pagoda(cx, cz, 9, min(32, 26 + int(rr.random() * 7)), ['minecraft:crimson_planks', 'minecraft:smooth_quartz', 'minecraft:purpur_block'])
        for j, (dx, dz) in enumerate(((-8, -8), (8, -8), (-8, 8), (8, 8))):
            hh = (14, 20, 18, 22)[(j + int(rr.random() * 4)) % 4]
            pagoda(cx + dx, cz + dz, 5, hh, ['minecraft:purpur_block', 'minecraft:crimson_planks'])
        # 塔をつなぐ渡り廊下（2階の高さ、手すり付き）
        for (dx, dz) in ((-8, -8), (8, -8), (-8, 8), (8, 8)):
            sx_, sz_ = (1 if dx > 0 else -1), (1 if dz > 0 else -1)
            for t in range(5, 6):
                for w_ in (-1, 0, 1):
                    put(cx + sx_ * t, 6, cz + dz + w_, 'minecraft:end_stone_bricks')
        # 足元の道・桜（異界の色）の木・チェスト
        for x in range(cx - 12, cx + 13):
            for z in range(cz - 12, cz + 13):
                if (abs(x - cx) <= 1 or abs(z - cz) <= 1) and gy(x, z) == 0 and getb(x, 0, z) == T['top'] and (x, z) not in RES: put(x, 0, z, 'minecraft:end_stone_bricks')
        for _ in range(8):
            s2 = spot(3, rmin=12)
            if s2:
                x, g, z = s2
                for y in range(g + 1, g + 5): put(x, y, z, 'minecraft:cherry_log')
                for dx in range(-2, 3):
                    for dz in range(-2, 3):
                        for dy in (3, 4, 5):
                            if abs(dx) + abs(dz) + (dy == 5) <= 3 and free(x + dx, g + dy, z + dz): put(x + dx, g + dy, z + dz, 'minecraft:cherry_leaves[persistent=true]')
        chest(cx + 2, 1, cz + 2, rich=True); chest(cx - 2, 7, cz + 2); chest(cx - 8, 1, cz - 8); chest(cx + 8, 1, cz + 8); chest(cx - 10, 1, cz + 1)
        spike(round(cx + (cx / math.hypot(cx, cz)) * 14), round(cz + (cz / math.hypot(cx, cz)) * 14), 2, 18 + int(rr.random() * 8))
    elif kind == 'dome':
        # ガラスのドーム（半径8、中は光る床の庭、出入口4つ）
        for x in range(cx - 9, cx + 10):
            for z in range(cz - 9, cz + 10):
                d0 = math.hypot(x - cx, z - cz)
                if d0 <= 8.5: put(x, 0, z, 'minecraft:sea_lantern' if (x + z) % 4 == 0 and d0 < 7 else T['floor'])
                for y in range(1, 10):
                    d = math.hypot(x - cx, z - cz, (y - 0.5) * 1.05)
                    if 7.6 <= d <= 8.6: put(x, y, z, 'minecraft:light_blue_stained_glass' if y < 7 else 'minecraft:white_stained_glass')
                    elif d < 7.6: put(x, y, z, 'minecraft:air')
        for (dx, dz) in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            for i in range(6, 10): clear(cx + dx * i - (dz != 0), 1, cz + dz * i - (dx != 0), cx + dx * i + (dz != 0), 3, cz + dz * i + (dx != 0))
        for (ax_, az_) in ((-3, 2), (3, -2)): tree(cx + ax_, cz + az_, 0, 5, rr)
        chest(cx - 4, 1, cz - 3); chest(cx + 4, 1, cz + 3); chest(cx, 1, cz + 5)
    drop_overwritten()
    # チェストの数をそろえる（足りない分は島の上の空いた場所）
    while len(cur.chests) + len(cur.riches) < CH_PER_SLOT:
        s = spot(4)
        if not s: break
        chest(s[0], s[1] + 1, s[2])
    while len(cur.chests) + len(cur.riches) > CH_PER_SLOT and cur.chests:
        x, y, z = cur.chests.pop(); put(x, y, z, 'minecraft:air')
    ore_rocks(cx, cz, r - 3, 5, seed + 7)
    # 開始地点（平らで頭上が空いた所。5か所）
    got = 0
    for _ in range(500):
        s = spot(3)
        if not s: break
        x, g, z = s
        if all(gy(x + dx, z + dz) == g and not free(x + dx, g, z + dz) and getb(x + dx, g, z + dz) != 'minecraft:water'
               and free(x + dx, g + 1, z + dz) and free(x + dx, g + 2, z + dz) for dx in (-1, 0, 1) for dz in (-1, 0, 1)) \
           and all(math.hypot(x - a, z - b) > 6 for a, _, b in cur.spawns):
            cur.spawns.append((x, g + 1, z)); got += 1
            if got >= 5: break
    place_name(cx, cz, NAMES[kind])

variants = []   # variants[k][v] = Canvas
for k, (cx, cz, r, _) in enumerate(slots):
    pick = list(rng.choice(len(TYPES), size=NVAR, replace=False)) if KEY == 'sky' else [TYPES.index(END_FIXED[k])]
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
    g = gy(x, z)
    if g is not None and not free(x, g, z) and free(x, g + 1, z) and free(x, g + 2, z): base.spawns.append((x, g + 1, z))
for k in range(12):
    a = math.radians(k * 30 + 15); base_spawn(round(math.cos(a) * 36), round(math.sin(a) * 36))
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
assert len(base.spawns) >= 10, len(base.spawns)
n_base = len(base.chests) + len(base.riches)
print(KEY, 'base chests', n_base, 'rich', len(base.riches), 'ores', len(base.ores), 'spawns', len(base.spawns), 'decos', len(base.decos),
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
    for (x, y, z, nbt, et) in [d_ for d_ in c.decos if inrect(r, d_[0], d_[2])]:
        L.append(f"{pre}positioned ~{x} ~{y} ~{z} align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:{et} ~ ~ ~ {{Tags:[\"oa.mdeco\"],{nbt}}}")
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
         f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:block_display,tag=oa.mdeco,dx={x2 - x1},dy={NY - 1},dz={z2 - z1}]",
         f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:end_crystal,tag=oa.mdeco,dx={x2 - x1},dy={NY - 1},dz={z2 - z1}]",
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
if SPIKES:
    LY.append(f"data modify storage oa:maps spikes.{KEY} set value [" + ",".join(f"{{x:{x},y:{y + 80},z:{z}}}" for x, y, z in SPIKES) + "]")
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


# ======================================================================== 確認用の画像・ロビーの地図パネル・一覧
def topview(include_variant=None):
    """上から見た色と高さ（include_variant=v なら各スロットの種類 v を重ねる）。"""
    H = np.full((N, N), -999, int); C = np.zeros((N, N), int)
    has = base.g.any(axis=2)
    top = NY - 1 - np.argmax(base.g[:, :, ::-1] != 0, axis=2)
    for x in range(N):
        for z in range(N):
            if has[x, z]: H[x, z] = top[x, z] + Y0; C[x, z] = base.g[x, z, top[x, z]]
    if include_variant is not None:
        for vs in variants:
            cv = vs[include_variant]
            for x in range(cv.g.shape[0]):
                for z in range(cv.g.shape[1]):
                    col = cv.g[x, z, :]; nzi = np.nonzero(col)[0]
                    if not len(nzi): continue
                    gx, gz = x + cv.x1 + OFF, z + cv.z1 + OFF
                    if not (0 <= gx < N and 0 <= gz < N) or pal[col[nzi[-1]]] == 'minecraft:cave_air': continue
                    yy = nzi[-1] + Y0
                    if yy >= H[gx, gz]: H[gx, gz] = yy; C[gx, gz] = col[nzi[-1]]
    return H, C
COLS = {'grass_block': (96, 160, 70), 'dirt': (130, 96, 60), 'stone': (128, 128, 128), 'andesite': (136, 136, 136), 'tuff': (100, 100, 95),
        'end_stone': (222, 222, 160), 'obsidian': (40, 28, 60), 'water': (60, 110, 220), 'short_grass': (96, 170, 70),
        'white_concrete': (235, 238, 240), 'smooth_quartz': (230, 228, 222), 'quartz': (232, 228, 220),
        'sea_lantern': (190, 230, 230), 'purpur': (170, 120, 170), 'chorus': (120, 80, 120), 'light_blue_stained_glass': (120, 190, 230),
        'red_terracotta': (170, 70, 55), 'blue_terracotta': (75, 80, 140), 'cyan_terracotta': (90, 120, 125), 'orange_terracotta': (190, 105, 50),
        'light_blue_terracotta': (115, 120, 160), 'white_terracotta': (215, 185, 170), 'stone_brick': (122, 121, 122), 'oak': (162, 130, 78),
        'spruce': (115, 85, 50), 'dark_oak': (66, 43, 20), 'leaves': (60, 130, 45), 'wool': (230, 230, 230), 'gold': (240, 210, 70),
        'brick': (150, 85, 70), 'crimson': (150, 45, 75), 'cherry_leaves': (235, 165, 200), 'cherry_log': (90, 40, 50), 'bedrock': (70, 70, 70), 'froglight': (230, 200, 230), 'magenta_stained_glass': (200, 80, 200), 'amethyst': (140, 100, 190), 'end_rod': (240, 240, 240), 'glass': (200, 225, 235)}
def colof(b):
    n = b.split(':')[1].split('[')[0]
    if n in COLS: return COLS[n]
    for k_, v_ in sorted(COLS.items(), key=lambda kv: -len(kv[0])):
        if k_ in n: return v_
    return (150, 150, 150)
CLOUD = smooth(25, 9)
def render(H, C, size):
    from PIL import Image
    img = Image.new('RGB', (N, N)); px = img.load()
    rr_ = np.random.default_rng(5)
    for x in range(N):
        for z in range(N):
            if H[x, z] == -999:
                if KEY == 'sky':
                    t = z / N; c0 = (int(110 + 40 * t), int(165 + 30 * t), int(220 + 15 * t))
                    cl = CLOUD[x, z]
                    if cl > 0.6: k_ = min(0.85, (cl - 0.6) * 5); c0 = tuple(int(c * (1 - k_) + 248 * k_) for c in c0)
                else:
                    t = math.hypot(x - N / 2, z - N / 2) / N; c0 = (int(40 - 30 * t), int(18 - 10 * t), int(62 - 40 * t))
                    if rr_.random() < 0.01: c0 = (210, 200, 240)
                px[x, z] = c0; continue
            c = colof(pal[C[x, z]])
            hx = H[x - 1, z] if x > 0 and H[x - 1, z] != -999 else H[x, z] - 2
            hz = H[x, z - 1] if z > 0 and H[x, z - 1] != -999 else H[x, z] - 2
            sh = max(0.6, min(1.35, 1.0 + 0.08 * ((H[x, z] - hx) + (H[x, z] - hz)) + 0.012 * H[x, z]))
            px[x, z] = tuple(max(0, min(255, int(v * sh))) for v in c)
    return img.resize((size, size), Image.LANCZOS)
if PNG:
    H, C = topview(0); render(H, C, N * 2).save(PNG)
if PANEL:
    from PIL import Image, ImageDraw, ImageFont
    H, C = topview(None)
    img = render(H, C, 512)
    d_ = ImageDraw.Draw(img, 'RGBA')
    font = ImageFont.truetype('C:/Windows/Fonts/meiryob.ttc', 18); small = ImageFont.truetype('C:/Windows/Fonts/meiryob.ttc', 14)
    S_ = 512 / N
    def label(x, z, text, f=font, fill=(255, 255, 255)):
        X, Y = (x + OFF) * S_, (z + OFF) * S_
        w_ = d_.textlength(text, font=f); h_ = f.size + 8
        d_.rounded_rectangle([X - w_ / 2 - 7, Y - h_ / 2, X + w_ / 2 + 7, Y + h_ / 2], 6, fill=(15, 15, 28, 195))
        d_.text((X, Y), text, font=f, fill=fill, anchor='mm')
    label(0, 0, base.places[0][2], fill=(255, 225, 120))
    for (x, z, nm) in base.places[1:]: label(x, z + (17 if z < 0 else -17), nm, small)
    if KEY == 'sky':
        for k, (cx, cz, r, _) in enumerate(slots): label(cx, cz, '？', font, (170, 225, 255))
        note = '「？」の島の中身は会場を作るたびに変わります'
    else:
        for vs in variants:
            for (x, z, nm) in vs[0].places: label(x, z, nm, small, (235, 200, 255))
        note = '黒曜石の柱から「塔の砲撃」が来ることがあります'
    w_ = d_.textlength(note, font=small)
    d_.rounded_rectangle([256 - w_ / 2 - 8, 486, 256 + w_ / 2 + 8, 508], 6, fill=(15, 15, 28, 210))
    d_.text((256, 497), note, font=small, fill=(235, 235, 235), anchor='mm')
    img.save(PANEL)
json.dump({"key": KEY, "seed": SEED, "slots": [{"c": [s[0], s[1]], "r": s[2], "types": [cv.kind for cv in variants[k]]} for k, s in enumerate(slots)],
           "corners": corners, "bridges": len(BRIDGES), "teleporters": TP, "base_chests": n_base, "slot_chests": CH_PER_SLOT,
           "spawns_base": len(base.spawns), "decos": len(base.decos)}, open(f"{ROOT}/MAP_{KEY.upper()}_MANIFEST.json", "w", encoding="utf8"), ensure_ascii=False, indent=1, default=int)
ISO = sys.argv[sys.argv.index('--iso') + 1] if '--iso' in sys.argv else None
if ISO:
    # 確認用：斜め上から見た図（土台＋各スロットの種類0）
    from PIL import Image
    G = base.g.copy()
    for vs in variants:
        cv = vs[0]
        for x in range(cv.g.shape[0]):
            for z in range(cv.g.shape[1]):
                gx, gz = x + cv.x1 + OFF, z + cv.z1 + OFF
                if not (0 <= gx < N and 0 <= gz < N): continue
                col = cv.g[x, z, :]; m = col != 0
                G[gx, gz, m] = col[m]
    air2 = P('minecraft:cave_air'); G[G == air2] = 0
    xs, zs, ys = np.nonzero(G)
    lut = np.array([colof(b) if b not in ('minecraft:air',) else (0, 0, 0) for b in pal], float)
    S2 = 3
    u = ((xs - zs) + N) * S2 // 1; v = ((xs + zs) * 0.5 - (ys - 40) * 1.25) * S2 + 200
    depth = xs + zs + ys * 0.01
    order = np.argsort(depth)
    W_, H_ = int(2 * N * S2 + 10), int((N + 120) * S2 + 400)
    img = np.zeros((H_, W_, 3)); img[:] = (130, 180, 230) if KEY == 'sky' else (20, 10, 34)
    sh = 0.75 + 0.25 * (ys / 80.0)
    for i in order:
        c = lut[G[xs[i], zs[i], ys[i]]] * sh[i]
        uu, vv = int(u[i]), int(v[i])
        img[vv:vv + S2 + 1, uu:uu + S2 + 1] = c
    Image.fromarray(np.clip(img, 0, 255).astype('uint8')).save(ISO)
print('ok', KEY)
