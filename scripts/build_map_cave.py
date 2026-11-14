#!/usr/bin/env python3
"""OA Battle Royale 1.9.167: 洞窟会場 (oa:br_cave) の生成。トンネル網＋5つのエリア＋中央の地下神殿。
使い方: py -3 scripts/build_map_cave.py <repo root> [--png 出力PNG]
- data/oa/function/maps/cave/tiles/{preload,wait,release,apply,place}/0..99 と maps/cave/post を書き出す
- モデル全体を source/map_cave_target.npz、配置一覧を MAP_CAVE_MANIFEST.json に保存
座標は中心(0,0)基準 x,z∈[-152,152]、y∈[-40,0]（会場の原点 y=80 に置くので絶対座標は 40〜80）。
y=0 はバリア（天井の上へ抜けないように）、y=-40 は岩盤。床はおおむね y=-30（絶対50）前後。
エリア：中央=地下神殿、1=紫水晶の晶洞、2=繁茂した洞窟、3=鍾乳洞と地底湖、4=廃坑とディープダーク、5=古代都市。
明るさはやや暗め（1.9.170 で明るくした。トンネルはヒカリゴケ・ランタン、エリアは結晶・ベリー・魂のランタン・ろうそくなど）。
"""
import sys, os, re, glob, json, math
from collections import deque
import numpy as np

ROOT = sys.argv[1]
PNG = sys.argv[sys.argv.index('--png') + 1] if '--png' in sys.argv else None
OUT = f"{ROOT}/data/oa/function/maps/cave/tiles"
SRC = f"{ROOT}/data/oa/function/map/internal/tiles"
SEED = 20261115
rng = np.random.default_rng(SEED)
N = 305; OFF = 152; Y0 = -40; NY = 41; TOP = 0
NCH = 100    # 通常チェスト（1.9.169 で88→100。中央の神殿と中間の空洞に足した）
NORE = 180   # 鉱石（1.9.169 で108→180）

pal = ['minecraft:air']; pid = {'minecraft:air': 0}
def P(b):
    if b not in pid: pid[b] = len(pal); pal.append(b)
    return pid[b]
AIR = 0
STONE = P('minecraft:stone')
g = np.full((N, N, NY), STONE, np.uint16)

def inb(x, z): return -OFF <= x <= OFF and -OFF <= z <= OFF
def put(x, y, z, b):
    if inb(x, z) and Y0 <= y <= TOP: g[x + OFF, z + OFF, y - Y0] = P(b)
def get(x, y, z): return pal[g[x + OFF, z + OFF, y - Y0]] if inb(x, z) and Y0 <= y <= TOP else 'minecraft:stone'

def smooth(scale, seed):
    r = np.random.default_rng(seed); k = N // scale + 3; a = r.random((k, k))
    xs = np.linspace(0, k - 3, N); i = xs.astype(int); f = xs - i
    return (a[i][:, i] * (1 - f)[:, None] * (1 - f)[None, :] + a[i + 1][:, i] * f[:, None] * (1 - f)[None, :]
            + a[i][:, i + 1] * (1 - f)[:, None] * f[None, :] + a[i + 1][:, i + 1] * f[:, None] * f[None, :])

X, Z = np.meshgrid(np.arange(-OFF, OFF + 1), np.arange(-OFF, OFF + 1), indexing='ij')
R = np.hypot(X, Z)
nA = smooth(18, 11); nB = smooth(9, 12); nC = smooth(30, 13); nR = smooth(14, 14)

# ---------------- 岩（地の材質） ----------------
for y in range(Y0, TOP + 1):
    yi = y - Y0
    if y <= -34: g[:, :, yi] = P('minecraft:deepslate')
    else:
        t = nR + 0.03 * (y + 30)
        layer = np.full((N, N), STONE, np.uint16)
        layer[t > 0.70] = P('minecraft:tuff'); layer[t < 0.18] = P('minecraft:andesite')
        layer[(nB > 0.83)] = P('minecraft:granite')
        g[:, :, yi] = layer
g[:, :, 0] = P('minecraft:bedrock')
g[:, :, NY - 1] = P('minecraft:barrier')

# ---------------- 空間の設計（2D：開いた場所・床の高さ・天井までの高さ・エリア） ----------------
OPEN = np.zeros((N, N), bool)
FLT = np.full((N, N), -30.0)          # 床の高さの目標
HT = np.zeros((N, N), int)             # 床から天井までの空き（ブロック数）
AREA = np.full((N, N), -1, int)        # 0神殿 1晶洞 2繁茂 3鍾乳洞 4廃坑/深層 5町 6トンネル 7小部屋 8中間空洞
PRI = np.zeros((N, N), int)
AREA_NAME = {0: '地下神殿', 1: '紫水晶の晶洞', 2: '繁茂した洞窟', 3: '鍾乳洞と地底湖', 4: '廃坑とディープダーク', 5: '古代都市'}

def carve_blob(cx, cz, r, floor, hmax, hmin, area, pri, wob=0.22):
    x1, x2 = int(cx - r * 1.4) - 2, int(cx + r * 1.4) + 2
    z1, z2 = int(cz - r * 1.4) - 2, int(cz + r * 1.4) + 2
    for x in range(max(x1, -OFF + 3), min(x2, OFF - 3) + 1):
        for z in range(max(z1, -OFF + 3), min(z2, OFF - 3) + 1):
            dx, dz = x - cx, z - cz; d = math.hypot(dx, dz)
            ang = math.atan2(dz, dx)
            rr = r * (1 + wob * (math.sin(3 * ang + cx * 0.1) * 0.5 + (nA[x + OFF, z + OFF] - 0.5)))
            if d > rr: continue
            xi, zi = x + OFF, z + OFF
            q = d / rr
            h = int(round(hmin + (hmax - hmin) * (1 - q * q)))
            OPEN[xi, zi] = True
            if pri >= PRI[xi, zi]:
                PRI[xi, zi] = pri; AREA[xi, zi] = area; FLT[xi, zi] = floor
                HT[xi, zi] = max(h, HT[xi, zi] if PRI[xi, zi] == pri else 0)
            else:
                HT[xi, zi] = max(HT[xi, zi], min(h, 6))

def tunnel(p0, p1, f0, f1, hw=2.4, ht=5, pri=1, seed=0):
    (x0, z0), (x1, z1) = p0, p1
    L = math.hypot(x1 - x0, z1 - z0); nx, nz = -(z1 - z0) / L, (x1 - x0) / L
    r = np.random.default_rng(SEED + seed)
    amp = min(10.0, L * 0.12); ph1, ph2 = r.random() * 6.28, r.random() * 6.28
    steps = int(L * 2) + 1
    for s in range(steps + 1):
        t = s / steps
        off = amp * (math.sin(math.pi * t) * (0.7 * math.sin(2 * math.pi * t * 1.3 + ph1) + 0.3 * math.sin(2 * math.pi * t * 3.1 + ph2)))
        cx = x0 + (x1 - x0) * t + nx * off; cz = z0 + (z1 - z0) * t + nz * off
        w = hw + 0.8 * math.sin(t * 17 + ph2)
        fl = f0 + (f1 - f0) * t
        for x in range(int(cx - w) - 1, int(cx + w) + 2):
            for z in range(int(cz - w) - 1, int(cz + w) + 2):
                if not (-OFF + 3 <= x <= OFF - 3 and -OFF + 3 <= z <= OFF - 3): continue
                if math.hypot(x - cx, z - cz) > w: continue
                xi, zi = x + OFF, z + OFF
                OPEN[xi, zi] = True
                if pri >= PRI[xi, zi]:
                    if PRI[xi, zi] < pri or AREA[xi, zi] == -1:
                        AREA[xi, zi] = 6; FLT[xi, zi] = fl
                    PRI[xi, zi] = pri
                HT[xi, zi] = max(HT[xi, zi], ht)
    return

def pol(r, deg): return (r * math.cos(math.radians(deg)), r * math.sin(math.radians(deg)))

# エリア（角度は +x から z 方向へ）
AREAS = {1: dict(ang=18, r=96, rad=25, floor=-27, hmax=16, hmin=7),
         2: dict(ang=90, r=98, rad=26, floor=-29, hmax=14, hmin=7),
         3: dict(ang=162, r=98, rad=29, floor=-31, hmax=18, hmin=7),
         4: dict(ang=234, r=98, rad=27, floor=-34, hmax=13, hmin=6),
         5: dict(ang=306, r=98, rad=36, floor=-30, hmax=20, hmin=9)}   # 1.9.170: 古代都市を広げた（31→36）
for a, d in AREAS.items():
    d['c'] = pol(d['r'], d['ang'])

# 中央の地下神殿
carve_blob(0, 0, 25, -30, 22, 10, 0, 5, wob=0.06)
for a, d in AREAS.items():
    carve_blob(d['c'][0], d['c'][1], d['rad'], d['floor'], d['hmax'], d['hmin'], a, 4)
# 中間の空洞（補給が落ちる高さのある部屋）：放射トンネルの間、半径40付近
MIDS = []
for k in range(5):
    ang = 54 + 72 * k; c = pol(41, ang); MIDS.append(c)
    carve_blob(c[0], c[1], 10, -30 + (1 if k % 2 else -1), 12, 6, 8, 3, wob=0.2)
# 内側の環（半径62）と外側の環（半径128）のつなぎ目
IN = [pol(62, 36 * k) for k in range(10)]
OUTR = [pol(128, 36 * k + 18) for k in range(10)]
infl = [-30 + int(3 * math.sin(k * 1.7)) for k in range(10)]
outfl = [-30 + int(3 * math.sin(k * 2.3 + 1)) for k in range(10)]
sd = 1
# 放射トンネル：神殿→内環（偶数）、神殿→中間空洞
for k in range(0, 10, 2):
    tunnel((0, 0), IN[k], -30, infl[k], hw=2.8, ht=6, seed=sd); sd += 1
for k, c in enumerate(MIDS):
    tunnel((0, 0), c, -30, -30, hw=2.4, ht=5, seed=sd); sd += 1
    tunnel(c, IN[(2 * k + 1) % 10], -30, infl[(2 * k + 1) % 10], hw=2.4, ht=5, seed=sd); sd += 1
# 内環の環状トンネル
for k in range(10):
    tunnel(IN[k], IN[(k + 1) % 10], infl[k], infl[(k + 1) % 10], hw=2.3, ht=5, seed=sd); sd += 1
# 内環→エリア（各エリアに2本）、エリア→外環
for a, d in AREAS.items():
    ka = int(round(d['ang'] / 36)) % 10
    for k in (ka, (ka + 1) % 10 if (d['ang'] % 36) > 18 else (ka - 1) % 10):
        tunnel(IN[k], d['c'], infl[k], d['floor'], hw=2.5, ht=5, seed=sd); sd += 1
    ko = int(round((d['ang'] - 18) / 36)) % 10
    for k in (ko, (ko + 1) % 10):
        tunnel(d['c'], OUTR[k], d['floor'], outfl[k], hw=2.3, ht=5, seed=sd); sd += 1
# 外環の環状トンネル
for k in range(10):
    tunnel(OUTR[k], OUTR[(k + 1) % 10], outfl[k], outfl[(k + 1) % 10], hw=2.2, ht=5, seed=sd); sd += 1
# 内環と外環を、エリアのない所でもつなぐ（外周に閉じ込められないように）
for k in range(10):
    tunnel(IN[k], OUTR[k], infl[k], outfl[k], hw=2.1, ht=5, seed=sd); sd += 1
# 小部屋（チェストの部屋）：トンネル沿いに
CHAMBERS = []
rc = np.random.default_rng(SEED + 5)
tries = 0
while len(CHAMBERS) < 26 and tries < 4000:
    tries += 1
    x = int(rc.integers(-140, 141)); z = int(rc.integers(-140, 141))
    r0 = math.hypot(x, z)
    if r0 < 36 or r0 > 142: continue
    xi, zi = x + OFF, z + OFF
    if not OPEN[xi, zi] or AREA[xi, zi] != 6: continue
    if any(math.hypot(x - a, z - b) < 22 for a, b in CHAMBERS): continue
    if any(math.hypot(x - d['c'][0], z - d['c'][1]) < d['rad'] + 12 for d in AREAS.values()): continue
    if any(math.hypot(x - a, z - b) < 18 for a, b in MIDS): continue
    # トンネルの横にずらして作る（通り道をふさがない）
    ang = rc.random() * 6.28; cx, cz = x + 6 * math.cos(ang), z + 6 * math.sin(ang)
    carve_blob(cx, cz, 6 + rc.random() * 2, FLT[xi, zi], 8, 5, 7, 2, wob=0.3)
    CHAMBERS.append((int(round(cx)), int(round(cz))))

# ---------------- 床の高さを歩ける傾き（隣と1段以内）にならす ----------------
FL = np.round(FLT).astype(int)
FL[~OPEN] = 0
for it in range(200):
    big = np.where(OPEN, FL, -999); small = np.where(OPEN, FL, 999)
    mx = np.full_like(FL, -999); mn = np.full_like(FL, 999)
    for sx, sz in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        mx = np.maximum(mx, np.roll(np.roll(big, sx, 0), sz, 1))
        mn = np.minimum(mn, np.roll(np.roll(small, sx, 0), sz, 1))
    lo = np.where(mx > -999, mx - 1, FL); hi = np.where(mn < 999, mn + 1, FL)
    new = np.where(lo <= hi, np.clip(FL, lo, hi), (lo + hi) // 2)
    new = np.where(OPEN, new, 0)
    if (new == FL).all(): break
    FL = new
print('relax iterations', it)
FL = np.clip(FL, -37, -12)
HT = np.maximum(HT, 4)
CE = FL + HT + 1
CE = np.minimum(CE, -2)

# 地底湖（鍾乳洞の中、中心から少し外寄り、島を残す）
WATER = np.zeros((N, N), bool)
c3 = AREAS[3]['c']
lake_c = (c3[0] - 9 * math.cos(math.radians(162)) * -1, c3[1] - 9 * math.sin(math.radians(162)) * -1)
ISLANDS = [pol(1, 0)]
isl = (lake_c[0] + 2, lake_c[1] - 2)
for xi, zi in zip(*np.nonzero(OPEN & (AREA == 3))):
    x, z = xi - OFF, zi - OFF
    d = math.hypot(x - lake_c[0], z - lake_c[1])
    if d < 16 + 3 * (nA[xi, zi] - 0.5) and math.hypot(x - isl[0], z - isl[1]) > 3.5:
        WATER[xi, zi] = True
LAKE_LEVEL = int(np.median(FL[OPEN & (AREA == 3)]))

# ---------------- ボクセルに起こす ----------------
FLOOR_MAT = {0: ['minecraft:deepslate_tiles'] * 3 + ['minecraft:polished_deepslate'],
             1: ['minecraft:calcite'] * 3 + ['minecraft:amethyst_block'] * 2 + ['minecraft:smooth_basalt'],
             2: ['minecraft:moss_block'] * 6 + ['minecraft:clay'] + ['minecraft:rooted_dirt'],
             3: ['minecraft:dripstone_block'] * 4 + ['minecraft:stone'] * 2 + ['minecraft:gravel'],
             4: ['minecraft:sculk'] * 4 + ['minecraft:deepslate'] * 2 + ['minecraft:cobbled_deepslate'],
             5: ['minecraft:polished_deepslate'] * 3 + ['minecraft:deepslate_tiles'] + ['minecraft:cobbled_deepslate'],
             6: ['minecraft:stone'] * 4 + ['minecraft:gravel'] + ['minecraft:tuff'] + ['minecraft:andesite'],
             7: ['minecraft:stone'] * 3 + ['minecraft:cobbled_deepslate'] + ['minecraft:tuff'],
             8: ['minecraft:tuff'] * 3 + ['minecraft:stone'] * 2 + ['minecraft:calcite']}
hsh = rng.random((N, N))
for xi, zi in zip(*np.nonzero(OPEN)):
    f, c, a = int(FL[xi, zi]), int(CE[xi, zi]), int(AREA[xi, zi])
    g[xi, zi, f + 1 - Y0:c - Y0] = AIR
    mats = FLOOR_MAT.get(a, FLOOR_MAT[6])
    g[xi, zi, f - Y0] = P(mats[int(hsh[xi, zi] * len(mats)) % len(mats)])
    if WATER[xi, zi]:
        g[xi, zi, LAKE_LEVEL - 3 - Y0] = P('minecraft:clay')
        g[xi, zi, LAKE_LEVEL - 2 - Y0:LAKE_LEVEL + 1 - Y0] = P('minecraft:water')
        g[xi, zi, LAKE_LEVEL + 1 - Y0:c - Y0] = AIR
        FL[xi, zi] = LAKE_LEVEL

# 水が横の空気に接している所（岸が水面より低い所）は鍾乳石のブロックで埋める（水があふれないように）
_W = np.array(['water' in p for p in pal])[g]
for xi, zi, yi in zip(*np.nonzero(_W)):
    for a, b in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        if g[xi + a, zi + b, yi] == AIR:
            g[xi + a, zi + b, yi] = P('minecraft:dripstone_block')
            if FL[xi + a, zi + b] < yi + Y0: FL[xi + a, zi + b] = yi + Y0

# エリアの壁の材質（開いた場所から近い岩）
def dist_map(mask, steps):
    d = np.where(mask, 0, 99)
    cur = mask.copy()
    for s in range(1, steps + 1):
        nb = cur.copy()
        for sx, sz in ((1, 0), (-1, 0), (0, 1), (0, -1)):
            nb |= np.roll(np.roll(cur, sx, 0), sz, 1)
        d = np.where(nb & (d == 99), s, d); cur = nb
    return d
# 見える面の近く（空気から2ブロック以内）の岩だけ塗る（奥の岩はそのまま。コマンドを増やさない）
AIRM = (g == AIR)
NEAR = AIRM.copy()
for _ in range(2):
    nb = NEAR.copy()
    for ax in (0, 1, 2):
        nb |= np.roll(NEAR, 1, ax) | np.roll(NEAR, -1, ax)
    NEAR = nb
def themed_rock(a, fn):
    dm = dist_map(OPEN & (AREA == a), 6)
    for xi, zi in zip(*np.nonzero(dm <= 6)):
        for yi in range(1, NY - 1):
            if not NEAR[xi, zi, yi]: continue
            if g[xi, zi, yi] == AIR or pal[g[xi, zi, yi]] in ('minecraft:water',): continue
            b = fn(int(dm[xi, zi]), yi + Y0, xi, zi)
            if b: g[xi, zi, yi] = P(b)
themed_rock(1, lambda d, y, xi, zi: 'minecraft:amethyst_block' if d <= 1 and hsh[xi, zi] > 0.25 else ('minecraft:calcite' if d <= 3 else 'minecraft:smooth_basalt'))
themed_rock(2, lambda d, y, xi, zi: ('minecraft:moss_block' if (d <= 1 and hsh[xi, zi] > 0.4) else ('minecraft:mossy_cobblestone' if d <= 2 and hsh[xi, zi] > 0.7 else None)))
themed_rock(3, lambda d, y, xi, zi: 'minecraft:dripstone_block' if d <= 2 or hsh[xi, zi] > 0.6 else None)
themed_rock(4, lambda d, y, xi, zi: ('minecraft:sculk' if d <= 1 and hsh[xi, zi] > 0.55 else 'minecraft:deepslate'))
themed_rock(5, lambda d, y, xi, zi: 'minecraft:deepslate' if d <= 3 else None)
themed_rock(0, lambda d, y, xi, zi: 'minecraft:deepslate_bricks' if d <= 1 else ('minecraft:deepslate' if d <= 3 else None))

def is_air(x, y, z): return get(x, y, z) == 'minecraft:air'
def is_solid(x, y, z):
    b = get(x, y, z)
    return b not in ('minecraft:air', 'minecraft:water') and 'lantern' not in b and 'vine' not in b and 'lichen' not in b and 'carpet' not in b and 'cluster' not in b and 'dripstone' != b.split(':')[1]

def fl(x, z): return int(FL[x + OFF, z + OFF])
def ce(x, z): return int(CE[x + OFF, z + OFF])
def opn(x, z): return inb(x, z) and bool(OPEN[x + OFF, z + OFF])
def area(x, z): return int(AREA[x + OFF, z + OFF]) if inb(x, z) else -1

used = np.zeros((N, N), bool)   # 物を置いた床（チェスト・建物）
chests = []; riches = []; ores = []

# ---------------- 中央の地下神殿 ----------------
TF = fl(0, 0)
# 床を平らに（半径22）
for x in range(-22, 23):
    for z in range(-22, 23):
        if math.hypot(x, z) <= 21.5 and opn(x, z):
            xi, zi = x + OFF, z + OFF
            g[xi, zi, TF - Y0] = P('minecraft:polished_deepslate' if (abs(x) + abs(z)) % 6 == 0 else 'minecraft:deepslate_tiles')
            g[xi, zi, TF + 1 - Y0:ce(x, z) - Y0] = AIR
            FL[xi, zi] = TF
# 柱の環（半径15、8本、2×2）
for k in range(8):
    px, pz = pol(15, 22.5 + 45 * k); px, pz = int(round(px)), int(round(pz))
    top = min(ce(px, pz), ce(px + 1, pz + 1)) - 1
    for a in (0, 1):
        for c in (0, 1):
            for y in range(TF + 1, top + 1):
                put(px + a, y, pz + c, 'minecraft:chiseled_deepslate' if y in (TF + 1, top) else 'minecraft:polished_deepslate')
            used[px + a + OFF, pz + c + OFF] = True
    put(px, TF + 5, pz - 1, 'minecraft:soul_lantern[hanging=false]') if False else None
    for a, c in ((-1, 0), (2, 1), (0, 2), (1, -1)):
        put(px + a, TF + 4, pz + c, 'minecraft:soul_lantern[hanging=true]') if is_air(px + a, TF + 4, pz + c) and is_air(px + a, TF + 3, pz + c) and False else None
# 中央の祭壇（7×7、1段）
for x in range(-3, 4):
    for z in range(-3, 4):
        put(x, TF, z, 'minecraft:polished_deepslate')
        put(x, TF + 1, z, 'minecraft:polished_deepslate_slab[type=bottom]' if max(abs(x), abs(z)) == 3 else 'minecraft:deepslate_tile_slab[type=bottom]')
put(0, TF + 1, 0, 'minecraft:chiseled_deepslate')
put(0, TF + 2, 0, 'minecraft:soul_lantern')
for x, z in ((2, 0), (-2, 0), (0, 2), (0, -2)):
    put(x, TF + 1, z, 'minecraft:polished_deepslate'); put(x, TF + 2, z, 'minecraft:chest[facing=%s]' % {(2, 0): 'east', (-2, 0): 'west', (0, 2): 'south', (0, -2): 'north'}[(x, z)])
    riches.append((x, TF + 2, z))
for x in range(-3, 4):
    for z in range(-3, 4): used[x + OFF, z + OFF] = True
# 天井の明かり（魂のランタンを吊る：半径9の環、8個）
for k in range(8):
    x, z = pol(9, 45 * k); x, z = int(round(x)), int(round(z))
    c = ce(x, z)
    for y in range(c - 1, c - 4, -1): put(x, y, z, 'minecraft:iron_chain[axis=y]')
    put(x, c - 4, z, 'minecraft:soul_lantern[hanging=true]')
# 神殿の普通のチェスト（壁ぎわ4つ。1.9.169 で3→8、1.9.172 で8→4：中央付近を減らした）
for k in range(4):
    x, z = pol(19, 45 + 90 * k); x, z = int(round(x)), int(round(z))
    if opn(x, z): put(x, TF + 1, z, 'minecraft:chest'); chests.append((x, TF + 1, z)); used[x + OFF, z + OFF] = True

# 1.9.171: 終盤演出で点滅させるランプ（シーランタン）を神殿に埋め込む。床に3重の輪（A 半径6・B 半径11・C 半径21）、天井に1重（D 半径8）
# 点滅は oa:maps/cave/finale_lamps（finale/cave から0.4秒ごと）、試合の終わりに oa:maps/cave/finale_all_on で全部つける
LAMP = 'minecraft:sea_lantern'
LAMPS = {}   # 輪の名前 -> [(x, y, z, 消灯時のブロック)]
def ring_pts(r, n, ph):
    out = []
    for k in range(n):
        x, z = pol(r, ph + 360 * k / n); x, z = int(round(x)), int(round(z))
        if (x, z) not in [(p[0], p[2]) for p in out]: out.append((x, 0, z))
    return out
for name, r, n, ph in (('A', 6, 16, 0), ('B', 11, 24, 7.5), ('C', 21, 32, 5.625)):
    pts = []
    for (x, _, z) in ring_pts(r, n, ph):
        if used[x + OFF, z + OFF] or not opn(x, z) or fl(x, z) != TF: continue
        if not is_air(x, TF + 1, z): continue
        put(x, TF, z, LAMP); pts.append((x, TF, z, 'minecraft:polished_deepslate'))
    LAMPS[name] = pts
pts = []
for (x, _, z) in ring_pts(8, 16, 11.25):
    c = ce(x, z)
    if not opn(x, z) or c - TF < 12 or not is_air(x, c - 1, z): continue
    put(x, c, z, LAMP); pts.append((x, c, z, 'minecraft:deepslate'))
LAMPS['D'] = pts
print('lamps', {k: len(v) for k, v in LAMPS.items()})

# ---------------- エリアの飾り ----------------
rd = np.random.default_rng(SEED + 7)
def cells(a):
    return [(xi - OFF, zi - OFF) for xi, zi in zip(*np.nonzero(OPEN & (AREA == a) & ~WATER))]
def hang(x, z, b, length=1, chain=None):
    c = ce(x, z)
    for i in range(length - 1):
        if chain and is_air(x, c - 1 - i, z): put(x, c - 1 - i, z, chain)
    if is_air(x, c - length, z): put(x, c - length, z, b)

# 1 晶洞：天井から下向きの紫水晶の結晶、床の結晶（壁ぎわ）、方解石の柱
for x, z in cells(1):
    h = rd.random()
    if h < 0.05 and ce(x, z) - fl(x, z) > 6: hang(x, z, 'minecraft:amethyst_cluster[facing=down]')
    elif h < 0.07 and ce(x, z) - fl(x, z) > 6: hang(x, z, 'minecraft:large_amethyst_bud[facing=down]')
    elif h < 0.085 and not used[x + OFF, z + OFF]:
        near_wall = any(not opn(x + a, z + c) for a, c in ((1, 0), (-1, 0), (0, 1), (0, -1)))
        if near_wall: put(x, fl(x, z) + 1, z, 'minecraft:amethyst_cluster[facing=up]')
d1 = AREAS[1]
for k in range(5):
    x, z = d1['c'][0] + 12 * math.cos(k * 1.26), d1['c'][1] + 12 * math.sin(k * 1.26); x, z = int(round(x)), int(round(z))
    if opn(x, z):
        for y in range(fl(x, z) + 1, ce(x, z)): put(x, y, z, 'minecraft:calcite' if y % 4 else 'minecraft:amethyst_block')
        used[x + OFF, z + OFF] = True

# 2 繁茂：苔のじゅうたん、ツツジ、垂れ下がるベリーのツタ、胞子の花
for x, z in cells(2):
    h = rd.random(); f = fl(x, z); c = ce(x, z)
    if used[x + OFF, z + OFF]: continue
    if h < 0.30: put(x, f + 1, z, 'minecraft:moss_carpet')
    elif h < 0.34: put(x, f + 1, z, 'minecraft:azalea' if h < 0.32 else 'minecraft:flowering_azalea'); used[x + OFF, z + OFF] = True
    elif h < 0.36: put(x, f + 1, z, 'minecraft:small_dripleaf[half=lower,facing=north]'); put(x, f + 2, z, 'minecraft:small_dripleaf[half=upper,facing=north]')
    if c - f > 7:
        v = rd.random()
        if v < 0.06:
            L = int(rd.integers(2, 4))
            for i in range(1, L): put(x, c - i, z, 'minecraft:cave_vines_plant[berries=%s]' % ('true' if i % 2 else 'false'))
            put(x, c - L, z, 'minecraft:cave_vines[age=25,berries=true]')
        elif v < 0.07: put(x, c - 1, z, 'minecraft:spore_blossom')

# 3 鍾乳洞：天井からつらら、床から石筍（壁ぎわ寄り）
def drip(x, y, z, up, L):
    names = ['tip', 'frustum', 'middle', 'base'] if L >= 4 else (['tip', 'frustum', 'base'] if L == 3 else (['tip', 'base'] if L == 2 else ['tip']))
    for i, t in enumerate(names):
        yy = y + (i if not up else -i)
        put(x, yy, z, 'minecraft:pointed_dripstone[vertical_direction=%s,thickness=%s]' % ('up' if up else 'down', t))
for x, z in cells(3):
    h = rd.random(); f = fl(x, z); c = ce(x, z)
    if c - f > 8 and h < 0.07:
        L = int(rd.integers(1, 5)); drip(x, c - L, z, False, L)
    elif h < 0.10 and not used[x + OFF, z + OFF] and any(not opn(x + a, z + cc) for a, cc in ((2, 0), (-2, 0), (0, 2), (0, -2))):
        L = int(rd.integers(1, 3)); drip(x, f + L, z, True, L); used[x + OFF, z + OFF] = True
# 島のチェスト（特別2）と、湖のまわりのヒカリゴケの代わりの明かり（シーピクル）
for xi, zi in zip(*np.nonzero(WATER)):
    if rd.random() < 0.03: g[xi, zi, LAKE_LEVEL - 2 - Y0] = P('minecraft:sea_pickle[pickles=3,waterlogged=true]')
ix, iz = int(round(isl[0])), int(round(isl[1]))
for x, z in ((ix, iz), (ix + 1, iz)):
    if opn(x, z) and not WATER[x + OFF, z + OFF]:
        put(x, fl(x, z) + 1, z, 'minecraft:chest'); riches.append((x, fl(x, z) + 1, z)); used[x + OFF, z + OFF] = True

# 4 廃坑とディープダーク：中心の西半分は坑道の木組み、東半分はスカルク
d4 = AREAS[4]
for x, z in cells(4):
    f = fl(x, z); c = ce(x, z); h = rd.random()
    if used[x + OFF, z + OFF]: continue
    side = (x - d4['c'][0]) * math.cos(math.radians(d4['ang'])) + (z - d4['c'][1]) * math.sin(math.radians(d4['ang']))
    if side < -2:   # 坑道側（神殿寄り）
        if h < 0.18: put(x, f, z, 'minecraft:oak_planks' if False else 'minecraft:cobbled_deepslate')
        if h > 0.985: put(x, f + 1, z, 'minecraft:rail')
    else:           # ディープダーク側
        if h < 0.25: put(x, f + 1, z, 'minecraft:sculk_vein[down=true]')
        elif h < 0.27: put(x, f + 1, z, 'minecraft:sculk_sensor'); used[x + OFF, z + OFF] = True
        if c - f > 7 and rd.random() < 0.012: hang(x, z, 'minecraft:soul_lantern[hanging=true]', 3, 'minecraft:iron_chain[axis=y]')
# 坑道の木組み：エリア4へ向かうトンネルと、エリア4の坑道側に4ブロックおき
def frame(x, z, axis):
    f = fl(x, z); c = min(ce(x, z), f + 5)
    # 柱は通路の両脇、梁は天井
    if axis == 'x':
        pts = [(x, z + o) for o in range(-4, 5)]
    else:
        pts = [(x + o, z) for o in range(-4, 5)]
    op = [p for p in pts if opn(*p) and abs(fl(*p) - f) <= 1]
    if len(op) < 3: return
    a, b = op[0], op[-1]
    for p in (a, b):
        for y in range(fl(*p) + 1, fl(*p) + 4): put(p[0], y, p[1], 'minecraft:oak_fence')
    for p in op:
        put(p[0], fl(*p) + 4, p[1], 'minecraft:stripped_oak_log[axis=%s]' % ('z' if axis == 'x' else 'x'))
    put(x, fl(x, z) + 3, z, 'minecraft:lantern[hanging=true]') if rd.random() < 0.3 else None
for x, z in cells(6):
    if math.hypot(x - d4['c'][0], z - d4['c'][1]) < d4['rad'] + 30 and (x % 5 == 0 and z % 9 == 0):
        if ce(x, z) - fl(x, z) >= 5: frame(x, z, 'x' if rd.random() < 0.5 else 'z')

# 5 古代都市（1.9.170 で建物と飾りを増やした）：通りの格子（9ブロックごと、幅2）、区画ごとに建物（家・塔・廃墟）、
#   魂のランタンの街灯、ろうそく、玄武岩の柱、スカルク、ドクロ、広場の大門とじゅうたん
d5 = AREAS[5]; cx5, cz5 = int(round(d5['c'][0])), int(round(d5['c'][1]))
F5 = fl(cx5, cz5)
rt = np.random.default_rng(SEED + 55)
for x, z in cells(5):
    if abs(fl(x, z) - F5) <= 2:
        on_street = ((x - cx5) % 9 in (0, 1)) or ((z - cz5) % 9 in (0, 1))
        put(x, fl(x, z), z, 'minecraft:polished_deepslate' if on_street else ('minecraft:deepslate_tiles' if rt.random() < 0.8 else 'minecraft:cracked_deepslate_tiles'))
houses = []   # (hx, hz, base, size, height, kind)
for gx in range(-4, 5):
    for gz in range(-4, 5):
        if gx in (-1, 0) and gz in (-1, 0): continue   # 中央の交差点のまわり4区画は広場（約16×16）
        size = int(rt.choice([5, 6, 7]))
        kind = str(rt.choice(['house', 'house', 'house', 'tower', 'ruin']))
        if kind == 'tower': size = 5
        hx = cx5 + gx * 9 + 2 + int(rt.integers(0, 8 - size))
        hz = cz5 + gz * 9 + 2 + int(rt.integers(0, 8 - size))
        cs = [(hx + a, hz + c) for a in range(size) for c in range(size)]
        if not all(opn(*p) and area(*p) == 5 for p in cs): continue
        base = fl(hx, hz)
        if any(abs(fl(*p) - base) > 1 for p in cs): continue
        hgt = {'house': int(rt.integers(4, 7)), 'tower': int(rt.integers(8, 11)), 'ruin': int(rt.integers(3, 5))}[kind]
        if min(ce(*p) for p in cs) - base < hgt + 3: continue
        houses.append((hx, hz, base, size, hgt, kind))
for (hx, hz, base, size, hgt, kind) in houses:
    L = size - 1; mid = L // 2
    for a in range(size):
        for c in range(size):
            x, z = hx + a, hz + c
            put(x, base, z, 'minecraft:polished_deepslate')
            edge = a in (0, L) or c in (0, L)
            corner = a in (0, L) and c in (0, L)
            for y in range(base + 1, base + hgt + 1):
                if not edge: b = 'minecraft:air'
                elif corner: b = 'minecraft:polished_deepslate' if kind != 'tower' else 'minecraft:polished_basalt[axis=y]'
                elif kind == 'tower' and (y - base) % 4 == 0: b = 'minecraft:chiseled_deepslate'
                else: b = 'minecraft:deepslate_bricks' if rt.random() > 0.15 else 'minecraft:cracked_deepslate_bricks'
                if kind == 'ruin' and edge and not corner and y > base + 1 and rt.random() < 0.45: b = 'minecraft:air'
                put(x, y, z, b)
            if kind != 'ruin':
                put(x, base + hgt + 1, z, 'minecraft:chiseled_deepslate' if corner else 'minecraft:deepslate_tile_slab[type=bottom]')
            FL[x + OFF, z + OFF] = base
            used[x + OFF, z + OFF] = edge and not (c == L and a in (mid, mid + 1))
    # 入口（南側の中央2マス）と窓（東西の目の高さ）
    for a in (mid, mid + 1):
        put(hx + a, base + 1, hz + L, 'minecraft:air'); put(hx + a, base + 2, hz + L, 'minecraft:air')
    put(hx, base + 2, hz + mid, 'minecraft:air'); put(hx + L, base + 2, hz + mid, 'minecraft:air')
    if kind == 'tower':
        for y in range(base + 5, base + hgt, 3):
            put(hx + mid, y, hz, 'minecraft:air'); put(hx + mid, y, hz + L, 'minecraft:air')
    if kind != 'ruin':
        put(hx + mid, base + hgt, hz + mid, 'minecraft:soul_lantern[hanging=true]')
        for (a, c) in ((0, 0), (L, 0), (0, L), (L, L)):     # 屋根の四隅（模様入りの深層岩）の上にろうそく
            if rt.random() < 0.6: put(hx + a, base + hgt + 2, hz + c, 'minecraft:candle[candles=%d,lit=true]' % int(rt.integers(1, 5)))
    elif rt.random() < 0.5:
        put(hx + 1, base + 1, hz + 1, 'minecraft:skeleton_skull[rotation=%d]' % int(rt.integers(0, 16)))
# チェスト：廃墟以外の3軒に1軒（最初の3つは特別）
k = 0
for (hx, hz, base, size, hgt, kind) in houses:
    if kind == 'ruin': continue
    if k % 3 == 0:
        put(hx + 1, base + 1, hz + 1, 'minecraft:chest'); (riches if k < 6 else chests).append((hx + 1, base + 1, hz + 1))
    k += 1
# 街灯（通りの交差点に、魂のランタン）
for gx in range(-4, 5):
    for gz in range(-4, 5):
        x, z = cx5 + gx * 9, cz5 + gz * 9
        if opn(x, z) and area(x, z) == 5 and not used[x + OFF, z + OFF] and ce(x, z) - fl(x, z) > 6:
            f = fl(x, z)
            put(x, f + 1, z, 'minecraft:polished_deepslate_wall'); put(x, f + 2, z, 'minecraft:polished_deepslate_wall'); put(x, f + 3, z, 'minecraft:soul_lantern')
            used[x + OFF, z + OFF] = True
# 通りの飾り：スカルクのしみ、スカルクの筋、ドクロ、ろうそく
for x, z in cells(5):
    if used[x + OFF, z + OFF] or not is_air(x, fl(x, z) + 1, z): continue
    h = rt.random()
    nb_wall = any(not opn(x + a, z + b) or used[x + a + OFF, z + b + OFF] for a, b in ((1, 0), (-1, 0), (0, 1), (0, -1)))
    if h < 0.04: put(x, fl(x, z), z, 'minecraft:sculk')
    elif h < 0.07: put(x, fl(x, z) + 1, z, 'minecraft:sculk_vein[down=true]')
    elif h < 0.075 and nb_wall:
        put(x, fl(x, z) + 1, z, 'minecraft:skeleton_skull[rotation=%d]' % int(rt.integers(0, 16))); used[x + OFF, z + OFF] = True
    elif h < 0.09 and nb_wall:
        put(x, fl(x, z) + 1, z, 'minecraft:candle[candles=%d,lit=true]' % int(rt.integers(2, 5))); used[x + OFF, z + OFF] = True
# 広場：じゅうたん（空色と灰色の市松）
for a in range(-5, 6):
    for b in range(-5, 6):
        x, z = cx5 + a, cz5 + b
        if opn(x, z) and not used[x + OFF, z + OFF] and abs(fl(x, z) - F5) <= 1 and is_air(x, fl(x, z) + 1, z):
            put(x, fl(x, z) + 1, z, 'minecraft:light_blue_carpet' if (a + b) % 2 == 0 else 'minecraft:gray_carpet')
# 広場の北の大門（幅13・高さ9。玄武岩の柱、模様入りの深層岩、魂のランタン）
GZ = cz5 - 7
for o in (-6, 6):
    for y in range(F5 + 1, F5 + 9):
        put(cx5 + o, y, GZ, 'minecraft:chiseled_deepslate' if y in (F5 + 1, F5 + 8) else 'minecraft:polished_basalt[axis=y]')
    put(cx5 + o, F5 + 10, GZ, 'minecraft:soul_lantern')
    used[cx5 + o + OFF, GZ + OFF] = True
for a in range(-6, 7):
    put(cx5 + a, F5 + 9, GZ, 'minecraft:chiseled_deepslate' if a in (-6, 6) else 'minecraft:deepslate_tiles')
    if abs(a) <= 5: put(cx5 + a, F5 + 8, GZ, 'minecraft:deepslate_tile_slab[type=top]') if abs(a) >= 4 else None
for a in (-3, 0, 3):
    put(cx5 + a, F5 + 8, GZ, 'minecraft:soul_lantern[hanging=true]')
# 広場の四隅の玄武岩の柱（高さ4、上にろうそく）
for a, b in ((-5, -5), (5, -5), (-5, 5), (5, 5)):
    x, z = cx5 + a, cz5 + b
    if opn(x, z) and not used[x + OFF, z + OFF]:
        for y in range(fl(x, z) + 1, fl(x, z) + 5): put(x, y, z, 'minecraft:polished_basalt[axis=y]')
        put(x, fl(x, z) + 5, z, 'minecraft:candle[candles=4,lit=true]'); used[x + OFF, z + OFF] = True

# ---------------- トンネルと小部屋の明かり（暗め）・チェスト ----------------
LIGHT_FACES = {(1, 0): 'east', (-1, 0): 'west', (0, 1): 'south', (0, -1): 'north'}
for x, z in cells(6) + cells(7) + cells(8):
    if used[x + OFF, z + OFF]: continue
    f = fl(x, z); c = ce(x, z); h = rd.random()
    if h < 0.03:   # 壁のヒカリゴケ（目の高さ）。1.9.170 で 0.012→0.03（明るく）
        for (a, b), face in LIGHT_FACES.items():
            if not opn(x + a, z + b) and is_air(x, f + 2, z):
                put(x, f + 2, z, f'minecraft:glow_lichen[{face}=true]'); break
    elif h < 0.04 and c - f >= 5:   # 吊りランタン（1.9.170 で約2.5倍）
        hang(x, z, 'minecraft:lantern[hanging=true]')
    elif h < 0.06:
        put(x, f + 1, z, 'minecraft:air')
# エリアの明かりの補い（晶洞はヒカリゴケ、町と深層は少なめ）
for a, p in ((1, 0.025), (3, 0.02), (4, 0.012), (5, 0.012), (8, 0.025), (0, 0.01)):   # 1.9.170: 約2.5倍、深層・神殿にも
    for x, z in cells(a):
        if rd.random() < p and not used[x + OFF, z + OFF]:
            for (dx, dz), face in LIGHT_FACES.items():
                if not opn(x + dx, z + dz) and is_air(x, fl(x, z) + 2, z):
                    put(x, fl(x, z) + 2, z, f'minecraft:glow_lichen[{face}=true]'); break

def wall_spot(cands, k, kind, lst):
    """壁ぎわ（となりが岩）の床にチェストを置く"""
    rd.shuffle(cands); n = 0
    for x, z in cands:
        if n >= k: break
        if used[x + OFF, z + OFF] or WATER[x + OFF, z + OFF]: continue
        if not any(not opn(x + a, z + b) for a, b in ((1, 0), (-1, 0), (0, 1), (0, -1))): continue
        if any(abs(x - c[0]) + abs(z - c[2]) < 6 for c in chests + riches): continue
        f = fl(x, z)
        if not is_air(x, f + 1, z) or not is_air(x, f + 2, z): continue
        put(x, f + 1, z, 'minecraft:chest'); lst.append((x, f + 1, z)); used[x + OFF, z + OFF] = True; n += 1
    return n
# 小部屋に各2、中間空洞に各2、エリアに各3〜5、深層は特別3、晶洞は特別2
for (cx, cz) in CHAMBERS:
    cs = [(x, z) for x, z in cells(7) if math.hypot(x - cx, z - cz) < 9]
    wall_spot(cs, 2, 'n', chests)
for (cx, cz) in MIDS:   # 1.9.169: 中間の空洞は各2→3、1.9.172 で3→2
    cs = [(x, z) for x, z in cells(8) if math.hypot(x - cx, z - cz) < 12]
    wall_spot(cs, 2, 'n', chests)
for a, k in ((1, 4), (2, 5), (3, 4), (4, 4)):
    wall_spot(cells(a), k, 'n', chests)
side4 = [(x, z) for x, z in cells(4) if (x - d4['c'][0]) * math.cos(math.radians(d4['ang'])) + (z - d4['c'][1]) * math.sin(math.radians(d4['ang'])) >= 0]
wall_spot(side4, 2, 'r', riches)   # 1.9.172: ディープダーク 3→2
wall_spot(cells(1), 1, 'r', riches)   # 1.9.172: 晶洞 2→1
# 1.9.172: 祭壇の4つ（十字に並ぶ）のうち、東西の2つを特別、南北の2つを通常に。地底湖の島は1つだけ特別に
for c in [c for c in riches if (abs(c[0]), abs(c[2])) == (0, 2)]:
    riches.remove(c); chests.insert(0, c)
_isl = [c for c in riches if math.hypot(c[0] - isl[0], c[2] - isl[1]) <= 4]
for c in _isl[1:]:
    riches.remove(c); chests.insert(0, c)
# 足りない分はトンネルの壁ぎわに
need = NCH - len(chests)
if need > 0:
    cs = [(x, z) for x, z in cells(6) if 40 < math.hypot(x, z) < 145]
    wall_spot(cs, need, 'n', chests)
while len(chests) > NCH:
    x, y, z = chests.pop(); put(x, y, z, 'minecraft:air'); used[x + OFF, z + OFF] = False
print('chests', len(chests), 'rich', len(riches), 'houses', len(houses), 'chambers', len(CHAMBERS))

# ---------------- 鉱石（トンネル・小部屋の壁の、足と目の高さ） ----------------
oc = []
cand = cells(6) + cells(7)
rd.shuffle(cand)
for x, z in cand:
    if len(oc) >= NORE: break
    if math.hypot(x, z) < 30: continue
    f = fl(x, z)
    for (a, b) in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        wx, wz = x + a, z + b
        if opn(wx, wz): continue
        y = f + 1 + int(rd.random() < 0.5)
        if get(wx, y, wz) in ('minecraft:air', 'minecraft:water') or 'ore' in get(wx, y, wz): continue
        if any(abs(wx - o[0]) + abs(wz - o[2]) < 6 for o in oc): continue
        k = 1 if len(oc) % 9 < 5 else 3
        put(wx, y, wz, 'minecraft:coal_ore' if k == 1 else 'minecraft:redstone_ore')
        oc.append((wx, y, wz, k)); break
ores = oc

# ---------------- 開始地点 ----------------
def headroom(x, z, n=3):
    f = fl(x, z)
    return all(is_air(x, y, z) for y in range(f + 1, f + 1 + n))
sp = []
cand = [(x, z) for x, z in cells(6) + cells(7) + cells(8) + cells(1) + cells(2) + cells(3) + cells(4) + cells(5)
        if 45 <= math.hypot(x, z) <= 140 and not used[x + OFF, z + OFF]]
rs = np.random.default_rng(SEED + 9); rs.shuffle(cand)
for x, z in cand:
    if len(sp) >= 40: break
    if any(math.hypot(x - a, z - c) < 17 for a, _, c in sp): continue
    if not all(opn(x + a, z + b) and abs(fl(x + a, z + b) - fl(x, z)) <= 1 and headroom(x + a, z + b) for a in (-1, 0, 1) for b in (-1, 0, 1)): continue
    sp.append((x, fl(x, z) + 1, z))
assert len(sp) == 40, len(sp)

# ---------------- 到達性（中央から歩いて行けるか） ----------------
def walk(x, z):
    if not opn(x, z) or WATER[x + OFF, z + OFF] or used[x + OFF, z + OFF]: return False
    f = fl(x, z)
    return is_air(x, f + 1, z) and is_air(x, f + 2, z) or (get(x, f + 1, z) in ('minecraft:moss_carpet', 'minecraft:rail') or 'sculk_vein' in get(x, f + 1, z) or 'lichen' in get(x, f + 1, z)) and is_air(x, f + 2, z)
start = (10, 0)
assert walk(*start)
seen = {start}; q = deque([start])
while q:
    cx, cz = q.popleft()
    for dx, dz in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        k = (cx + dx, cz + dz)
        if k not in seen and walk(*k) and abs(fl(*k) - fl(cx, cz)) <= 1: seen.add(k); q.append(k)
def reach(x, z):
    if any((x + a, z + b) in seen for a, b in ((0, 0), (1, 0), (-1, 0), (0, 1), (0, -1))): return True
    if max(abs(x), abs(z)) <= 3:   # 神殿の祭壇の上（1段上がって取る）：祭壇の外側から2マス
        return any((x + a, z + b) in seen for a in range(-2, 3) for b in range(-2, 3))
    if math.hypot(x - isl[0], z - isl[1]) <= 4:   # 地底湖の島（泳いで渡る）：岸から湖を渡れるか
        return any(WATER[x + a + OFF, z + b + OFF] for a in range(-3, 4) for b in range(-3, 4)) and any((xx, zz) in seen for xx in range(x - 22, x + 23) for zz in range(z - 22, z + 23) if math.hypot(xx - lake_c[0], zz - lake_c[1]) < 19)
    return False
bad_sp = [p for p in sp if (p[0], p[2]) not in seen]
bad_ch = [c for c in chests + riches if not reach(c[0], c[2])]
bad_or = [o for o in ores if not reach(o[0], o[2])]
# 届かない鉱石は岩に戻し、歩ける場所の横に置き直す
for o in bad_or:
    put(o[0], o[1], o[2], 'minecraft:stone'); ores.remove(o)
cand = [k for k in seen if area(*k) in (6, 7) and math.hypot(*k) > 30]
rd.shuffle(cand)
for x, z in cand:
    if len(ores) >= NORE: break
    f = fl(x, z)
    for (a, b) in ((1, 0), (-1, 0), (0, 1), (0, -1)):
        wx, wz = x + a, z + b
        if opn(wx, wz): continue
        y = f + 1
        if get(wx, y, wz) in ('minecraft:air', 'minecraft:water') or 'ore' in get(wx, y, wz): continue
        if any(abs(wx - o[0]) + abs(wz - o[2]) < 6 for o in ores): continue
        k = 1 if len(ores) % 9 < 5 else 3
        put(wx, y, wz, 'minecraft:coal_ore' if k == 1 else 'minecraft:redstone_ore'); ores.append((wx, y, wz, k)); break
ores = [(int(a), int(b), int(c), int(d)) for a, b, c, d in ores]
bad_or = [o for o in ores if not reach(o[0], o[2])]
openwalk = sum(1 for xi, zi in zip(*np.nonzero(OPEN & ~WATER)) if walk(xi - OFF, zi - OFF))
print('bad_or', [o for o in ores if not reach(o[0], o[2])][:5])
print('reach', len(seen), '/', openwalk, 'bad spawn/chest/ore', len(bad_sp), len(bad_ch), len(bad_or))
if bad_ch: print('bad_ch', bad_ch[:10])
if bad_sp: print('bad_sp', bad_sp[:10])
assert not bad_sp and not bad_ch and not bad_or
assert len(chests) == NCH and len(riches) == 8 and len(ores) == NORE, (len(chests), len(riches), len(ores))

# ---------------- 画像（確認用） ----------------
if PNG:
    from PIL import Image
    col = {0: (120, 110, 140), 1: (170, 110, 220), 2: (90, 170, 80), 3: (150, 130, 100), 4: (40, 70, 80), 5: (90, 90, 110), 6: (110, 110, 110), 7: (140, 125, 100), 8: (130, 150, 150)}
    img = np.zeros((N, N, 3), np.uint8); img[:] = (25, 22, 20)
    for xi, zi in zip(*np.nonzero(OPEN)):
        c = np.array(col.get(int(AREA[xi, zi]), (100, 100, 100)), float)
        sh = 0.75 + 0.06 * (FL[xi, zi] + 30)
        img[zi, xi] = np.clip(c * sh, 0, 255)
        if WATER[xi, zi]: img[zi, xi] = (40, 80, 170)
        if (xi - OFF, zi - OFF) in seen and False: pass
        if used[xi, zi]: img[zi, xi] = (60, 50, 45)
    for x, y, z in chests: img[z + OFF, x + OFF] = (240, 200, 60)
    for x, y, z in riches: img[z + OFF, x + OFF] = (255, 80, 60)
    for x, y, z in sp: img[z + OFF, x + OFF] = (60, 220, 255)
    for x, y, z, k in ores: img[z + OFF, x + OFF] = (0, 0, 0) if k == 1 else (200, 0, 0)
    Image.fromarray(img).resize((N * 3, N * 3), Image.NEAREST).save(PNG)
    print('png', PNG)
if '--check' in sys.argv and __name__ == '__main__': sys.exit(0)

# ---------------- 保存 ----------------
os.makedirs(f"{ROOT}/source", exist_ok=True)
np.savez_compressed(f"{ROOT}/source/map_cave_target.npz", grid=g, palette=np.array(pal))
json.dump({"size": [N, N], "y_range": [Y0, TOP], "origin_y": 80, "areas": {str(a): AREA_NAME[a] for a in AREA_NAME},
           "area_centers": {str(a): [round(d['c'][0]), round(d['c'][1])] for a, d in AREAS.items()},
           "chests": chests, "rich": riches, "ores": ores, "houses": len(houses), "chambers": CHAMBERS, "mids": [[round(a), round(b)] for a, b in MIDS],
           "spawn_points": sp, "lake_level": LAKE_LEVEL}, open(f"{ROOT}/MAP_CAVE_MANIFEST.json", "w", encoding="utf8"), ensure_ascii=False, indent=1, default=int)

# ---------------- 関数の書き出し（ネザーと同じ形） ----------------
os.makedirs(OUT, exist_ok=True)
for d in ('preload', 'wait', 'release', 'apply', 'place'): os.makedirs(f"{OUT}/{d}", exist_ok=True)
rects = {}
for p in glob.glob(SRC + '/preload/*.mcfunction'):
    n = int(os.path.basename(p)[:-11]); s = open(p, encoding='utf8').read()
    m = re.search(r'forceload add ~(-?\d+) ~(-?\d+) ~(-?\d+) ~(-?\d+)', s); rects[n] = tuple(map(int, m.groups()))
    for d in ('preload', 'wait', 'release'):
        t = open(f"{SRC}/{d}/{n}.mcfunction", encoding='utf8').read().replace('oa:map/internal/tiles/', 'oa:maps/cave/tiles/')
        open(f"{OUT}/{d}/{n}.mcfunction", 'w', encoding='utf8').write(t)
assert len(rects) == 100

def tile_cmds(n):
    x1, z1, x2, z2 = rects[n]
    sub = g[x1 + OFF:x2 + OFF + 1, z1 + OFF:z2 + OFF + 1, :]
    nx, nz, ny = sub.shape
    rects_y = {}
    for y in range(ny):
        layer = sub[:, :, y]; rows = []
        for z in range(nz):
            runs = []; x = 0
            while x < nx:
                v = layer[x, z]
                if v == 0: x += 1; continue
                x2_ = x
                while x2_ + 1 < nx and layer[x2_ + 1, z] == v: x2_ += 1
                runs.append((x, x2_, int(v))); x = x2_ + 1
            rows.append(runs)
        cur = {}
        for z in range(nz + 1):
            now = set(rows[z]) if z < nz else set()
            for key in list(cur):
                if key not in now:
                    rects_y.setdefault((key[0], cur[key], key[1], z - 1, key[2]), []).append(y); del cur[key]
            for key in now:
                if key not in cur: cur[key] = z
    # 高さ41は1回の fill（32768）に収まらないので2回に分けて空にする
    lines = ['scoreboard players set #stage oa.map2 1',
             f"fill ~{x1} ~{Y0} ~{z1} ~{x2} ~-21 ~{z2} minecraft:air",
             f"fill ~{x1} ~-20 ~{z1} ~{x2} ~0 ~{z2} minecraft:air"]
    for (a, za, b, zb, v), ys in rects_y.items():
        ys.sort(); s = ys[0]; prev = ys[0]
        for yy in ys[1:] + [None]:
            if yy is not None and yy == prev + 1: prev = yy; continue
            X1, X2 = x1 + a, x1 + b; Z1, Z2 = z1 + za, z1 + zb; Y1, Y2 = Y0 + s, Y0 + prev
            bl = pal[v]
            vol = (X2 - X1 + 1) * (Z2 - Z1 + 1) * (Y2 - Y1 + 1)
            if vol == 1: lines.append(f"setblock ~{X1} ~{Y1} ~{Z1} {bl}")
            else:
                if vol > 32768:   # 縦に割る
                    step = max(1, 32768 // ((X2 - X1 + 1) * (Z2 - Z1 + 1)))
                    yy0 = Y1
                    while yy0 <= Y2:
                        yy1 = min(Y2, yy0 + step - 1)
                        lines.append(f"fill ~{X1} ~{yy0} ~{Z1} ~{X2} ~{yy1} ~{Z2} {bl}"); yy0 = yy1 + 1
                else:
                    lines.append(f"fill ~{X1} ~{Y1} ~{Z1} ~{X2} ~{Y2} ~{Z2} {bl}")
            if yy is not None: s = prev = yy
    return lines
def inrect(r, x, z): return r[0] <= x <= r[2] and r[1] <= z <= r[3]
for n in range(100):
    r = rects[n]; x1, z1, x2, z2 = r
    open(f"{OUT}/place/{n}.mcfunction", 'w', encoding='utf8').write('\n'.join(tile_cmds(n)) + '\n')
    cs = [c for c in chests if inrect(r, c[0], c[2])]; rs_ = [c for c in riches if inrect(r, c[0], c[2])]; os_ = [o for o in ores if inrect(r, o[0], o[2])]
    A = [f"execute if score #mode oa.map2 matches 0 run function oa:maps/cave/tiles/place/{n}",
         "execute if score #state oa.map2 matches 2 run return 0",
         f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:marker,tag=br.chest,dx={x2 - x1},dy={NY - 1},dz={z2 - z1}]",
         f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:marker,tag=br.ore,dx={x2 - x1},dy={NY - 1},dz={z2 - z1}]",
         "scoreboard players set #stage oa.map2 2", f"scoreboard players set #expectedc oa.map2 {len(cs) + len(rs_)}",
         f"scoreboard players set #expectedo oa.map2 {len(os_)}", "scoreboard players set #localc oa.map2 0", "scoreboard players set #localo oa.map2 0"]
    for (x, y, z, k) in os_: A.append(f"execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:{'coal_ore' if k == 1 else 'redstone_ore'} align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_{k}")
    for (x, y, z) in rs_: A.append(f"execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich")
    for (x, y, z) in cs: A.append(f"execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest")
    for (x, y, z) in rs_: A.append(f"execute if score #mode oa.map2 matches 0 positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site")
    for (x, y, z) in cs: A.append(f"execute if score #mode oa.map2 matches 0 positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic")
    A += [f"execute unless score #localc oa.map2 matches {len(cs) + len(rs_)} run return run function oa:map/internal/job/failed",
          f"execute unless score #localo oa.map2 matches {len(os_)} run return run function oa:map/internal/job/failed",
          "scoreboard players operation #chests oa.map2 += #localc oa.map2", "scoreboard players operation #ores oa.map2 += #localo oa.map2",
          f"function oa:maps/cave/tiles/release/{n}", "scoreboard players add #tile oa.map2 1",
          "execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2",
          "execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish",
          "schedule function oa:map/internal/job/next 1t replace"]
    open(f"{OUT}/apply/{n}.mcfunction", 'w', encoding='utf8').write('\n'.join(A) + '\n')
pts = ",".join(f"{{x:{x}.5d,y:{y + 80}.0d,z:{z}.5d}}" for x, y, z in sp)
open(f"{ROOT}/data/oa/function/maps/cave/post.mcfunction", 'w', encoding='utf8').write(
    "# 生成: scripts/build_map_cave.py（直接編集しない）。洞窟会場の生成完了後に呼ばれる（開始地点の登録）\n"
    "data modify storage oa:spawn_points dim set value \"oa:br_cave\"\n"
    f"data modify storage oa:spawn_points points set value [{pts}]\n"
    "tellraw @a[tag=br.admin] {text:\"洞窟会場の開始地点を40か所登録しました。\",color:\"green\"}\n")
print(json.dumps({"palette": len(pal), "chests": len(chests), "rich": len(riches), "ores": len(ores), "houses": len(houses), "spawn": len(sp)}))

# ---------------- 空中補給の場所名（いちばん近いエリア） ----------------
L = ["# 生成: scripts/build_map_cave.py（直接編集しない）。洞窟会場の空中補給の場所名（中心からの相対座標 #rx,#rz は br/supply/region で計算済み）。いちばん近いエリアの名前",
     "scoreboard players set #rbest br.tmp 2147483647"]
for a, d in AREAS.items():
    cx, cz = round(d['c'][0]), round(d['c'][1])
    L += ["scoreboard players operation #rdx br.tmp = #rx br.tmp", f"scoreboard players remove #rdx br.tmp {cx}" if cx >= 0 else f"scoreboard players add #rdx br.tmp {-cx}",
          "scoreboard players operation #rdx br.tmp *= #rdx br.tmp",
          "scoreboard players operation #rdz br.tmp = #rz br.tmp", f"scoreboard players remove #rdz br.tmp {cz}" if cz >= 0 else f"scoreboard players add #rdz br.tmp {-cz}",
          "scoreboard players operation #rdz br.tmp *= #rdz br.tmp",
          "scoreboard players operation #rdx br.tmp += #rdz br.tmp",
          f'execute if score #rdx br.tmp < #rbest br.tmp run data modify storage oa:supply region set value "{AREA_NAME[a]}のあたり"',
          "execute if score #rdx br.tmp < #rbest br.tmp run scoreboard players operation #rbest br.tmp = #rdx br.tmp"]
L.append('execute if score #rx br.tmp matches -27..27 if score #rz br.tmp matches -27..27 run data modify storage oa:supply region set value "地下神殿"')
open(f"{ROOT}/data/oa/function/maps/cave/supply_region.mcfunction", 'w', encoding='utf8').write('\n'.join(L) + '\n')

# ---------------- 1.9.171: 終盤演出のランプの点滅（神殿の床の立ち位置＝絶対 y51 を原点にした相対座標） ----------------
def lamp_lines(x, y, z, off, on_cond, off_cond):
    pos = f"~{x} ~{y + 80 - 51} ~{z}"
    return [f"execute {on_cond} if block {pos} {off} run setblock {pos} {LAMP}",
            f"execute {off_cond} if block {pos} {LAMP} run setblock {pos} {off}"]
FL_ = ["# 生成: scripts/build_map_cave.py（直接編集しない）。洞窟の終盤演出のランプの点滅（finale/cave から、神殿の床の立ち位置で0.4秒ごと）",
       "# A（床・半径6）：#fstep 0 だけ点灯／B（床・半径11）：3つおきに回る／C（床・半径21）：逆回り／D（天井・半径8）：#fstep 1 だけ消灯"]
for (x, y, z, off) in LAMPS['A']:
    FL_ += lamp_lines(x, y, z, off, 'if score #fstep br.tmp matches 0', 'unless score #fstep br.tmp matches 0')
for k, (x, y, z, off) in enumerate(LAMPS['B']):
    FL_ += lamp_lines(x, y, z, off, f'if score #fstep br.tmp matches {k % 3}', f'unless score #fstep br.tmp matches {k % 3}')
for k, (x, y, z, off) in enumerate(LAMPS['C']):
    FL_ += lamp_lines(x, y, z, off, f'if score #fstep br.tmp matches {(2 - k) % 3}', f'unless score #fstep br.tmp matches {(2 - k) % 3}')
for (x, y, z, off) in LAMPS['D']:
    FL_ += lamp_lines(x, y, z, off, 'unless score #fstep br.tmp matches 1', 'if score #fstep br.tmp matches 1')
open(f"{ROOT}/data/oa/function/maps/cave/finale_lamps.mcfunction", 'w', encoding='utf8').write('\n'.join(FL_) + '\n')
ON = ["# 生成: scripts/build_map_cave.py（直接編集しない）。終盤演出のランプを全部つけた状態に戻す（br/finale/lamps_on から、神殿の床の立ち位置で）"]
for name in 'ABCD':
    for (x, y, z, off) in LAMPS[name]:
        pos = f"~{x} ~{y + 80 - 51} ~{z}"
        ON.append(f"execute if block {pos} {off} run setblock {pos} {LAMP}")
open(f"{ROOT}/data/oa/function/maps/cave/finale_all_on.mcfunction", 'w', encoding='utf8').write('\n'.join(ON) + '\n')
# 光の柱を立てる8本の柱の位置（finale/cave から）
PL = ["# 生成: scripts/build_map_cave.py（直接編集しない）。神殿の8本の柱に沿って光の柱（finale/cave から、神殿の床の立ち位置で）"]
for k in range(8):
    px, pz = pol(15, 22.5 + 45 * k); px, pz = int(round(px)) + 1, int(round(pz)) + 1
    PL.append(f"particle minecraft:end_rod ~{px} ~6 ~{pz} 0.2 5 0.2 0.01 18 force @a[tag=br.playing,distance=..160]")
open(f"{ROOT}/data/oa/function/maps/cave/finale_pillars.mcfunction", 'w', encoding='utf8').write('\n'.join(PL) + '\n')
