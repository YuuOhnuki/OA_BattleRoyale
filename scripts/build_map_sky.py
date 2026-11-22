#!/usr/bin/env python3
"""OA Battle Royale 1.9.233: 天空都市（sky ＝ oa:br_sky）の生成。
使い方: py -3 scripts/build_map_sky.py <repo root> [--png 真上.png] [--iso 斜め上.png] [--panel ロビーのパネル.png] [--isles 島の見本の出力フォルダ]

1.9.233 で作りを変えた（ユーザーの指示）：
- 中央の島を大きく（半径64）。四角い城壁と角の丸い塔、門楼、回廊、赤い絨毯の中庭、大きな天守（画像1の城のような）。中央は固定で、
  これまでどおり 100 区画のタイル関数（maps/sky/tiles/*）に書き出す。
- まわりの島は「島の見本」10種類（砂漠・雪・メサ・オアシス・西洋の町・和風・飛行船・気球・天空神殿・リゾート）を構造物テンプレート
  （data/oa/structure/sky/<種類>.nbt）として持ち、会場を作るたびに 3〜6 個を選び、10 か所の候補地のどこかへ、向き（0/90/180/270度）も抽選して置く。
  中央への橋は候補地ごとに用意し、選ばれた所だけ架ける。チェスト・鉱石・開始地点・地点名は、（候補地・種類・向き）ごとの関数
  （maps/sky/isles/p/s<候補地>t<種類>r<向き>）が登録する（座標はここで計算済み）。
- 置く順番：区画の生成（中央）→ maps/sky/post（中央の開始地点・地点名）→ maps/sky/isles/begin（島を1つずつ：読み込み→橋→テンプレート→登録）。
  島を置き終わるまで oa_map2:job working=1b（試合を始められない）。

島のテンプレートは 61×81×61（中心が島の中心、y=0 が島の縁の高さ＝絶対80）。島の縁（半径の6割より外）は平らな y=0 にして、
どの向きから橋が来ても平らな所につながる。島の上 y=1〜4 の何もない所は空気も含めて書き出す（橋の手すりを消す）。
"""
import sys, os, re, glob, json, math, gzip, struct
import numpy as np

ROOT = sys.argv[1]
KEY = 'sky'
def arg(name):
    return sys.argv[sys.argv.index(name) + 1] if name in sys.argv else None
PNG, ISO, PANEL, ISLES_OUT = arg('--png'), arg('--iso'), arg('--panel'), arg('--isles')
DIM = 'oa:br_sky'; LABEL = '天空都市'
OUT = f"{ROOT}/data/oa/function/maps/{KEY}/tiles"
SRC = f"{ROOT}/data/oa/function/map/internal/tiles"
MD = f"{ROOT}/data/oa/function/maps/{KEY}"
SEED = 20261125
DATA_VERSION = 3953   # 1.21 の番号（26.3 の 5023 を書くと、テンプレートが何も置かれなかった。テスト用サーバーで確認）。ゲームが新しい版へ直して読む
rng = np.random.default_rng(SEED)
N = 305; OFF = 152; Y0 = -40; NY = 81; TOP = 40
HEAD = "# 生成: scripts/build_map_sky.py（直接編集しない）"

# ======================================================================== 格子
pal = ['minecraft:air']; pid = {'minecraft:air': 0}
def P(b):
    if b not in pid: pid[b] = len(pal); pal.append(b)
    return pid[b]
EXPLICIT_AIR = P('minecraft:cave_air')   # テンプレートで「空気を書く」印（書き出しで air にする）

class Canvas:
    def __init__(self, x1, z1, x2, z2, isle=False):
        self.x1, self.z1, self.x2, self.z2 = x1, z1, x2, z2
        self.isle = isle
        self.g = np.zeros((x2 - x1 + 1, z2 - z1 + 1, NY), np.uint16)
        self.chests = []; self.riches = []; self.ores = []; self.spawns = []; self.gims = []; self.places = []; self.decos = []
        self.surf = {}
    def inb(self, x, z): return self.x1 <= x <= self.x2 and self.z1 <= z <= self.z2
    def put(self, x, y, z, b):
        if self.inb(x, z) and Y0 <= y <= TOP: self.g[x - self.x1, z - self.z1, y - Y0] = P(b)
    def get(self, x, y, z):
        if self.inb(x, z) and Y0 <= y <= TOP: return pal[self.g[x - self.x1, z - self.z1, y - Y0]]
        return None

base = Canvas(-OFF, -OFF, OFF, OFF)
cur = base
RES = set()
def put(x, y, z, b):
    if cur is base and (x, z) in RES and b == 'minecraft:air': return
    cur.put(x, y, z, b)
def getb(x, y, z):
    v = cur.get(x, y, z)
    if v is None or v == 'minecraft:cave_air': return 'minecraft:air'
    return v
PASS = {'minecraft:air', 'minecraft:cave_air', 'minecraft:short_grass', 'minecraft:poppy', 'minecraft:dandelion', 'minecraft:azure_bluet',
        'minecraft:oxeye_daisy', 'minecraft:cornflower', 'minecraft:dead_bush', 'minecraft:snow', 'minecraft:fern', 'minecraft:pink_petals[flower_amount=4,facing=north]',
        'minecraft:red_carpet', 'minecraft:moss_carpet'}
def free(x, y, z): return getb(x, y, z) in PASS
def gy(x, z): return cur.surf.get((x, z))
def box(x1, y1, z1, x2, y2, z2, b):
    for x in range(min(x1, x2), max(x1, x2) + 1):
        for z in range(min(z1, z2), max(z1, z2) + 1):
            for y in range(min(y1, y2), max(y1, y2) + 1): put(x, y, z, b)
def hollow(x1, y1, z1, x2, y2, z2, b):
    box(x1, y1, z1, x2, y2, z1, b); box(x1, y1, z2, x2, y2, z2, b); box(x1, y1, z1, x1, y2, z2, b); box(x2, y1, z1, x2, y2, z2, b)
def clear(x1, y1, z1, x2, y2, z2): box(x1, y1, z1, x2, y2, z2, 'minecraft:air')
def chest(x, y, z, rich=False, face='north'):
    put(x, y, z, f'minecraft:chest[facing={face}]')
    (cur.riches if rich else cur.chests).append((x, y, z))
def ore(x, y, z, k):
    put(x, y, z, 'minecraft:coal_ore' if k == 1 else 'minecraft:redstone_ore'); cur.ores.append((x, y, z, k))
def spawn(x, y, z): cur.spawns.append((x, y, z))
def gim(x, y, z, tags): cur.gims.append((x, y, z, tags))
def drop_overwritten():
    cur.chests[:] = [c for c in cur.chests if (cur.get(*c) or '').startswith('minecraft:chest')]
    cur.riches[:] = [c for c in cur.riches if (cur.get(*c) or '').startswith('minecraft:chest')]
    cur.ores[:] = [o for o in cur.ores if cur.get(o[0], o[1], o[2]) in ('minecraft:coal_ore', 'minecraft:redstone_ore')]
    cur.spawns[:] = [s for s in cur.spawns if free(s[0], s[1], s[2]) and free(s[0], s[1] + 1, s[2]) and not free(s[0], s[1] - 1, s[2])]
def foundation(x1, z1, x2, z2, y0, b='minecraft:stone'):
    for x in range(x1, x2 + 1):
        for z in range(z1, z2 + 1):
            g = gy(x, z)
            if g is None: continue
            for y in range(g + 1, y0): put(x, y, z, b)
            if g > y0:
                for y in range(y0 + 1, g + 1): put(x, y, z, 'minecraft:air')

def smooth(scale, seed, n=N):
    r = np.random.default_rng(seed); k = n // scale + 3; a = r.random((k, k))
    xs = np.linspace(0, k - 3, n); i = xs.astype(int); f = xs - i
    return (a[i][:, i] * (1 - f)[:, None] * (1 - f)[None, :] + a[i + 1][:, i] * f[:, None] * (1 - f)[None, :]
            + a[i][:, i + 1] * (1 - f)[:, None] * f[None, :] + a[i + 1][:, i + 1] * f[:, None] * f[None, :])
NOISE = smooth(12, SEED + 1); HILL = smooth(11, SEED + 2); SPIKE = smooth(3, SEED + 3); HILL2 = smooth(5, SEED + 4)
def nz(x, z): return NOISE[(x + OFF) % N, (z + OFF) % N]
def hl(x, z): return 0.7 * HILL[(x + OFF) % N, (z + OFF) % N] + 0.3 * HILL2[(x + OFF) % N, (z + OFF) % N]
def sp(x, z): return SPIKE[(x + OFF) % N, (z + OFF) % N]

GRASS = dict(top='minecraft:grass_block', sub='minecraft:dirt', rock='minecraft:stone', rock2='minecraft:andesite', under='minecraft:tuff')
def island(cx, cz, r, depth, amp=0, flats=(), wob=0.24, mats=GRASS, rim=None, band=None, plateau=None, seed_off=0):
    """浮遊島。上面は起伏（amp）。rim（0〜1）を与えると、半径の rim 倍より外は平ら（y=0）。flats＝(x,z,半径) は平ら。
    band(y) が与えられれば岩の層の材料（メサの縞）。plateau＝丘の頭を平らに切る高さ。"""
    for x in range(int(cx - r * 1.35) - 1, int(cx + r * 1.35) + 2):
        for z in range(int(cz - r * 1.35) - 1, int(cz + r * 1.35) + 2):
            d = math.hypot(x - cx, z - cz) / (r * (1 + wob * (nz(x + seed_off, z) - 0.5) * 2))
            if d > 1: continue
            h = 0
            if amp:
                v = max(0.0, (hl(x + seed_off, z - seed_off) - 0.28) / 0.5)
                f = min(1.0, (1 - d) / 0.28) if rim is None else min(1.0, max(0.0, (rim - d) / 0.18))
                for fx, fz, fr in flats:
                    f *= min(1.0, max(0.0, (math.hypot(x - fx, z - fz) - fr) / 6.0))
                h = int(round(amp * min(1.0, v) * f))
                if plateau is not None and h > plateau: h = plateau
            put(x, h, z, mats['top'])
            for y in range(h - 1, h - 3, -1): put(x, y, z, mats['sub'])
            bottom = -2 - int(depth * ((1 - d) ** 0.55) * (0.72 + 0.56 * nz(z, x + seed_off)))
            s = sp(x + seed_off, z)
            if s > 0.66: bottom -= int(min(14, (s - 0.66) * 70 * (0.4 + (1 - d))))
            bottom = max(bottom, Y0 + 1)
            for y in range(h - 3, bottom - 1, -1):
                if band: m = band(y)
                else:
                    m = mats['under'] if y < -depth * 0.55 else (mats['rock2'] if nz(x + y, z) > 0.62 else mats['rock'])
                    if y >= -5 and nz(x - y, z + y) > 0.7 and mats['top'] == 'minecraft:grass_block': m = 'minecraft:dirt'
                put(x, y, z, m)
            cur.surf[(x, z)] = h

def spot(rr, cx, cz, rmin, rmax, need_top=None, tries=300):
    for _ in range(tries):
        a = rr.random() * 2 * math.pi; d = rmin + (rmax - rmin) * math.sqrt(rr.random())
        x, z = round(cx + math.cos(a) * d), round(cz + math.sin(a) * d)
        g = gy(x, z)
        if g is None or (x, z) in RES: continue
        if free(x, g, z) or getb(x, g, z) == 'minecraft:water': continue
        if need_top and getb(x, g, z) != need_top: continue
        if free(x, g + 1, z) and free(x, g + 2, z): return x, g, z
    return None

# ======================================================================== 部品
def tree_oak(x, z, g, h=5, lv='minecraft:oak_leaves[persistent=true]', log='minecraft:oak_log'):
    for y in range(g + 1, g + h + 1): put(x, y, z, log)
    for dx in range(-2, 3):
        for dz in range(-2, 3):
            for dy in range(h - 1, h + 2):
                if (abs(dx) + abs(dz) + max(0, dy - h) <= 3 and (dx, dz) != (0, 0)) or (dy == h + 1 and abs(dx) + abs(dz) <= 1):
                    if free(x + dx, g + dy, z + dz): put(x + dx, g + dy, z + dz, lv)
def tree_round(x, z, g, h=6, lv='minecraft:oak_leaves[persistent=true]', log='minecraft:oak_log', rad=3):
    """丸い大きな樹冠（建築の木）。"""
    for y in range(g + 1, g + h + 1): put(x, y, z, log)
    cy = g + h
    for dx in range(-rad, rad + 1):
        for dz in range(-rad, rad + 1):
            for dy in range(-rad + 1, rad):
                if dx * dx + dz * dz + (dy * 1.3) ** 2 <= rad * rad + 0.5 and free(x + dx, cy + dy, z + dz):
                    put(x + dx, cy + dy, z + dz, lv)
def tree_cherry(x, z, g, h=5): tree_round(x, z, g, h, 'minecraft:cherry_leaves[persistent=true]', 'minecraft:cherry_log', 3)
def tree_spruce(x, z, g, h=8, snowy=False):
    for y in range(g + 1, g + h + 1): put(x, y, z, 'minecraft:spruce_log')
    for k in range(h - 1):
        rad = max(0, (h - k) // 3 - (k % 2 == 0))
        y = g + 3 + k
        if y > g + h + 1: break
        for dx in range(-rad, rad + 1):
            for dz in range(-rad, rad + 1):
                if abs(dx) + abs(dz) <= rad + 1 and (dx, dz) != (0, 0) and free(x + dx, y, z + dz):
                    put(x + dx, y, z + dz, 'minecraft:spruce_leaves[persistent=true]')
                    if snowy and free(x + dx, y + 1, z + dz) and k % 2 == 1: put(x + dx, y + 1, z + dz, 'minecraft:snow')
    put(x, g + h + 1, z, 'minecraft:spruce_leaves[persistent=true]')
def tree_palm(x, z, g, h=7, rr=None):
    lean = (1 if (x + z) % 2 else -1)
    px = x
    for y in range(g + 1, g + h + 1):
        if y - g == h // 2: px += lean
        put(px, y, z, 'minecraft:jungle_log')
    ty = g + h + 1
    put(px, ty, z, 'minecraft:jungle_leaves[persistent=true]')
    for dx, dz in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        for k in range(1, 4):
            put(px + dx * k, ty - (1 if k == 3 else 0), z + dz * k, 'minecraft:jungle_leaves[persistent=true]')
    for dx, dz in ((1, 1), (-1, 1), (1, -1), (-1, -1)): put(px + dx, ty, z + dz, 'minecraft:jungle_leaves[persistent=true]')
def cactus(x, z, g, h=3):
    for y in range(g + 1, g + h + 1): put(x, y, z, 'minecraft:cactus')
def lamp(x, z, g, kind='lantern'):
    box(x, g + 1, z, x, g + 3, z, 'minecraft:dark_oak_fence' if kind == 'lantern' else 'minecraft:stone_brick_wall')
    put(x, g + 4, z, 'minecraft:lantern')
def gable(x, z, y0, w, d, mat_st, mat_full, axis='x', wall=None):
    """切妻屋根。axis='x' なら棟が x 方向（屋根の傾きは z 方向）。屋根は y0+1 から。"""
    if axis == 'x':
        k = 0
        while z - 1 + k <= z + d - k:
            za, zb = z - 1 + k, z + d - k
            for xx in range(x - 1, x + w + 1):
                if za == zb: put(xx, y0 + 1 + k, za, mat_full)
                else:
                    put(xx, y0 + 1 + k, za, f'{mat_st}[facing=south,half=bottom]'); put(xx, y0 + 1 + k, zb, f'{mat_st}[facing=north,half=bottom]')
            if wall:
                for xx in (x, x + w - 1):
                    for zz in range(za + 1, zb): put(xx, y0 + 1 + k, zz, wall)
            k += 1
    else:
        k = 0
        while x - 1 + k <= x + w - k:
            xa, xb = x - 1 + k, x + w - k
            for zz in range(z - 1, z + d + 1):
                if xa == xb: put(xa, y0 + 1 + k, zz, mat_full)
                else:
                    put(xa, y0 + 1 + k, zz, f'{mat_st}[facing=east,half=bottom]'); put(xb, y0 + 1 + k, zz, f'{mat_st}[facing=west,half=bottom]')
            if wall:
                for zz in (z, z + d - 1):
                    for xx in range(xa + 1, xb): put(xx, y0 + 1 + k, zz, wall)
            k += 1

def house_timber(x, z, y0, w, d, h=4, wall='minecraft:white_terracotta', frame='minecraft:dark_oak_log', roof=('minecraft:dark_oak_stairs', 'minecraft:dark_oak_planks'),
                 base='minecraft:cobblestone', chests=1, door='s', axis='x', rich=False):
    """木組みの家（西洋の町）。石の土台、白壁に黒い梁、切妻屋根、窓、戸口、ランタン。"""
    foundation(x, z, x + w - 1, z + d - 1, y0)
    box(x, y0, z, x + w - 1, y0, z + d - 1, 'minecraft:spruce_planks')
    hollow(x, y0 + 1, z, x + w - 1, y0 + 1, z + d - 1, base)
    hollow(x, y0 + 2, z, x + w - 1, y0 + h, z + d - 1, wall)
    for xx in range(x, x + w, 3):
        for zz in (z, z + d - 1): box(xx, y0 + 2, zz, xx, y0 + h, zz, frame)
    for zz in range(z, z + d, 3):
        for xx in (x, x + w - 1): box(xx, y0 + 2, zz, xx, y0 + h, zz, frame)
    for xx in (x, x + w - 1):
        for zz in (z, z + d - 1): box(xx, y0 + 1, zz, xx, y0 + h, zz, frame)
    hollow(x, y0 + h, z, x + w - 1, y0 + h, z + d - 1, 'minecraft:stripped_dark_oak_log[axis=x]' if axis == 'x' else 'minecraft:stripped_dark_oak_log[axis=z]')
    for xx in range(x + 1, x + w - 1, 2):
        for zz in (z, z + d - 1):
            if (xx - x) % 3: put(xx, y0 + 3, zz, 'minecraft:glass_pane')
    for zz in range(z + 1, z + d - 1, 2):
        for xx in (x, x + w - 1):
            if (zz - z) % 3: put(xx, y0 + 3, zz, 'minecraft:glass_pane')
    box(x + 1, y0 + h, z + 1, x + w - 2, y0 + h, z + d - 2, 'minecraft:spruce_planks')
    gable(x, z, y0 + h, w, d, roof[0], roof[1], axis, wall)
    mx, mz = x + w // 2, z + d // 2
    if door == 's': clear(mx, y0 + 1, z + d - 1, mx, y0 + 2, z + d - 1); put(mx, y0 + 3, z + d, 'minecraft:lantern[hanging=true]') if False else None
    elif door == 'n': clear(mx, y0 + 1, z, mx, y0 + 2, z)
    elif door == 'e': clear(x + w - 1, y0 + 1, mz, x + w - 1, y0 + 2, mz)
    else: clear(x, y0 + 1, mz, x, y0 + 2, mz)
    put(mx, y0 + h - 1, mz, 'minecraft:lantern[hanging=true]')
    # 煙突
    box(x + w - 2, y0 + h + 1, z + 1, x + w - 2, y0 + h + (min(w, d) + 1) // 2 + 2, z + 1, 'minecraft:bricks')
    for i in range(chests): chest(x + 1 + i * 2, y0 + 1, z + 1, rich=rich and i == 0, face='south')

def round_tower(x, z, y0, h, rad, wall='minecraft:stone_bricks', band='minecraft:polished_andesite', top='crenel', roof=None, ladder=True, door=((1, 0),), chest_top=True, rich=False):
    """丸い塔。top='crenel'（胸壁）か 'cone'（円錐の屋根）。"""
    for xx in range(x - rad, x + rad + 1):
        for zz in range(z - rad, z + rad + 1):
            d = math.hypot(xx - x, zz - z)
            if d > rad + 0.4: continue
            put(xx, y0, zz, 'minecraft:polished_andesite')
            for y in range(y0 + 1, y0 + h):
                put(xx, y, zz, (band if (y - y0) % 6 == 0 else wall) if d > rad - 0.8 else 'minecraft:air')
            put(xx, y0 + h, zz, 'minecraft:smooth_stone' if d <= rad - 0.8 else band)
            if top == 'crenel' and d > rad - 0.8:
                put(xx, y0 + h + 1, zz, wall)
                if (xx + zz) % 2 == 0: put(xx, y0 + h + 2, zz, wall)
    if rad >= 3:
        for y in range(y0 + 5, y0 + h - 1, 5):
            for (dx, dz) in ((rad, 0), (-rad, 0), (0, rad), (0, -rad)): put(x + dx, y, z + dz, 'minecraft:glass_pane')
    for (dx, dz) in door: clear(x + dx * rad, y0 + 1, z + dz * rad, x + dx * rad, y0 + 2, z + dz * rad)
    if ladder:
        for y in range(y0 + 1, y0 + h + 1): put(x, y, z - rad + 1, 'minecraft:ladder[facing=south]')
    if top == 'cone' and roof:
        k = 0
        while rad + 1 - k >= 0:
            for xx in range(x - rad - 1, x + rad + 2):
                for zz in range(z - rad - 1, z + rad + 2):
                    if math.hypot(xx - x, zz - z) <= rad + 1 - k + 0.3: put(xx, y0 + h + 1 + k, zz, roof)
            k += 1
        put(x, y0 + h + 2 + k, z, 'minecraft:lightning_rod')
    if chest_top and top == 'crenel': chest(x + (1 if rad > 1 else 0), y0 + h + 1, z + (1 if rad > 1 else 0), rich=rich)

# 飾り（block_display）
def bd(x, y, z, block, sx, sy, sz, ox=0.0, oy=0.0, oz=0.0, yaw=0.0, glow=False):
    nbt = (f'block_state:"{block}",view_range:6.0f,Rotation:[{yaw:.1f}f,0.0f],'
           f'transformation:{{translation:[{-sx / 2 + ox:.3f}f,{oy:.3f}f,{-sz / 2 + oz:.3f}f],left_rotation:[0.0f,0.0f,0.0f,1.0f],'
           f'scale:[{sx:.3f}f,{sy:.3f}f,{sz:.3f}f],right_rotation:[0.0f,0.0f,0.0f,1.0f]}}')
    if glow: nbt += ',brightness:{block:15,sky:15}'
    cur.decos.append((x, y, z, nbt, 'block_display'))
def balloon(x, y, z, c1, c2, yaw=0.0, s=1.0):
    bd(x, y, z, c1, 5.0 * s, 5.0 * s, 5.0 * s, oy=0.5 * s); bd(x, y, z, c2, 6.0 * s, 3.0 * s, 4.0 * s, oy=1.5 * s, yaw=yaw); bd(x, y, z, c2, 4.0 * s, 3.0 * s, 6.0 * s, oy=1.5 * s, yaw=yaw)
    bd(x, y, z, c1, 3.6 * s, 1.2 * s, 3.6 * s, oy=5.5 * s); bd(x, y, z, c1, 3.0 * s, 1.0 * s, 3.0 * s, oy=-0.6 * s)
    for (dx, dz) in ((-0.9, -0.9), (0.9, -0.9), (-0.9, 0.9), (0.9, 0.9)): bd(x, y, z, 'minecraft:oak_fence', 0.12, 2.6 * s, 0.12, ox=dx * s, oy=-3.2 * s, oz=dz * s)
    bd(x, y, z, 'minecraft:spruce_planks', 2.0 * s, 1.0 * s, 2.0 * s, oy=-4.0 * s)
def airship(x, y, z, yaw, c=('minecraft:white_wool', 'minecraft:red_wool')):
    bd(x, y, z, 'minecraft:dark_oak_planks', 3.0, 1.6, 10.0, yaw=yaw); bd(x, y, z, 'minecraft:dark_oak_planks', 2.0, 1.0, 12.0, oy=-0.6, yaw=yaw)
    bd(x, y, z, 'minecraft:spruce_planks', 3.4, 0.25, 10.4, oy=1.6, yaw=yaw)
    bd(x, y, z, c[0], 5.0, 4.5, 13.0, oy=4.8, yaw=yaw); bd(x, y, z, c[0], 3.6, 3.0, 15.0, oy=5.5, yaw=yaw)
    bd(x, y, z, c[1], 5.2, 0.8, 13.2, oy=6.2, yaw=yaw)
    bd(x, y, z, c[1], 0.3, 2.6, 2.4, oy=4.6, oz=-7.0, yaw=yaw); bd(x, y, z, c[1], 3.4, 0.3, 2.4, oy=5.6, oz=-7.0, yaw=yaw)

def ore_rocks(rr, cx, cz, rmin, rmax, n, host='minecraft:stone'):
    placed = 0
    for _ in range(n * 60):
        if placed >= n: break
        s = spot(rr, cx, cz, rmin, rmax)
        if not s: continue
        x, g, z = s
        if any(abs(x - o[0]) + abs(z - o[2]) < 3 for o in cur.ores): continue
        put(x, g + 1, z, host); ore(x, g + 1, z, 1 if placed % 3 else 3)
        if free(x + 1, g + 1, z) and gy(x + 1, z) == g: put(x + 1, g + 1, z, host)
        placed += 1

def add_spawns(rr, cx, cz, rmin, rmax, n, minsep=6):
    got = 0
    for _ in range(600):
        if got >= n: break
        s = spot(rr, cx, cz, rmin, rmax)
        if not s: continue
        x, g, z = s
        if all(gy(x + dx, z + dz) == g and not free(x + dx, g, z + dz) and free(x + dx, g + 1, z + dz) and free(x + dx, g + 2, z + dz)
               for dx in (-1, 0, 1) for dz in (-1, 0, 1)) and all(math.hypot(x - a, z - b) > minsep for a, _, b in cur.spawns):
            spawn(x, g + 1, z); got += 1

def fill_chests(rr, cx, cz, rmin, rmax, want):
    while len(cur.chests) + len(cur.riches) < want:
        s = spot(rr, cx, cz, rmin, rmax)
        if not s: break
        chest(s[0], s[1] + 1, s[2])

# ======================================================================== 候補地・橋の計画
CR = 64
SITES = []
for k in range(10):
    a = math.radians(k * 36 + 9); rad = 110 + (k % 2) * 12
    SITES.append((round(math.cos(a) * rad), round(math.sin(a) * rad)))
BRIDGE_END_IN = 8   # 島の中心から、橋の端までの距離（島の縁の平らな所に届く）
def bridge_points(s):
    sx, sz = SITES[s]; d = math.hypot(sx, sz); ux, uz = sx / d, sz / d
    return (ux * (CR - 7), uz * (CR - 7)), (sx - ux * BRIDGE_END_IN, sz - uz * BRIDGE_END_IN)
ENDS = [bridge_points(s)[0] for s in range(10)]

# ======================================================================== 中央：天空城
cur = base
island(0, 0, CR, 38, amp=9, flats=[(0, 0, 44)] + [(ex, ez, 6) for ex, ez in ENDS])
for ex, ez in ENDS:
    for dx in range(-4, 5):
        for dz in range(-4, 5): RES.add((round(ex) + dx, round(ez) + dz))
W_ = 34   # 城壁の外側
STONE, STONE2, TRIM = 'minecraft:stone_bricks', 'minecraft:polished_andesite', 'minecraft:smooth_stone'
# 中庭の床（石畳と赤い道）
for x in range(-W_ + 1, W_):
    for z in range(-W_ + 1, W_):
        put(x, 0, z, 'minecraft:stone_bricks' if (x + z) % 5 else 'minecraft:mossy_stone_bricks')
        if abs(x) <= 1 or abs(z) <= 1: put(x, 0, z, 'minecraft:red_wool')
        if abs(x) == 2 or abs(z) == 2: put(x, 0, z, 'minecraft:gold_block' if (x + z) % 6 == 0 else 'minecraft:polished_andesite')
# 城壁（厚さ3・高さ9、上に通路と胸壁、内側に赤い垂れ幕）
for x in range(-W_, W_ + 1):
    for z in range(-W_, W_ + 1):
        if max(abs(x), abs(z)) < W_ - 2: continue
        for y in range(1, 9): put(x, y, z, STONE if (y % 4) else STONE2)
        put(x, 9, z, TRIM)
        if max(abs(x), abs(z)) == W_ and (x + z) % 2 == 0: put(x, 10, z, STONE)
        if max(abs(x), abs(z)) == W_: put(x, 10, z, STONE) if (x + z) % 2 == 0 else None
for x in range(-W_ + 4, W_ - 3, 6):
    for (zz, f) in ((-W_ + 3, 'south'), (W_ - 3, 'north')):
        box(x, 3, zz, x, 7, zz, 'minecraft:red_wool'); put(x, 2, zz, 'minecraft:red_carpet') if False else None
    for (xx, f) in ((-W_ + 3, 'east'), (W_ - 3, 'west')):
        box(xx, 3, x, xx, 7, x, 'minecraft:red_wool')
# 城壁の上へ上がる階段（内側の4か所）
for (sx_, sz_, dx, dz) in ((-20, -W_ + 3, 1, 0), (20, W_ - 3, -1, 0), (-W_ + 3, 20, 0, -1), (W_ - 3, -20, 0, 1)):
    for i in range(9):
        x, z = sx_ + dx * i, sz_ + dz * i
        box(x, 1, z, x, i, z, STONE)
        put(x, i + 1, z, STONE)
        if dz == 0: box(x, 1, z + (1 if sz_ < 0 else -1), x, i + 1, z + (1 if sz_ < 0 else -1), STONE)
        else: box(x + (1 if sx_ < 0 else -1), 1, z, x + (1 if sx_ < 0 else -1), i + 1, z, STONE)
# 門（4方向。幅5・高さ6）と門楼の小塔
for (dx, dz) in ((1, 0), (-1, 0), (0, 1), (0, -1)):
    gx, gz = dx * W_, dz * W_
    if dx: clear(gx - 2 * dx, 1, -2, gx, 6, 2)
    else: clear(-2, 1, gz - 2 * dz, 2, 6, gz)
    for sgn in (-1, 1):
        tx, tz = (gx, sgn * 5) if dx else (sgn * 5, gz)
        round_tower(tx, tz, 0, 14, 3, top='crenel', door=((-dx, -dz),) if (dx or dz) else ((1, 0),), chest_top=sgn == 1)
    # 門の上の金の鐘
    put(gx - dx * 1, 7, gz - dz * 1, 'minecraft:bell[attachment=ceiling,facing=north]') if False else None
# 角の大きな丸い塔（円錐の屋根）
for (sx_, sz_) in ((-1, -1), (1, -1), (-1, 1), (1, 1)):
    round_tower(sx_ * W_, sz_ * W_, 0, 20, 6, top='cone', roof='minecraft:deepslate_tiles', door=((-sx_, 0), (0, -sz_)), chest_top=False)
    for y in (10,):   # 城壁の通路から入る口
        clear(sx_ * W_ - sx_ * 6, 10, sz_ * W_, sx_ * W_ - sx_ * 6, 11, sz_ * W_); clear(sx_ * W_, 10, sz_ * W_ - sz_ * 6, sx_ * W_, 11, sz_ * W_ - sz_ * 6)
    chest(sx_ * W_ + sx_ * 2, 1, sz_ * W_, face='north'); box(sx_ * W_, 13, sz_ * W_ - 4, sx_ * W_ + 0, 13, sz_ * W_ + 4, 'minecraft:spruce_planks')
    chest(sx_ * W_ - 2, 14, sz_ * W_ - 1)
# 回廊（城壁の内側の柱廊。屋根の上は歩ける）
for i in range(-W_ + 6, W_ - 5, 4):
    for (x, z) in ((i, -W_ + 7), (i, W_ - 7), (-W_ + 7, i), (W_ - 7, i)):
        if abs(i) <= 4: continue
        box(x, 1, z, x, 4, z, 'minecraft:quartz_pillar'); put(x, 5, z, 'minecraft:chiseled_stone_bricks')
for x in range(-W_ + 3, W_ - 2):
    for z in range(-W_ + 3, W_ - 2):
        if W_ - 7 <= max(abs(x), abs(z)) <= W_ - 3 and min(abs(x), abs(z)) > 4: put(x, 6, z, 'minecraft:stone_brick_slab[type=bottom]')
# 中庭の飾り：噴水・金の像・生け垣・花壇
for (fx, fz) in ((-17, -17), (17, -17), (-17, 17), (17, 17)):
    hollow(fx - 3, 1, fz - 3, fx + 3, 1, fz + 3, 'minecraft:polished_andesite'); box(fx - 2, 0, fz - 2, fx + 2, 0, fz + 2, 'minecraft:water')
    box(fx, 1, fz, fx, 3, fz, 'minecraft:quartz_pillar'); put(fx, 4, fz, 'minecraft:gold_block')
for (hx, hz) in ((-10, -22), (10, -22), (-10, 22), (10, 22), (-22, -10), (22, -10), (-22, 10), (22, 10)):
    box(hx - 2, 1, hz, hx + 2, 2, hz, 'minecraft:oak_leaves[persistent=true]') if hz in (-22, 22) else box(hx, 1, hz - 2, hx, 2, hz + 2, 'minecraft:oak_leaves[persistent=true]')
for (px_, pz_) in ((-6, -26), (6, -26), (-6, 26), (6, 26), (-26, -6), (26, -6), (-26, 6), (26, 6)):
    put(px_, 1, pz_, 'minecraft:polished_andesite'); put(px_, 2, pz_, 'minecraft:gold_block')
# 天守（23×23、高さ24、3階建て。屋上の四隅に尖塔）
K = 11
hollow(-K, 1, -K, K, 23, K, 'minecraft:white_terracotta')
for y in (1, 8, 15, 23): hollow(-K, y, -K, K, y, K, STONE)
for (x, z) in ((-K, -K), (K, -K), (-K, K), (K, K)): box(x, 1, z, x, 24, z, 'minecraft:quartz_pillar')
for i in range(-K + 3, K - 2, 4):
    for y in (3, 4, 10, 11, 18, 19):
        for (x, z) in ((i, -K), (i, K), (-K, i), (K, i)):
            if abs(i) > 2: put(x, y, z, 'minecraft:glass_pane')
for fy in (7, 14): box(-K + 1, fy, -K + 1, K - 1, fy, K - 1, 'minecraft:spruce_planks')
box(-K, 23, -K, K, 23, K, STONE)
for x in range(-K, K + 1):
    for z in (-K, K):
        if x % 2 == 0: put(x, 24, z, STONE); put(z, 24, x, STONE)
for (dx, dz) in ((0, K), (0, -K), (K, 0), (-K, 0)):
    clear(dx - (1 if dz else 0), 1, dz - (1 if dx else 0), dx + (1 if dz else 0), 4, dz + (1 if dx else 0))
    put(dx - (2 if dz else 0) * 1, 5, dz - (2 if dx else 0), 'minecraft:chiseled_stone_bricks')
for fy in (7, 14, 23):
    clear(-K + 2, fy, -K + 1, -K + 2, fy, -K + 1); clear(K - 2, fy, K - 1, K - 2, fy, K - 1)
for y in range(1, 24): put(-K + 2, y, -K + 1, 'minecraft:ladder[facing=south]'); put(K - 2, y, K - 1, 'minecraft:ladder[facing=north]')
box(-1, 1, -1, 1, 1, 1, 'minecraft:red_carpet'); put(0, 6, 0, 'minecraft:lantern[hanging=true]'); put(0, 13, 0, 'minecraft:lantern[hanging=true]')
chest(-7, 1, 7); chest(7, 1, -7); chest(-7, 8, -7); chest(7, 8, 7, rich=True); chest(-7, 15, 7, rich=True); chest(7, 15, -7)
for (sx_, sz_) in ((-1, -1), (1, -1), (-1, 1), (1, 1)):
    round_tower(sx_ * (K - 1), sz_ * (K - 1), 23, 6, 2, wall='minecraft:white_terracotta', top='cone', roof='minecraft:deepslate_tiles', ladder=False, door=(), chest_top=False)
box(-2, 24, -2, 2, 30, 2, 'minecraft:white_terracotta'); box(-3, 31, -3, 3, 31, 3, 'minecraft:deepslate_tiles')
for k in range(1, 4): box(-3 + k, 31 + k, -3 + k, 3 - k, 31 + k, 3 - k, 'minecraft:deepslate_tiles')
for (x, z) in ((0, -3), (0, 3), (-3, 0), (3, 0)): put(x, 28, z, 'minecraft:gold_block')
box(0, 35, 0, 0, 37, 0, 'minecraft:oak_fence'); put(1, 37, 0, 'minecraft:red_wool'); put(2, 37, 0, 'minecraft:red_wool')
cur.places.append((0, 0, '天空城'))
# 城の外：丘の木・花・家・チェスト・鉱石
rr0 = np.random.default_rng(SEED + 11)
for _ in range(70):
    s = spot(rr0, 0, 0, 40, CR - 6, need_top='minecraft:grass_block')
    if not s: continue
    x, g, z = s
    if any(math.hypot(x - ex, z - ez) < 8 for ex, ez in ENDS): continue
    v = rr0.random()
    if v < 0.45: tree_round(x, z, g, 4 + int(rr0.random() * 3), rad=2 + int(rr0.random() * 2))
    elif v < 0.6: tree_cherry(x, z, g, 4)
    else: put(x, g + 1, z, str(rr0.choice(['minecraft:poppy', 'minecraft:cornflower', 'minecraft:oxeye_daisy', 'minecraft:short_grass', 'minecraft:short_grass'])))
for k in range(6):
    a = math.radians(k * 60 + 30); x0, z0 = round(math.cos(a) * 50), round(math.sin(a) * 50)
    if any(math.hypot(x0 - ex, z0 - ez) < 12 for ex, ez in ENDS): continue
    g = gy(x0, z0)
    if g is None: continue
    house_timber(x0 - 3, z0 - 2, g, 7, 5, chests=1, roof=('minecraft:spruce_stairs', 'minecraft:spruce_planks') if k % 2 else ('minecraft:dark_oak_stairs', 'minecraft:dark_oak_planks'))
ore_rocks(rr0, 0, 0, 40, CR - 6, 10)
fill_chests(rr0, 0, 0, 40, CR - 8, len(cur.chests) + len(cur.riches) + 4)
# 開始地点：中庭と城の外
for k in range(8):
    a = math.radians(k * 45 + 22.5); x, z = round(math.cos(a) * 22), round(math.sin(a) * 22)
    if free(x, 1, z) and free(x, 2, z): spawn(x, 1, z)
add_spawns(rr0, 0, 0, 40, CR - 6, 10)
# 救済用の足場と上昇気流（中央の島の外の下。4か所）
for k in range(4):
    a = math.radians(k * 90 + 45 + 9)
    px_, pz_ = round(math.cos(a) * 74), round(math.sin(a) * 74)
    box(px_ - 3, -26, pz_ - 3, px_ + 3, -26, pz_ + 3, 'minecraft:stone'); box(px_ - 3, -27, pz_ - 3, px_ + 3, -27, pz_ + 3, 'minecraft:tuff')
    put(px_, -26, pz_, 'minecraft:gold_block')
    gim(px_, -25, pz_, ['oa.gim', 'oa.gim_up', 'oa.gim_up_31'])
    chest(px_ - 2, -25, pz_ - 2)
# 空の飾り
for j, (bx_, by_, bz_) in enumerate(((-40, 32, 46), (44, 34, -40), (10, 38, 50), (-80, 28, -60), (84, 30, 66), (-140, 30, 20), (140, 28, -30), (30, 34, -140), (-30, 30, 140))):
    cs = [('minecraft:red_wool', 'minecraft:white_wool'), ('minecraft:blue_wool', 'minecraft:yellow_wool'), ('minecraft:orange_wool', 'minecraft:white_wool'),
          ('minecraft:light_blue_wool', 'minecraft:white_wool')][j % 4]
    balloon(bx_, by_, bz_, cs[0], cs[1], yaw=j * 20.0)
airship(-60, 24, 84, 30.0); airship(84, 22, -70, 210.0, ('minecraft:white_wool', 'minecraft:blue_wool')); airship(-120, 18, -110, 100.0)
drop_overwritten()
print('center: chests', len(base.chests), 'rich', len(base.riches), 'ores', len(base.ores), 'spawns', len(base.spawns), 'decos', len(base.decos))
assert len(base.spawns) >= 12

# ======================================================================== 島の見本（10種類）
ISLES = []   # (key, 名前, 半径, 作る関数)
def isle(key, name, r):
    def deco(fn): ISLES.append((key, name, r, fn)); return fn
    return deco
def fin(rr, r, want_chests=7, spawns=5, ores=4, host='minecraft:stone'):
    drop_overwritten()
    fill_chests(rr, 0, 0, 4, r * 0.85, want_chests)
    while len(cur.chests) + len(cur.riches) > want_chests and cur.chests:
        x, y, z = cur.chests.pop(); put(x, y, z, 'minecraft:air')
    ore_rocks(rr, 0, 0, 3, r * 0.85, ores, host)
    add_spawns(rr, 0, 0, 2, r * 0.9, spawns)
    drop_overwritten()

@isle('desert', '砂漠の島', 22)
def b_desert(rr, r):
    M = dict(top='minecraft:sand', sub='minecraft:sandstone', rock='minecraft:sandstone', rock2='minecraft:smooth_sandstone', under='minecraft:terracotta')
    island(0, 0, r, 26, amp=6, mats=M, rim=0.62, seed_off=101)
    # 段々のピラミッド（中は宝の部屋）
    P_ = 8
    for k in range(P_ + 1):
        box(-P_ + k, k, -P_ + k, P_ - k, k, P_ - k, 'minecraft:cut_sandstone' if k % 2 else 'minecraft:sandstone')
    box(-P_ + 1, 1, -P_ + 1, P_ - 1, 3, P_ - 1, 'minecraft:sandstone')
    clear(-3, 1, -3, 3, 3, 3); clear(-1, 1, 3, 1, 2, P_)
    for k in range(P_ + 1): put(0, k, P_ - k + 1, 'minecraft:sandstone_stairs[facing=north]') if k < 4 else None
    put(0, P_ + 1, 0, 'minecraft:gold_block'); box(-1, 1, -3, 1, 1, -3, 'minecraft:chiseled_sandstone')
    chest(0, 1, -2, rich=True, face='south'); put(-3, 2, 0, 'minecraft:lantern') if False else None
    for (x, z) in ((-2, 2), (2, 2)): put(x, 2, z, 'minecraft:torch')
    # 砂岩の家2軒と井戸、サボテン・枯れ木、日よけ
    for (hx, hz) in ((10, -6), (-12, 4)):
        g = 0
        box(hx - 2, 0, hz - 2, hx + 2, 0, hz + 2, 'minecraft:smooth_sandstone'); hollow(hx - 2, 1, hz - 2, hx + 2, 4, hz + 2, 'minecraft:smooth_sandstone')
        box(hx - 2, 5, hz - 2, hx + 2, 5, hz + 2, 'minecraft:cut_sandstone_slab[type=bottom]'); clear(hx, 1, hz + 2, hx, 2, hz + 2)
        put(hx - 2, 3, hz, 'minecraft:orange_stained_glass_pane'); chest(hx - 1, 1, hz - 1)
        box(hx - 3, 4, hz + 3, hx + 3, 4, hz + 4, 'minecraft:orange_wool'); put(hx - 3, 1, hz + 4, 'minecraft:birch_fence'); box(hx - 3, 1, hz + 4, hx - 3, 3, hz + 4, 'minecraft:birch_fence'); box(hx + 3, 1, hz + 4, hx + 3, 3, hz + 4, 'minecraft:birch_fence')
    hollow(-11, 1, -11, -9, 1, -9, 'minecraft:sandstone_wall'); put(-10, 0, -10, 'minecraft:water'); box(-11, 3, -11, -9, 3, -9, 'minecraft:smooth_sandstone_slab[type=bottom]'); put(-11, 2, -11, 'minecraft:sandstone_wall'); put(-9, 2, -9, 'minecraft:sandstone_wall')
    for _ in range(14):
        s = spot(rr, 0, 0, 10, r * 0.95, need_top='minecraft:sand')
        if s: (cactus(s[0], s[2], s[1], 2 + int(rr.random() * 2)) if rr.random() < 0.6 else put(s[0], s[1] + 1, s[2], 'minecraft:dead_bush'))
    fin(rr, r, host='minecraft:sandstone')

@isle('snow', '雪の島', 22)
def b_snow(rr, r):
    M = dict(top='minecraft:snow_block', sub='minecraft:dirt', rock='minecraft:stone', rock2='minecraft:packed_ice', under='minecraft:tuff')
    island(0, 0, r, 26, amp=10, mats=M, rim=0.62, seed_off=202)
    # 丸太小屋（切妻・雪）とかまくら、氷の池、氷の柱
    house_timber(-4, -3, 0, 8, 6, wall='minecraft:spruce_planks', frame='minecraft:stripped_spruce_log', roof=('minecraft:spruce_stairs', 'minecraft:spruce_planks'), base='minecraft:cobblestone', chests=2)
    for x in range(-5, 5):
        for z in range(-4, 4):
            for y in range(4, 12):
                if getb(x, y, z) in ('minecraft:spruce_stairs[facing=south,half=bottom]', 'minecraft:spruce_stairs[facing=north,half=bottom]', 'minecraft:spruce_planks') and free(x, y + 1, z): put(x, y + 1, z, 'minecraft:snow')
    ix, iz = 10, 8
    for x in range(ix - 4, ix + 5):
        for z in range(iz - 4, iz + 5):
            for y in range(0, 5):
                d = math.hypot(x - ix, z - iz, y * 1.1)
                if 3.4 <= d <= 4.4: put(x, y + (1 if y else 1), z, 'minecraft:snow_block') if y > 0 else None
    for x in range(ix - 4, ix + 5):
        for z in range(iz - 4, iz + 5):
            for y in range(1, 6):
                d = math.hypot(x - ix, z - iz, (y - 1) * 1.1)
                if 3.4 <= d <= 4.4: put(x, y, z, 'minecraft:snow_block')
    clear(ix, 1, iz - 4, ix, 2, iz - 3); chest(ix, 1, iz, face='north'); put(ix + 1, 1, iz + 1, 'minecraft:lantern')
    for x in range(-12, -5):
        for z in range(4, 11):
            if math.hypot(x + 9, z - 7) < 3.2 and gy(x, z) is not None: put(x, gy(x, z), z, 'minecraft:ice')
    for (sx_, sz_) in ((12, -10), (-13, -9), (5, 14)):
        g = gy(sx_, sz_)
        if g is None: continue
        hh = 6 + int(rr.random() * 6)
        box(sx_, g + 1, sz_, sx_, g + hh, sz_, 'minecraft:packed_ice')
        for (dx, dz) in ((1, 0), (0, 1), (-1, 0), (0, -1)): box(sx_ + dx, g + 1, sz_ + dz, sx_ + dx, g + hh // 2, sz_ + dz, 'minecraft:packed_ice')
    for _ in range(16):
        s = spot(rr, 0, 0, 8, r * 0.95, need_top='minecraft:snow_block')
        if s: tree_spruce(s[0], s[2], s[1], 6 + int(rr.random() * 4), snowy=True)
    for (x, z), g in list(cur.surf.items()):
        if getb(x, g, z) == 'minecraft:snow_block' and free(x, g + 1, z) and rr.random() < 0.5: put(x, g + 1, z, 'minecraft:snow')
    fin(rr, r)

@isle('mesa', 'メサの島', 23)
def b_mesa(rr, r):
    BANDS = ['minecraft:terracotta', 'minecraft:orange_terracotta', 'minecraft:yellow_terracotta', 'minecraft:terracotta', 'minecraft:red_terracotta',
             'minecraft:white_terracotta', 'minecraft:light_gray_terracotta', 'minecraft:brown_terracotta', 'minecraft:orange_terracotta']
    band = lambda y: BANDS[(y + 40) % len(BANDS)]
    M = dict(top='minecraft:red_sand', sub='minecraft:orange_terracotta', rock='minecraft:terracotta', rock2='minecraft:terracotta', under='minecraft:terracotta')
    island(0, 0, r, 28, amp=0, mats=M, rim=0.62, band=band, seed_off=303)
    # 台地（メサ）を2つ。上へは階段（木の足場）
    for (mx, mz, mr, mh) in ((-6, -5, 7, 11), (8, 6, 5, 7)):
        for x in range(mx - mr - 1, mx + mr + 2):
            for z in range(mz - mr - 1, mz + mr + 2):
                d = math.hypot(x - mx, z - mz) / (mr * (1 + 0.2 * (nz(x * 3, z * 3) - 0.5)))
                if d > 1: continue
                for y in range(1, mh + 1): put(x, y, z, band(y))
                put(x, mh, z, 'minecraft:red_sand'); cur.surf[(x, z)] = mh
                if rr.random() < 0.08: put(x, mh + 1, z, 'minecraft:dead_bush')
        # 木の足場の階段（外周に沿って）
        a0 = math.atan2(-mz, -mx)
        for i in range(mh):
            a = a0 + i * 0.22; x, z = round(mx + math.cos(a) * (mr + 1.5)), round(mz + math.sin(a) * (mr + 1.5))
            box(x, 1, z, x, i, z, 'minecraft:oak_fence') if i > 1 else None
            put(x, i + 1, z, 'minecraft:spruce_slab[type=top]')
        chest(mx, mh + 1, mz, rich=mr >= 7)
    # 自然のアーチ
    for t in np.linspace(0, math.pi, 30):
        x = round(12 * math.cos(t) * 0.5 + 0); z = -14; y = round(1 + 7 * math.sin(t))
        box(x - 6 + round(6 - 6 * math.cos(t)), y, z - 1, x - 6 + round(6 - 6 * math.cos(t)), y + 1, z + 1, band(y))
    # 廃坑の入口（木の枠）と荷車
    box(14, 1, -4, 14, 3, -4, 'minecraft:oak_fence'); box(14, 1, 0, 14, 3, 0, 'minecraft:oak_fence'); box(14, 4, -4, 14, 4, 0, 'minecraft:oak_planks')
    chest(15, 1, -2, face='west')
    for _ in range(10):
        s = spot(rr, 0, 0, 10, r * 0.95)
        if s: (cactus(s[0], s[2], s[1], 2) if rr.random() < 0.4 else put(s[0], s[1] + 1, s[2], 'minecraft:dead_bush'))
    fin(rr, r, host='minecraft:terracotta')

@isle('oasis', 'オアシスの島', 21)
def b_oasis(rr, r):
    M = dict(top='minecraft:sand', sub='minecraft:sandstone', rock='minecraft:sandstone', rock2='minecraft:smooth_sandstone', under='minecraft:terracotta')
    island(0, 0, r, 24, amp=4, mats=M, rim=0.62, seed_off=404)
    for x in range(-10, 11):
        for z in range(-10, 11):
            d = math.hypot(x, z)
            if d < 6.5: put(x, 0, z, 'minecraft:water'); put(x, -1, z, 'minecraft:sand'); cur.surf[(x, z)] = 0
            elif d < 9.5 and gy(x, z) is not None: put(x, gy(x, z), z, 'minecraft:grass_block')
    for (x, z) in ((-2, 1), (3, -2), (0, 4)): put(x, 1, z, 'minecraft:lily_pad')
    for k in range(7):
        a = k * 2 * math.pi / 7 + 0.3; x, z = round(math.cos(a) * 8), round(math.sin(a) * 8)
        g = gy(x, z)
        if g is not None: tree_palm(x, z, g, 6 + k % 3)
    # 隊商のテント（色の布）と市場
    for j, (tx, tz) in enumerate(((12, 4), (-12, -4), (2, -13))):
        cols = ['minecraft:red_wool', 'minecraft:yellow_wool', 'minecraft:blue_wool'][j]
        for (dx, dz) in ((-2, -2), (2, -2), (-2, 2), (2, 2)): box(tx + dx, 1, tz + dz, tx + dx, 2, tz + dz, 'minecraft:birch_fence')
        box(tx - 2, 3, tz - 2, tx + 2, 3, tz + 2, cols); box(tx - 1, 4, tz - 1, tx + 1, 4, tz + 1, cols); put(tx, 5, tz, 'minecraft:white_wool')
        box(tx - 2, 0, tz - 2, tx + 2, 0, tz + 2, 'minecraft:smooth_sandstone'); chest(tx, 1, tz)
        put(tx + 1, 1, tz - 1, 'minecraft:barrel[facing=up]')
    fin(rr, r, host='minecraft:sandstone')

@isle('western', '西洋の町の島', 25)
def b_western(rr, r):
    island(0, 0, r, 28, amp=0, rim=0.62, seed_off=505)
    # 石畳の広場と噴水
    for x in range(-r, r + 1):
        for z in range(-r, r + 1):
            if gy(x, z) is None: continue
            if math.hypot(x, z) < 7.5 or (abs(x) <= 1 and abs(z) < r - 2) or (abs(z) <= 1 and abs(x) < r - 2):
                put(x, 0, z, 'minecraft:stone_bricks' if (x * 3 + z) % 4 else 'minecraft:cobblestone')
    hollow(-2, 1, -2, 2, 1, 2, 'minecraft:stone_brick_wall'); box(-1, 0, -1, 1, 0, 1, 'minecraft:water'); box(0, 1, 0, 0, 3, 0, 'minecraft:stone_brick_wall'); put(0, 4, 0, 'minecraft:lantern')
    # 家（木組み・色の屋根）を4つの区画に
    roofs = [('minecraft:dark_oak_stairs', 'minecraft:dark_oak_planks'), ('minecraft:spruce_stairs', 'minecraft:spruce_planks'),
             ('minecraft:brick_stairs', 'minecraft:bricks'), ('minecraft:deepslate_tile_stairs', 'minecraft:deepslate_tiles')]
    lots = [(4, 4, 7, 6, 'n', 'x'), (4, -10, 6, 6, 's', 'z'), (-11, 4, 6, 7, 'n', 'z'), (11, -3, 6, 5, 'w', 'x'), (-6, -17, 6, 5, 's', 'x'), (-17, -4, 5, 7, 'e', 'z')]
    for j, (hx, hz, w, d, door, ax) in enumerate(lots):
        house_timber(hx, hz, 0, w, d, h=4 + (j % 2), roof=roofs[j % 4], chests=1, door=door, axis=ax, wall=['minecraft:white_terracotta', 'minecraft:smooth_sandstone', 'minecraft:white_terracotta'][j % 3])
    # 教会（尖塔）
    cx_, cz_ = -8, -8
    box(cx_ - 3, 0, cz_ - 4, cx_ + 3, 0, cz_ + 4, 'minecraft:stone_bricks'); hollow(cx_ - 3, 1, cz_ - 4, cx_ + 3, 6, cz_ + 4, 'minecraft:stone_bricks')
    gable(cx_ - 3, cz_ - 4, 6, 7, 9, 'minecraft:deepslate_tile_stairs', 'minecraft:deepslate_tiles', 'z', 'minecraft:stone_bricks')
    clear(cx_, 1, cz_ + 4, cx_, 3, cz_ + 4)
    for y in (3, 4): put(cx_ - 3, y, cz_ - 2, 'minecraft:yellow_stained_glass_pane'); put(cx_ + 3, y, cz_ - 2, 'minecraft:blue_stained_glass_pane'); put(cx_ - 3, y, cz_ + 1, 'minecraft:red_stained_glass_pane'); put(cx_ + 3, y, cz_ + 1, 'minecraft:yellow_stained_glass_pane')
    box(cx_ - 1, 1, cz_ - 6, cx_ + 1, 14, cz_ - 4, 'minecraft:stone_bricks'); clear(cx_, 10, cz_ - 6, cx_, 12, cz_ - 4)
    for k in range(4): box(cx_ - 1 + (k > 1), 15 + k, cz_ - 6 + (k > 1), cx_ + 1 - (k > 1), 15 + k, cz_ - 4 - (k > 1), 'minecraft:deepslate_tiles')
    put(cx_, 19, cz_ - 5, 'minecraft:lightning_rod'); put(cx_, 11, cz_ - 5, 'minecraft:bell[attachment=ceiling,facing=north]')
    chest(cx_, 1, cz_ - 3, rich=True, face='south')
    for (lx, lz) in ((3, 9), (-3, -12), (9, 3), (-12, 3)): lamp(lx, lz, 0)
    for _ in range(10):
        s = spot(rr, 0, 0, 15, r * 0.95, need_top='minecraft:grass_block')
        if s: tree_round(s[0], s[2], s[1], 4, rad=2)
    fin(rr, r)

@isle('japan', '和風の島', 24)
def b_japan(rr, r):
    island(0, 0, r, 28, amp=5, rim=0.6, seed_off=606)
    # 五重の塔
    tx, tz = -6, -6
    for lv in range(5):
        y0 = lv * 5; hw = 3 - (lv >= 2) - (lv >= 4)
        box(tx - hw, y0 + 1, tz - hw, tx + hw, y0 + 4, tz + hw, 'minecraft:dark_oak_planks')
        for (dx, dz) in ((-hw, -hw), (hw, -hw), (-hw, hw), (hw, hw)): box(tx + dx, y0 + 1, tz + dz, tx + dx, y0 + 4, tz + dz, 'minecraft:stripped_mangrove_log')
        box(tx - hw + 1, y0 + 2, tz - hw, tx + hw - 1, y0 + 3, tz - hw, 'minecraft:white_concrete') if hw > 1 else None
        for x in range(tx - hw - 2, tx + hw + 3):
            for z in range(tz - hw - 2, tz + hw + 3):
                if max(abs(x - tx), abs(z - tz)) >= hw + 1: put(x, y0 + 5, z, 'minecraft:deepslate_tile_slab[type=bottom]')
                else: put(x, y0 + 5, z, 'minecraft:deepslate_tiles')
            for (cx2, cz2) in ((tx - hw - 2, tz - hw - 2), (tx + hw + 2, tz - hw - 2), (tx - hw - 2, tz + hw + 2), (tx + hw + 2, tz + hw + 2)): put(cx2, y0 + 6, cz2, 'minecraft:deepslate_tile_slab[type=bottom]')
    clear(tx, 1, tz + 3, tx, 2, tz + 3); clear(tx - 2, 1, tz - 2, tx + 2, 4, tz + 2)
    box(tx, 26, tz, tx, 30, tz, 'minecraft:chain') if False else box(tx, 26, tz, tx, 29, tz, 'minecraft:gold_block')
    chest(tx, 1, tz, rich=True, face='south')
    # 鳥居（赤）と参道・石灯籠
    for sgn in (-1, 1): box(sgn * 3 + 6, 1, 10, sgn * 3 + 6, 6, 10, 'minecraft:red_concrete')
    box(2, 6, 10, 10, 6, 10, 'minecraft:red_concrete'); box(1, 7, 10, 11, 7, 10, 'minecraft:black_concrete'); box(3, 4, 10, 9, 4, 10, 'minecraft:red_concrete')
    for z in range(-1, 18): put(6, 0, z, 'minecraft:gravel') if gy(6, z) == 0 else None
    for (lx, lz) in ((4, 4), (8, 4), (4, 14), (8, 14)):
        put(lx, 1, lz, 'minecraft:stone_brick_wall'); put(lx, 2, lz, 'minecraft:lantern'); put(lx, 3, lz, 'minecraft:stone_brick_slab[type=bottom]')
    # 茶屋（縁側）と池・飛び石・竹
    hx, hz = 8, -10
    box(hx - 3, 0, hz - 3, hx + 3, 0, hz + 3, 'minecraft:spruce_planks'); hollow(hx - 3, 1, hz - 3, hx + 3, 3, hz + 3, 'minecraft:birch_planks')
    for (dx, dz) in ((-3, -3), (3, -3), (-3, 3), (3, 3)): box(hx + dx, 1, hz + dz, hx + dx, 3, hz + dz, 'minecraft:stripped_spruce_log')
    gable(hx - 3, hz - 3, 3, 7, 7, 'minecraft:deepslate_tile_stairs', 'minecraft:deepslate_tiles', 'x', 'minecraft:birch_planks')
    clear(hx, 1, hz + 3, hx, 2, hz + 3); chest(hx - 2, 1, hz - 2, face='south')
    for x in range(-14, -6):
        for z in range(4, 12):
            if math.hypot(x + 10, z - 8) < 3.4 and gy(x, z) is not None: put(x, gy(x, z), z, 'minecraft:water'); cur.surf[(x, z)] = gy(x, z)
    for (x, z) in ((-12, 7), (-10, 9), (-8, 8)): put(x, gy(x, z) or 0, z, 'minecraft:stone_bricks')
    for _ in range(14):
        s = spot(rr, 0, 0, 12, r * 0.95, need_top='minecraft:grass_block')
        if not s: continue
        if rr.random() < 0.65: tree_cherry(s[0], s[2], s[1], 4 + int(rr.random() * 2))
        else: box(s[0], s[1] + 1, s[2], s[0], s[1] + 4 + int(rr.random() * 3), s[2], 'minecraft:bamboo')
    for (x, z), g in list(cur.surf.items()):
        if getb(x, g, z) == 'minecraft:grass_block' and free(x, g + 1, z) and rr.random() < 0.06: put(x, g + 1, z, 'minecraft:pink_petals[flower_amount=4,facing=north]')
    fin(rr, r)

@isle('ship', '飛行船の島', 19)
def b_ship(rr, r):
    island(0, 0, 14, 22, amp=0, rim=0.6, seed_off=707)
    for x in range(-14, 15):
        for z in range(-14, 15):
            if gy(x, z) is not None and math.hypot(x, z) < 6: put(x, 0, z, 'minecraft:spruce_planks')
    # 停泊中の大きな飛行船（甲板 y=0、長さ40、幅11）。船首は +x
    L2, W2 = 20, 5
    for x in range(-L2, L2 + 1):
        t = x / L2
        hw = W2 if abs(t) < 0.6 else max(1, round(W2 * (1 - (abs(t) - 0.6) / 0.45)))
        for z in range(-hw, hw + 1):
            put(x, 0, z, 'minecraft:spruce_planks')
            depth = max(1, round(5 * (1 - (z / (hw + 0.5)) ** 2) * (1 - max(0, abs(t) - 0.5))))
            for y in range(-depth, 0): put(x, y, z, 'minecraft:dark_oak_planks' if y > -depth else 'minecraft:spruce_planks')
            if abs(z) == hw: put(x, 1, z, 'minecraft:dark_oak_fence'); put(x, -1, z, 'minecraft:stripped_dark_oak_log[axis=x]')
    box(L2 + 1, 1, 0, L2 + 6, 1, 0, 'minecraft:spruce_fence'); put(L2 + 1, 0, 0, 'minecraft:dark_oak_planks')
    # 船室（2階建て・金の飾り）と舵
    hollow(-L2 + 2, 1, -3, -L2 + 9, 5, 3, 'minecraft:dark_oak_planks'); box(-L2 + 2, 6, -4, -L2 + 9, 6, 4, 'minecraft:spruce_slab[type=bottom]')
    for z in (-3, 3):
        for x in range(-L2 + 3, -L2 + 9, 2): put(x, 3, z, 'minecraft:glass_pane')
    clear(-L2 + 9, 1, 0, -L2 + 9, 2, 0); hollow(-L2 + 2, 7, -2, -L2 + 6, 9, 2, 'minecraft:dark_oak_planks'); box(-L2 + 2, 10, -2, -L2 + 6, 10, 2, 'minecraft:spruce_slab[type=bottom]')
    box(-L2 + 8, 1, -2, -L2 + 8, 6, -2, 'minecraft:ladder[facing=east]'); clear(-L2 + 6, 7, 0, -L2 + 6, 8, 0)
    box(-L2 + 2, 5, -4, -L2 + 9, 5, -4, 'minecraft:gold_block') if False else None
    chest(-L2 + 4, 1, -2, face='south'); chest(-L2 + 4, 7, 1, rich=True, face='north')
    put(-L2 + 10, 1, 0, 'minecraft:dark_oak_fence'); put(-L2 + 10, 2, 0, 'minecraft:spruce_trapdoor[facing=east,half=top,open=false]')
    # マスト3本と帆（羊毛）・旗
    for (mx, mh) in ((-4, 16), (6, 18), (14, 12)):
        box(mx, 1, 0, mx, mh, 0, 'minecraft:spruce_log')
        for y in range(mh - 10, mh - 2):
            hw = 4 - abs(y - (mh - 6)) // 3
            for z in range(-hw, hw + 1): put(mx + 1, y, z, 'minecraft:white_wool')
        box(mx, mh - 10, -5, mx, mh - 10, 5, 'minecraft:stripped_spruce_log[axis=z]')
        put(mx, mh + 1, 0, 'minecraft:spruce_fence'); put(mx + 1, mh + 1, 0, 'minecraft:red_wool'); put(mx + 2, mh + 1, 0, 'minecraft:red_wool')
    chest(2, 1, -3, face='south'); chest(10, 1, 3, face='north'); chest(-8, 1, 3)
    # 船を浮かべる気嚢（飾り、当たり判定なし）
    bd(0, 22, 0, 'minecraft:white_wool', 9.0, 8.0, 34.0, yaw=90.0); bd(0, 22, 0, 'minecraft:red_wool', 9.4, 1.4, 34.4, oy=3.0, yaw=90.0)
    for x in (-14, 0, 14): bd(x, 1, 0, 'minecraft:oak_fence', 0.15, 21.0, 0.15)
    fin(rr, r, want_chests=7, spawns=4)

@isle('balloon', '気球の島', 18)
def b_balloon(rr, r):
    # 丸い甲板（桜の植え込み）、下に吊りかご（はしご）、上に大きな気球（飾り）
    R_ = 16
    for x in range(-R_ - 1, R_ + 2):
        for z in range(-R_ - 1, R_ + 2):
            d = math.hypot(x, z)
            if d <= R_ + 0.4:
                put(x, 0, z, 'minecraft:spruce_planks' if (x + z) % 7 else 'minecraft:stripped_cherry_wood')
                put(x, -1, z, 'minecraft:dark_oak_planks'); cur.surf[(x, z)] = 0
                if d > R_ - 3: put(x, -2, z, 'minecraft:mangrove_planks')
                if d > R_ - 1: put(x, -3, z, 'minecraft:stripped_mangrove_log')
            if R_ - 0.6 <= d <= R_ + 0.4: put(x, 1, z, 'minecraft:mangrove_fence')
    for k in range(8):
        a = k * math.pi / 4; x, z = round(math.cos(a) * (R_ - 1)), round(math.sin(a) * (R_ - 1))
        box(x, 1, z, x, 2, z, 'minecraft:stripped_mangrove_log'); put(x, 3, z, 'minecraft:lantern')
    # 中央の楼閣（真紅・桜色）
    hollow(-5, 1, -5, 5, 5, 5, 'minecraft:mangrove_planks'); box(-6, 6, -6, 6, 6, 6, 'minecraft:mangrove_slab[type=bottom]')
    for (dx, dz) in ((-5, -5), (5, -5), (-5, 5), (5, 5)): box(dx, 1, dz, dx, 6, dz, 'minecraft:stripped_mangrove_log')
    for i in (-3, -1, 1, 3):
        for (x, z) in ((i, -5), (i, 5), (-5, i), (5, i)): put(x, 3, z, 'minecraft:pink_stained_glass_pane')
    for (dx, dz) in ((1, 0), (-1, 0), (0, 1), (0, -1)): clear(dx * 5, 1, dz * 5, dx * 5, 2, dz * 5)
    box(-4, 7, -4, 4, 7, 4, 'minecraft:mangrove_planks'); box(-3, 8, -3, 3, 8, 3, 'minecraft:cherry_planks'); put(0, 9, 0, 'minecraft:gold_block')
    chest(-3, 1, -3, rich=True, face='south'); chest(3, 1, 3, face='north')
    for (tx, tz) in ((-10, -8), (10, 8), (-9, 10), (10, -9)): tree_cherry(tx, tz, 0, 4)
    # 吊りかご（下の小さな甲板）
    for x in range(-5, 6):
        for z in range(-5, 6):
            d = math.hypot(x, z)
            if d <= 5.4: put(x, -12, z, 'minecraft:spruce_planks'); put(x, -13, z, 'minecraft:dark_oak_planks') if d > 3 else None
            if 4.6 <= d <= 5.4: put(x, -11, z, 'minecraft:spruce_fence')
    for y in range(-11, 0): put(0, y, 7, 'minecraft:ladder[facing=south]') if False else None
    box(6, -11, 0, 6, -1, 0, 'minecraft:ladder[facing=east]'); clear(6, 0, 0, 6, 0, 0); put(6, -12, 0, 'minecraft:spruce_planks')
    for (x, z) in ((-4, 0), (4, 0), (0, -4), (0, 4)): box(x, -11, z, x, -2, z, 'minecraft:dark_oak_fence')
    chest(-2, -11, 2, face='north')
    # 気球（飾り）と綱
    bd(0, 14, 0, 'minecraft:pink_wool', 22.0, 14.0, 22.0); bd(0, 14, 0, 'minecraft:white_wool', 24.0, 6.0, 16.0, oy=4.0); bd(0, 14, 0, 'minecraft:white_wool', 16.0, 6.0, 24.0, oy=4.0)
    bd(0, 14, 0, 'minecraft:magenta_wool', 14.0, 3.0, 14.0, oy=14.0); bd(0, 14, 0, 'minecraft:mangrove_planks', 18.0, 1.0, 18.0, oy=-1.0)
    for (x, z) in ((-8, -8), (8, -8), (-8, 8), (8, 8)): bd(x, 1, z, 'minecraft:oak_fence', 0.15, 13.0, 0.15)
    fin(rr, R_, want_chests=6, spawns=4, ores=2, host='minecraft:spruce_planks')

@isle('temple', '天空神殿の島', 22)
def b_temple(rr, r):
    M = dict(top='minecraft:moss_block', sub='minecraft:calcite', rock='minecraft:calcite', rock2='minecraft:diorite', under='minecraft:calcite')
    island(0, 0, r, 30, amp=4, mats=M, rim=0.62, seed_off=808)
    # 島の縁から垂れる苔（下へ）
    for (x, z), g in list(cur.surf.items()):
        d = math.hypot(x, z) / r
        if d > 0.8 and rr.random() < 0.18:
            ln = 2 + int(rr.random() * 6)
            for y in range(-3 - ln, -2): put(x, y, z, 'minecraft:azalea_leaves[persistent=true]') if free(x, y, z) else None
    # 神殿（石英の列柱・破風・階段）
    box(-9, 0, -7, 9, 0, 7, 'minecraft:smooth_quartz'); box(-10, 0, -8, 10, 0, 8, 'minecraft:quartz_bricks') if False else None
    for x in range(-11, 12):
        for z in range(-9, 10):
            if max(abs(x) - 9, abs(z) - 7) in (1, 2): put(x, 0, z, 'minecraft:quartz_stairs[facing=north]') if False else None
    box(-9, 1, -7, 9, 1, 7, 'minecraft:quartz_slab[type=bottom]')
    for x in range(-8, 9, 4):
        for z in (-6, 6): box(x, 1, z, x, 8, z, 'minecraft:quartz_pillar')
    for z in (-2, 2):
        for x in (-8, 8): box(x, 1, z, x, 8, z, 'minecraft:quartz_pillar')
    box(-9, 9, -7, 9, 9, 7, 'minecraft:chiseled_quartz_block'); box(-9, 10, -7, 9, 10, 7, 'minecraft:smooth_quartz')
    gable(-9, -7, 10, 19, 15, 'minecraft:quartz_stairs', 'minecraft:quartz_block', 'x', None)
    hollow(-5, 1, -3, 5, 8, 3, 'minecraft:quartz_bricks'); clear(-1, 1, 3, 1, 4, 3); clear(-1, 1, -3, 1, 4, -3)
    put(0, 1, 0, 'minecraft:gold_block'); chest(0, 2, 0, rich=True, face='south')
    for (x, z) in ((-4, -2), (4, 2)): put(x, 1, z, 'minecraft:lantern')
    # 桜と噴水
    box(-1, 0, 11, 1, 0, 13, 'minecraft:water'); hollow(-2, 1, 10, 2, 1, 14, 'minecraft:quartz_slab[type=bottom]')
    for _ in range(9):
        s = spot(rr, 0, 0, 11, r * 0.92)
        if s: tree_cherry(s[0], s[2], s[1], 4 + int(rr.random() * 2))
    for (x, z), g in list(cur.surf.items()):
        if getb(x, g, z) == 'minecraft:moss_block' and free(x, g + 1, z) and rr.random() < 0.1: put(x, g + 1, z, 'minecraft:moss_carpet')
    fin(rr, r, host='minecraft:calcite')

@isle('resort', 'リゾートの島', 23)
def b_resort(rr, r):
    island(0, 0, r, 26, amp=0, rim=0.62, seed_off=909)
    # 白い砂浜とプール、ウォータースライダー風の赤い滑り台、休憩小屋、展望塔
    for x in range(-r, r + 1):
        for z in range(-r, r + 1):
            if gy(x, z) is None: continue
            if math.hypot(x - 3, z - 2) < 12: put(x, 0, z, 'minecraft:white_concrete_powder' if math.hypot(x - 3, z - 2) > 8 else 'minecraft:smooth_quartz')
    for x in range(-2, 9):
        for z in range(-3, 7):
            put(x, 0, z, 'minecraft:water'); put(x, -1, z, 'minecraft:light_blue_concrete')
            if x in (-2, 8) or z in (-3, 6): put(x, 0, z, 'minecraft:smooth_quartz')
    hollow(-2, 0, -3, 8, 0, 6, 'minecraft:smooth_quartz')
    # 滑り台（赤い螺旋の飾り。ブロックで低く）
    for i in range(18):
        a = i * 0.45; x, z = round(-8 + math.cos(a) * 3), round(-6 + math.sin(a) * 3); y = 7 - i * 7 // 18
        put(x, y, z, 'minecraft:red_concrete')
    box(-8, 1, -6, -8, 7, -6, 'minecraft:white_concrete'); box(-8, 1, -7, -8, 7, -7, 'minecraft:ladder[facing=north]')
    # 休憩小屋（八角の屋根）
    for (px_, pz_) in ((12, 8), (-6, 10)):
        for (dx, dz) in ((-2, -2), (2, -2), (-2, 2), (2, 2)): box(px_ + dx, 1, pz_ + dz, px_ + dx, 3, pz_ + dz, 'minecraft:stripped_spruce_log')
        for k in range(4):
            for x in range(px_ - 4 + k, px_ + 5 - k):
                for z in range(pz_ - 4 + k, pz_ + 5 - k):
                    if abs(x - px_) + abs(z - pz_) <= 6 - k: put(x, 4 + k, z, 'minecraft:spruce_planks' if k % 2 else 'minecraft:stripped_spruce_wood')
        chest(px_, 1, pz_)
        for (dx, dz) in ((-1, 3), (1, 3)): put(px_ + dx, 1, pz_ + dz, 'minecraft:white_bed[facing=north,part=foot]') if False else None
    # 展望塔
    round_tower(-12, -8, 0, 12, 2, wall='minecraft:bricks', band='minecraft:spruce_planks', top='crenel', door=((1, 0),), chest_top=True)
    for _ in range(10):
        s = spot(rr, 0, 0, 13, r * 0.95)
        if s: tree_palm(s[0], s[2], s[1], 6 + int(rr.random() * 2))
    for (x, z) in ((10, -6), (12, -4), (14, -6)):
        put(x, 1, z, 'minecraft:white_carpet'); put(x, 1, z + 1, 'minecraft:white_carpet')
    fin(rr, r)

assert len(ISLES) == 10, len(ISLES)

# ======================================================================== 書き出し：中央（タイル）
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
    nx, nz_, ny = arr.shape; rects_y = {}; lines = []
    for y in range(ny):
        layer = arr[:, :, y]
        if not layer.any(): continue
        rows = []
        for z in range(nz_):
            runs = []; x = 0
            while x < nx:
                v = layer[x, z]
                if v == 0: x += 1; continue
                x2_ = x
                while x2_ + 1 < nx and layer[x2_ + 1, z] == v: x2_ += 1
                runs.append((x, x2_, int(v))); x = x2_ + 1
            rows.append(runs)
        curr = {}
        for z in range(nz_ + 1):
            now = set(rows[z]) if z < nz_ else set()
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
for n in range(100):
    r = rects[n]; x1, z1, x2, z2 = r
    sub = base.g[x1 + OFF:x2 + OFF + 1, z1 + OFF:z2 + OFF + 1, :]
    lines = ['scoreboard players set #stage oa.map2 1']
    for (ya, yb) in ((-40, -14), (-13, 13), (14, 40)): lines.append(f"fill ~{x1} ~{ya} ~{z1} ~{x2} ~{yb} ~{z2} minecraft:air")
    lines += fills(sub, x1, z1)
    open(f"{OUT}/place/{n}.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(lines) + '\n')
    box_ = f"dx={x2 - x1},dy={NY - 1},dz={z2 - z1}"
    A = [f"execute if score #mode oa.map2 matches 0 run function oa:maps/{KEY}/tiles/place/{n}",
         "execute if score #state oa.map2 matches 2 run return 0",
         f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:marker,tag=br.chest,{box_}]",
         f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:marker,tag=br.ore,{box_}]",
         f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:marker,tag=oa.gim,{box_}]",
         f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:block_display,tag=oa.mdeco,{box_}]",
         f"execute if score #mode oa.map2 matches 0 positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:block_display,tag=oa.isle,{box_}]",
         "scoreboard players set #stage oa.map2 2", "scoreboard players set #localc oa.map2 0", "scoreboard players set #localo oa.map2 0"]
    cs = [p for p in base.chests if inrect(r, p[0], p[2])]; rs_ = [p for p in base.riches if inrect(r, p[0], p[2])]
    os_ = [o for o in base.ores if inrect(r, o[0], o[2])]
    A += [f"scoreboard players set #expectedc oa.map2 {len(cs) + len(rs_)}", f"scoreboard players set #expectedo oa.map2 {len(os_)}"]
    for (x, y, z, k) in os_: A.append(f"execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:{'coal_ore' if k == 1 else 'redstone_ore'} align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_{k}")
    for (x, y, z) in rs_: A.append(f"execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich")
    for (x, y, z) in cs: A.append(f"execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest")
    for (x, y, z) in rs_: A.append(f"execute if score #mode oa.map2 matches 0 positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site")
    for (x, y, z) in cs: A.append(f"execute if score #mode oa.map2 matches 0 positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic")
    for (x, y, z, tags) in [g_ for g_ in base.gims if inrect(r, g_[0], g_[2])]:
        A.append(f"execute positioned ~{x} ~{y} ~{z} align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:marker ~ ~ ~ {{Tags:[{','.join(json.dumps(t) for t in tags)}]}}")
    for (x, y, z, nbt, et) in [d_ for d_ in base.decos if inrect(r, d_[0], d_[2])]:
        A.append(f"execute positioned ~{x} ~{y} ~{z} align xyz positioned ~0.5 ~0 ~0.5 run summon minecraft:{et} ~ ~ ~ {{Tags:[\"oa.mdeco\"],{nbt}}}")
    A += ["execute unless score #localc oa.map2 = #expectedc oa.map2 run return run function oa:map/internal/job/failed",
          "execute unless score #localo oa.map2 = #expectedo oa.map2 run return run function oa:map/internal/job/failed",
          "scoreboard players operation #chests oa.map2 += #localc oa.map2", "scoreboard players operation #ores oa.map2 += #localo oa.map2",
          f"function oa:maps/{KEY}/tiles/release/{n}", "scoreboard players add #tile oa.map2 1",
          "execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2",
          "execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish",
          "schedule function oa:map/internal/job/next 1t replace"]
    open(f"{OUT}/apply/{n}.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(A) + '\n')

# ======================================================================== 書き出し：島のテンプレート（NBT）
def nbt_str(s):
    b = s.encode('utf-8'); return struct.pack('>H', len(b)) + b
def tag_named(t, name, payload): return bytes([t]) + nbt_str(name) + payload
def compound(items):   # items: list of (type, name, payload)
    return b''.join(tag_named(t, n, p) for t, n, p in items) + b'\x00'
def list_payload(elem_type, payloads): return bytes([elem_type]) + struct.pack('>i', len(payloads)) + b''.join(payloads)
def i32(v): return struct.pack('>i', v)
def parse_state(b):
    m = re.match(r'([a-z0-9_:]+)(?:\[(.*)\])?$', b)
    name, props = m.group(1), m.group(2)
    pr = dict(kv.split('=') for kv in props.split(',')) if props else {}
    return name, pr
ISLE_DIR = f"{ROOT}/data/oa/structure/sky"
os.makedirs(ISLE_DIR, exist_ok=True)
IS = 30   # テンプレートの半分の幅（61）
ISLE_DATA = {}
isle_canvases = {}
for ti, (key, name, r, fn) in enumerate(ISLES):
    cv = Canvas(-IS, -IS, IS, IS, isle=True)
    cur = cv
    fn(np.random.default_rng(SEED * 7 + ti), r)
    # 島の上 y=1〜4 の空いた所は空気を書く（橋の手すりを消す）
    for (x, z), g in cv.surf.items():
        for y in range(max(1, g + 1), 5):
            if cv.g[x + IS, z + IS, y - Y0] == 0: cv.g[x + IS, z + IS, y - Y0] = EXPLICIT_AIR
    # NBT
    palette = []; pindex = {}; blocks = []
    xs, zs, ys = np.nonzero(cv.g)
    for x, z, y in zip(xs, zs, ys):
        b = pal[cv.g[x, z, y]]
        if b == 'minecraft:cave_air': b = 'minecraft:air'
        if b not in pindex:
            pindex[b] = len(palette); palette.append(b)
        blocks.append(compound([(9, 'pos', list_payload(3, [i32(int(x)), i32(int(y)), i32(int(z))])), (3, 'state', i32(pindex[b]))]))
    pal_payloads = []
    for b in palette:
        nm, pr = parse_state(b)
        items = [(8, 'Name', nbt_str(nm))]
        if pr: items.append((10, 'Properties', compound([(8, k, nbt_str(v)) for k, v in pr.items()])))
        pal_payloads.append(compound(items))
    root = compound([(3, 'DataVersion', i32(DATA_VERSION)),
                     (9, 'size', list_payload(3, [i32(2 * IS + 1), i32(NY), i32(2 * IS + 1)])),
                     (9, 'palette', list_payload(10, pal_payloads)),
                     (9, 'blocks', list_payload(10, blocks)),
                     (9, 'entities', list_payload(0, []))])
    data = tag_named(10, '', root[:-0] if False else root)
    with gzip.open(f"{ISLE_DIR}/{key}.nbt", 'wb') as f: f.write(data)
    ISLE_DATA[key] = dict(name=name, chests=list(cv.chests), riches=list(cv.riches), ores=list(cv.ores), spawns=list(cv.spawns), decos=list(cv.decos))
    isle_canvases[key] = cv
    print(f'isle {key}: blocks {len(blocks)} chests {len(cv.chests) + len(cv.riches)} ores {len(cv.ores)} spawns {len(cv.spawns)} decos {len(cv.decos)}')
    assert len(cv.chests) + len(cv.riches) >= 5, key
    assert len(cv.spawns) >= 3, key
cur = base

# ======================================================================== 書き出し：島を置く関数
ROT = ['none', 'clockwise_90', '180', 'counterclockwise_90']   # rot_off の 1＝(-z,x)＝clockwise_90（テスト用サーバーで中心の金ブロックの位置を測って確認）
def rot_off(ox, oz, r):
    """テンプレート内のセル (ox,oz)（0..60）を回転した位置（place template の原点からの相対）。"""
    if r == 0: return ox, oz
    if r == 1: return -oz, ox
    if r == 2: return -ox, -oz
    return oz, -ox
def rot_vec(lx, lz, r):
    """島の中心から見た相対ベクトル（小数可）を回す。"""
    if r == 0: return lx, lz
    if r == 1: return -lz, lx
    if r == 2: return -lx, -lz
    return lz, -lx
ID = f"{MD}/isles"
for d in ('p', 'bridge'): os.makedirs(f"{ID}/{d}", exist_ok=True)
for old in glob.glob(f"{ID}/p/*.mcfunction"): os.remove(old)
def W(path, lines): open(f"{ID}/{path}.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(lines) + '\n')
YB = 80
# 橋（候補地ごと。石の橋、幅4、手すり・灯り・下のアーチ）
BR_LINES = {}
for s in range(10):
    (ax, az), (bx, bz) = bridge_points(s)
    bc = Canvas(-OFF, -OFF, OFF, OFF)
    cur = bc
    L = math.hypot(bx - ax, bz - az); n = int(L * 2) + 1
    ux, uz = (bx - ax) / L, (bz - az) / L; px, pz = -uz, ux
    deck = ['minecraft:stone_bricks', 'minecraft:spruce_planks'][s % 2]; rail = ['minecraft:stone_brick_wall', 'minecraft:spruce_fence'][s % 2]
    for i in range(n):
        t = i / (n - 1); cx_, cz_ = ax + (bx - ax) * t, az + (bz - az) * t; seg = int(t * L)
        for k in np.linspace(-1.5, 1.5, 8):
            x, z = round(cx_ + px * k), round(cz_ + pz * k); put(x, 0, z, deck); put(x, -1, z, 'minecraft:polished_andesite' if s % 2 == 0 else 'minecraft:dark_oak_planks')
        for sgn in (-1, 1):
            x, z = round(cx_ + px * sgn * 2.5), round(cz_ + pz * sgn * 2.5)
            put(x, 0, z, deck); put(x, 1, z, rail)
            if seg % 10 == 5: put(x, 2, z, 'minecraft:lantern')
        if seg % 10 in (0, 1) and 3 < seg < L - 3:
            for sgn in (-1, 1):
                x, z = round(cx_ + px * sgn * 1.5), round(cz_ + pz * sgn * 1.5)
                for yy in range(-4, -1): put(x, yy, z, 'minecraft:polished_andesite')
    lines = [HEAD + f"。候補地 {s} の中央への橋（ディメンション oa:br_sky で実行）"]
    xs_ = np.nonzero(bc.g.any(axis=(1, 2)))[0]; zs_ = np.nonzero(bc.g.any(axis=(0, 2)))[0]
    sub = bc.g[xs_[0]:xs_[-1] + 1, zs_[0]:zs_[-1] + 1, :]
    for ln in fills(sub, xs_[0] - OFF, zs_[0] - OFF):
        lines.append(re.sub(r'~(-?\d+) ~(-?\d+) ~(-?\d+)', lambda m: f"{m.group(1)} {int(m.group(2)) + YB} {m.group(3)}", ln))
    W(f"bridge/s{s}", lines)
    BR_LINES[s] = (xs_[0] - OFF, zs_[0] - OFF, xs_[-1] - OFF, zs_[-1] - OFF)
cur = base
# 候補地ごとの読み込み範囲（島＋橋）
FL = {}
for s in range(10):
    sx, sz = SITES[s]; b = BR_LINES[s]
    # place template は、回したときに「読み込み済みか」を確かめる範囲が実際に置く範囲とずれる（テスト用サーバーで確認）。
    # 原点（中心±30）から±60 のどちらにも届くよう、中心±90 を読み込む
    x1, z1 = min(sx - 90, b[0]), min(sz - 90, b[1]); x2, z2 = max(sx + 90, b[2]), max(sz + 90, b[3])
    assert ((x2 >> 4) - (x1 >> 4) + 1) * ((z2 >> 4) - (z1 >> 4) + 1) <= 256
    FL[s] = (x1, z1, x2, z2)
    W(f"load/s{s}" if False else f"load_s{s}", [HEAD, f"execute in {DIM} run forceload add {x1} {z1} {x2} {z2}"])
    W(f"unload_s{s}", [HEAD, f"execute in {DIM} run forceload remove {x1} {z1} {x2} {z2}"])
    RL = [HEAD + "。範囲のチャンクがすべて読み込まれていれば 1（place template は範囲の全チャンクが要る）"]
    for cx_ in range(x1 >> 4, (x2 >> 4) + 1):
        for cz_ in range(z1 >> 4, (z2 >> 4) + 1):
            RL.append(f"execute in {DIM} unless loaded {cx_ * 16 + 8} {YB} {cz_ * 16 + 8} run return 0")
    W(f"ready_s{s}", RL + ["return 1"])
# （候補地・種類・向き）ごとに置く・登録する
for s in range(10):
    sx, sz = SITES[s]
    disp = [HEAD + f"。候補地 {s}：選ばれた種類（#sk{s}）と向き（#sr{s}）の関数を呼ぶ"]
    for ti, (key, name, r, fn) in enumerate(ISLES):
        D = ISLE_DATA[key]
        for rt in range(4):
            cxr, czr = rot_off(IS, IS, rt)
            ox, oz = sx - cxr, sz - czr    # place template の原点
            L = [HEAD + f"。候補地 {s}（{sx},{sz}）に「{name}」を向き {ROT[rt]} で置き、登録する（oa:br_sky で）",
                 f"execute unless score #mode oa.map2 matches 1 in {DIM} run function oa:maps/{KEY}/isles/bridge/s{s}",
                 f"execute unless score #mode oa.map2 matches 1 in {DIM} store success score #isle_placed oa.map2 run place template oa:sky/{key} {ox} {YB + Y0} {oz} {ROT[rt]}",
                 f"execute unless score #mode oa.map2 matches 1 if score #isle_placed oa.map2 matches 0 run tellraw @a[tag=br.admin] {{text:\"[天空都市] 「{name}」を置けませんでした（読み込み）\",color:\"red\"}}"]
            def W2(lx, lz):
                a, b = rot_off(lx + IS, lz + IS, rt); return ox + a, oz + b
            for (x, y, z, k) in D['ores']:
                X, Z = W2(x, z); L.append(f"execute in {DIM} positioned {X} {y + YB} {Z} if block ~ ~ ~ minecraft:{'coal_ore' if k == 1 else 'redstone_ore'} align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_{k}")
            for (x, y, z) in D['riches']:
                X, Z = W2(x, z); L.append(f"execute in {DIM} positioned {X} {y + YB} {Z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich")
                L.append(f"execute unless score #mode oa.map2 matches 1 in {DIM} positioned {X} {y + YB} {Z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site")
            for (x, y, z) in D['chests']:
                X, Z = W2(x, z); L.append(f"execute in {DIM} positioned {X} {y + YB} {Z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest")
                L.append(f"execute unless score #mode oa.map2 matches 1 in {DIM} positioned {X} {y + YB} {Z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic")
            pts = []
            for (x, y, z) in D['spawns']:
                X, Z = W2(x, z); pts.append(f"{{x:{X}.5d,y:{y + YB}.0d,z:{Z}.5d}}")
            L.append(f"data modify storage oa:spawn_points points append value " + "[" + ",".join(pts) + "][0]") if False else None
            for pt in pts: L.append(f"data modify storage oa:spawn_points points append value {pt}")
            for (x, y, z, nbt, et) in D['decos']:
                X, Z = W2(x, z)
                yaw_add = [0.0, 90.0, 180.0, 270.0][rt]
                nbt2 = re.sub(r'Rotation:\[(-?[\d.]+)f', lambda m: f"Rotation:[{(float(m.group(1)) + yaw_add) % 360:.1f}f", nbt)
                L.append(f"execute unless score #mode oa.map2 matches 1 in {DIM} run summon minecraft:{et} {X}.5 {y + YB} {Z}.5 {{Tags:[\"oa.isle\"],{nbt2}}}")
            L.append(f'data modify storage oa:maps layout.{KEY} append value {{x:{sx},z:{sz},name:"{name}"}}')
            L.append(f'data modify storage oa:maps sky_region.s{s} set value "{name}のあたり"')
            L.append(f'data modify storage oa:maps sky_isles append value "{name}"')
            W(f"p/s{s}t{ti}r{rt}", L)
            disp.append(f"execute if score #sk{s} oa.map2 matches {ti} if score #sr{s} oa.map2 matches {rt} run function oa:maps/{KEY}/isles/p/s{s}t{ti}r{rt}")
    W(f"do_s{s}", disp)
# 抽選
R = [HEAD + "。外周の島：3〜6個を、10か所の候補地から場所・種類・向きを抽選する（作成・再生成のときだけ。map/internal/job/begin から）",
     "execute unless score #mode oa.map2 matches 0 run return 0"]
R += [f"scoreboard players set #sk{s} oa.map2 -1" for s in range(10)] + [f"scoreboard players set #tu{t} oa.map2 0" for t in range(10)]
R += ["execute store result score #in oa.map2 run random value 3..6", "scoreboard players set #ii oa.map2 0", f"function oa:maps/{KEY}/isles/roll_one"]
open(f"{MD}/roll.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(R) + '\n')
W("roll_one", [HEAD, "execute if score #ii oa.map2 >= #in oa.map2 run return 0",
               f"function oa:maps/{KEY}/isles/pick_site", f"function oa:maps/{KEY}/isles/pick_type"]
  + [f"execute if score #ps oa.map2 matches {s} run scoreboard players operation #sk{s} oa.map2 = #pt oa.map2" for s in range(10)]
  + [f"execute if score #ps oa.map2 matches {s} store result score #sr{s} oa.map2 run random value 0..3" for s in range(10)]
  + [f"execute if score #pt oa.map2 matches {t} run scoreboard players set #tu{t} oa.map2 1" for t in range(10)]
  + ["scoreboard players add #ii oa.map2 1", f"function oa:maps/{KEY}/isles/roll_one"])
W("pick_site", [HEAD, "execute store result score #ps oa.map2 run random value 0..9"]
  + [f"execute if score #ps oa.map2 matches {s} unless score #sk{s} oa.map2 matches -1 run return run function oa:maps/{KEY}/isles/pick_site" for s in range(10)])
W("pick_type", [HEAD, "execute store result score #pt oa.map2 run random value 0..9"]
  + [f"execute if score #pt oa.map2 matches {t} if score #tu{t} oa.map2 matches 1 run return run function oa:maps/{KEY}/isles/pick_type" for t in range(10)])
# 置く順番（区画のあと）
W("begin", [HEAD + "。区画（中央）のあとに呼ばれる。島を1つずつ置く（終わるまで生成中のまま）",
            "data modify storage oa_map2:job working set value 1b",
            "data modify storage oa:maps sky_isles set value []",
            "data remove storage oa:maps sky_region",
            "scoreboard players set #isle oa.map2 0", "scoreboard players set #isle_wait oa.map2 0",
            'tellraw @a[tag=br.admin] {text:"[天空都市] まわりの島を置いています…",color:"gold"}',
            f"function oa:maps/{KEY}/isles/next"])
NX = [HEAD + "。次の候補地へ（選ばれていなければ飛ばす）",
      f"execute if score #isle oa.map2 matches 10.. run return run function oa:maps/{KEY}/isles/finish"]
for s in range(10):
    NX.append(f"execute if score #isle oa.map2 matches {s} if score #sk{s} oa.map2 matches -1 run scoreboard players add #isle oa.map2 1")
NX.append(f"execute if score #isle oa.map2 matches 10.. run return run function oa:maps/{KEY}/isles/finish")
for s in range(10):
    NX.append(f"execute if score #isle oa.map2 matches {s} run function oa:maps/{KEY}/isles/load_s{s}")
NX += ["scoreboard players set #isle_wait oa.map2 0", f"schedule function oa:maps/{KEY}/isles/wait 5t replace"]
W("next", NX)
WT = [HEAD + "。読み込みを待つ（最大30秒）", "scoreboard players add #isle_wait oa.map2 1", "scoreboard players set #isle_ok oa.map2 0"]
for s in range(10):
    WT.append(f"execute if score #isle oa.map2 matches {s} store result score #isle_ok oa.map2 run function oa:maps/{KEY}/isles/ready_s{s}")
WT += [f"execute if score #isle_ok oa.map2 matches 0 if score #isle_wait oa.map2 matches ..120 run return run schedule function oa:maps/{KEY}/isles/wait 5t replace",
       f"execute if score #isle_ok oa.map2 matches 0 run tellraw @a[tag=br.admin] {{text:\"[天空都市] 島の場所が読み込めなかったので飛ばしました\",color:\"red\"}}",
       f"execute if score #isle_ok oa.map2 matches 1 run function oa:maps/{KEY}/isles/place"]
for s in range(10):
    WT.append(f"execute if score #isle oa.map2 matches {s} run function oa:maps/{KEY}/isles/unload_s{s}")
WT += ["scoreboard players add #isle oa.map2 1", f"schedule function oa:maps/{KEY}/isles/next 2t replace"]
W("wait", WT)
W("place", [HEAD + "。今の候補地（#isle）の島を置いて登録する", "scoreboard players set #localc oa.map2 0", "scoreboard players set #localo oa.map2 0"]
  + [f"execute if score #isle oa.map2 matches {s} run function oa:maps/{KEY}/isles/do_s{s}" for s in range(10)]
  + ["scoreboard players operation #chests oa.map2 += #localc oa.map2", "scoreboard players operation #ores oa.map2 += #localo oa.map2"])
W("finish", [HEAD + "。島を置き終えた",
             "data modify storage oa_map2:job working set value 0b",
             "execute store result score #sp_n oa.tmp run data get storage oa:spawn_points points",
             "execute store result score #isle_n oa.tmp run data get storage oa:maps sky_isles",
             'tellraw @a[tag=br.admin] [{text:"[天空都市] まわりの島 ",color:"green"},{score:{name:"#isle_n",objective:"oa.tmp"},color:"green"},{text:" 個を置きました（",color:"green"},{nbt:"sky_isles[]",storage:"oa:maps",color:"white",separator:"・"},{text:"）。チェスト ",color:"green"},{score:{name:"#chests",objective:"oa.map2"},color:"green"},{text:"個・開始地点 ",color:"green"},{score:{name:"#sp_n",objective:"oa.tmp"},color:"green"},{text:"か所。",color:"green"}]',
             "execute as @a[tag=br.admin] at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 0.6 1.2"])
# post：中央の開始地点・地点名（そのあと島）
def ptsl(lst): return ",".join(f"{{x:{x}.5d,y:{y + 80}.0d,z:{z}.5d}}" for x, y, z in lst)
PO = [HEAD + "。会場の生成完了後に呼ばれる（中央の開始地点・地点名。そのあと、まわりの島を置く）",
      f'data modify storage oa:spawn_points dim set value "{DIM}"',
      f"data modify storage oa:spawn_points points set value [{ptsl(base.spawns)}]",
      f"function oa:maps/{KEY}/layout",
      f"function oa:maps/{KEY}/isles/begin"]
open(f"{MD}/post.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(PO) + '\n')
LY = [HEAD + "。中央の地点名（島の名前は maps/sky/isles が足す）", f"data modify storage oa:maps layout.{KEY} set value []"]
for (x, z, nm) in base.places: LY.append(f'data modify storage oa:maps layout.{KEY} append value {{x:{x},z:{z},name:"{nm}"}}')
open(f"{MD}/layout.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(LY) + '\n')
# 空中補給の場所名
SR = [HEAD + "。空中補給の場所名（#rx,#rz は中心からの相対）。中央か、置かれた島のうちいちばん近い所",
      "scoreboard players set #rbest br.tmp 2147483647", f'data modify storage oa:supply region set value "{LABEL}"']
def region_lines(x, z, cond, setter):
    pre = f"execute {cond} run " if cond else ""
    c2 = f"execute {cond} if score #rdx br.tmp < #rbest br.tmp run " if cond else "execute if score #rdx br.tmp < #rbest br.tmp run "
    return [f"{pre}scoreboard players operation #rdx br.tmp = #rx br.tmp",
            f"{pre}scoreboard players " + (f"remove #rdx br.tmp {x}" if x >= 0 else f"add #rdx br.tmp {-x}"),
            f"{pre}scoreboard players operation #rdx br.tmp *= #rdx br.tmp",
            f"{pre}scoreboard players operation #rdz br.tmp = #rz br.tmp",
            f"{pre}scoreboard players " + (f"remove #rdz br.tmp {z}" if z >= 0 else f"add #rdz br.tmp {-z}"),
            f"{pre}scoreboard players operation #rdz br.tmp *= #rdz br.tmp",
            f"{pre}scoreboard players operation #rdx br.tmp += #rdz br.tmp",
            f"{c2}{setter}", f"{c2}scoreboard players operation #rbest br.tmp = #rdx br.tmp"]
for (x, z, nm) in base.places: SR += region_lines(x, z, '', f'data modify storage oa:supply region set value "{nm}のあたり"')
for s in range(10):
    SR += region_lines(SITES[s][0], SITES[s][1], f"unless score #sk{s} oa.map2 matches -1", f"data modify storage oa:supply region set from storage oa:maps sky_region.s{s}")
open(f"{MD}/supply_region.mcfunction", 'w', encoding='utf8', newline='\n').write('\n'.join(SR) + '\n')
# 旧（1.9.230〜1.9.231 のスロット方式）の関数が残っていれば、使わない
print('sites', SITES)

# ======================================================================== 確認用の画像
COLS = {'grass_block': (96, 160, 70), 'dirt': (130, 96, 60), 'stone': (128, 128, 128), 'andesite': (136, 136, 136), 'tuff': (100, 100, 95),
        'water': (60, 110, 220), 'sand': (219, 207, 163), 'sandstone': (210, 195, 140), 'snow': (245, 250, 252), 'ice': (160, 190, 250),
        'red_sand': (190, 100, 40), 'terracotta': (160, 90, 65), 'white_terracotta': (215, 185, 170), 'orange_terracotta': (190, 105, 50),
        'yellow_terracotta': (190, 140, 50), 'red_terracotta': (150, 60, 45), 'brown_terracotta': (90, 60, 40), 'light_gray_terracotta': (140, 115, 105),
        'stone_brick': (122, 121, 122), 'polished_andesite': (132, 135, 133), 'smooth_stone': (160, 160, 160), 'oak_leaves': (60, 130, 45),
        'cherry_leaves': (235, 165, 200), 'spruce_leaves': (50, 90, 60), 'jungle_leaves': (60, 150, 40), 'azalea_leaves': (90, 140, 50),
        'deepslate_tiles': (60, 60, 65), 'red_wool': (160, 40, 40), 'gold': (240, 210, 70), 'quartz': (232, 228, 220), 'calcite': (225, 225, 220),
        'moss': (90, 120, 40), 'spruce': (115, 85, 50), 'dark_oak': (66, 43, 20), 'oak': (162, 130, 78), 'mangrove': (120, 50, 45), 'cherry': (225, 175, 170),
        'wool': (230, 230, 230), 'brick': (150, 85, 70), 'concrete': (225, 230, 230), 'red_concrete': (150, 35, 35), 'glass': (200, 225, 235),
        'lantern': (240, 200, 120), 'bamboo': (110, 160, 40), 'gravel': (130, 125, 125), 'cactus': (80, 130, 40)}
def colof(b):
    n = b.split(':')[1].split('[')[0]
    if n in COLS: return COLS[n]
    for k_, v_ in sorted(COLS.items(), key=lambda kv: -len(kv[0])):
        if k_ in n: return v_
    return (150, 150, 150)
def composite(sample):
    """土台に、見本として島を置いた全体の格子（sample＝[(候補地, 種類番号, 向き)]）。"""
    G = base.g.copy()
    for s in range(10):
        pass
    for (s, ti, rt) in sample:
        key = ISLES[ti][0]; cv = isle_canvases[key]; sx, sz = SITES[s]
        (ax, az), (bx, bz) = bridge_points(s)
        cxr, czr = rot_off(IS, IS, rt); ox, oz = sx - cxr, sz - czr
        xs, zs, ys = np.nonzero(cv.g)
        for x, z, y in zip(xs, zs, ys):
            a, b = rot_off(int(x), int(z), rt)
            X, Z = ox + a + OFF, oz + b + OFF
            if 0 <= X < N and 0 <= Z < N: G[X, Z, y] = cv.g[x, z, y] if cv.g[x, z, y] != EXPLICIT_AIR else 0
    return G
SAMPLE = [(0, 0, 0), (2, 5, 1), (3, 7, 0), (5, 4, 2), (7, 6, 3), (8, 8, 0)]
if PNG or PANEL:
    from PIL import Image, ImageDraw, ImageFont
    def render_top(G, size, clouds=True):
        img = Image.new('RGB', (N, N)); px = img.load()
        has = G.any(axis=2); top = NY - 1 - np.argmax(G[:, :, ::-1] != 0, axis=2)
        CL = smooth(25, 9)
        for x in range(N):
            for z in range(N):
                if not has[x, z]:
                    t = z / N; c0 = (int(110 + 40 * t), int(165 + 30 * t), int(220 + 15 * t))
                    if clouds and CL[x, z] > 0.6: k_ = min(0.85, (CL[x, z] - 0.6) * 5); c0 = tuple(int(c * (1 - k_) + 248 * k_) for c in c0)
                    px[x, z] = c0; continue
                h = top[x, z]; c = colof(pal[G[x, z, h]])
                hx = top[x - 1, z] if x > 0 and has[x - 1, z] else h - 2; hz = top[x, z - 1] if z > 0 and has[x, z - 1] else h - 2
                sh = max(0.6, min(1.35, 1.0 + 0.08 * ((h - hx) + (h - hz)) + 0.01 * (h - 40)))
                px[x, z] = tuple(max(0, min(255, int(v * sh))) for v in c)
        return img.resize((size, size), Image.LANCZOS)
    if PNG: render_top(composite(SAMPLE), N * 2).save(PNG)
    if PANEL:
        img = render_top(base.g, 512)
        d_ = ImageDraw.Draw(img, 'RGBA')
        font = ImageFont.truetype('C:/Windows/Fonts/meiryob.ttc', 18); small = ImageFont.truetype('C:/Windows/Fonts/meiryob.ttc', 14)
        S_ = 512 / N
        for (sx, sz) in SITES:
            X, Y = (sx + OFF) * S_, (sz + OFF) * S_; rr_ = 21 * S_
            d_.ellipse([X - rr_, Y - rr_, X + rr_, Y + rr_], outline=(255, 255, 255, 150), width=2)
            d_.text((X, Y), '？', font=font, fill=(255, 255, 255, 200), anchor='mm')
        X, Y = 256, 256; w_ = d_.textlength('天空城', font=font)
        d_.rounded_rectangle([X - w_ / 2 - 7, Y - 14, X + w_ / 2 + 7, Y + 14], 6, fill=(15, 15, 28, 195)); d_.text((X, Y), '天空城', font=font, fill=(255, 225, 120), anchor='mm')
        note = 'まわりの島は会場を作るたびに3〜6個（場所・種類・向きが変わる）'
        w_ = d_.textlength(note, font=small)
        d_.rounded_rectangle([256 - w_ / 2 - 8, 486, 256 + w_ / 2 + 8, 508], 6, fill=(15, 15, 28, 210)); d_.text((256, 497), note, font=small, fill=(235, 235, 235), anchor='mm')
        img.save(PANEL)
if ISO or ISLES_OUT:
    from PIL import Image
    def iso(G, path, S2=3, crop=None):
        G = G.copy(); G[G == EXPLICIT_AIR] = 0
        xs, zs, ys = np.nonzero(G)
        lut = np.array([colof(b) for b in pal], float)
        n_ = G.shape[0]
        u = (xs - zs + n_) * S2; v = ((xs + zs) * 0.5 - (ys - 40) * 1.25) * S2 + 200
        order = np.argsort(xs + zs + ys * 0.01)
        W_, H_ = int(2 * n_ * S2 + 10), int((n_ + 120) * S2 + 400)
        img = np.zeros((H_, W_, 3)); img[:] = (130, 180, 230)
        sh = 0.75 + 0.25 * (ys / 80.0)
        for i in order:
            uu, vv = int(u[i]), int(v[i]); img[vv:vv + S2 + 1, uu:uu + S2 + 1] = lut[G[xs[i], zs[i], ys[i]]] * sh[i]
        im = Image.fromarray(np.clip(img, 0, 255).astype('uint8'))
        if crop: im = im.crop(crop)
        im.save(path)
    if ISO: iso(composite(SAMPLE), ISO)
    if ISLES_OUT:
        os.makedirs(ISLES_OUT, exist_ok=True)
        for key, name, r, fn in ISLES:
            iso(isle_canvases[key].g, f"{ISLES_OUT}/{key}.png", S2=6)
json.dump({"key": KEY, "seed": SEED, "sites": SITES, "isles": {k: {"name": v['name'], "chests": len(v['chests']) + len(v['riches']), "ores": len(v['ores']), "spawns": len(v['spawns'])} for k, v in ISLE_DATA.items()},
           "center_chests": len(base.chests) + len(base.riches), "center_spawns": len(base.spawns)},
          open(f"{ROOT}/MAP_SKY_MANIFEST.json", "w", encoding="utf8"), ensure_ascii=False, indent=1, default=int)
print('ok sky')
