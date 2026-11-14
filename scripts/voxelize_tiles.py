#!/usr/bin/env python3
"""1.9.171: 会場のタイル関数（tiles/place/*.mcfunction と、あれば tiles/water/*.mcfunction）を読み、
会場のブロックをそのまま3Dの配列にする（ロビーの地図パネルを今の会場から描くため）。
使い方: py -3 scripts/voxelize_tiles.py <tiles のフォルダ> <出力 .npz>
出力：V[y, z, x]（パレット番号）、pal（ブロック名）、low（V の y=0 の高さ）。x,z は -152〜152。
fill の replace／keep と setblock を順に再現する（タイルの中の行の順番どおり）。"""
import sys, re, glob, os
import numpy as np

src, out = sys.argv[1], sys.argv[2]
OFF = 152; N = 305
files = []
for sub in ('place', 'water'):
    for p in sorted(glob.glob(f"{src}/{sub}/*.mcfunction"), key=lambda q: int(os.path.basename(q)[:-11])):
        files.append(p)
cmds = []
lo, hi = 10 ** 9, -10 ** 9
FILL = re.compile(r'^fill ~(-?\d+) ~(-?\d+) ~(-?\d+) ~(-?\d+) ~(-?\d+) ~(-?\d+) (\S+)(?: (replace|keep)(?: (\S+))?)?\s*$')
SET = re.compile(r'^setblock ~(-?\d+) ~(-?\d+) ~(-?\d+) (\S+)\s*$')
for p in files:
    for line in open(p, encoding='utf-8'):
        line = line.strip()
        m = FILL.match(line)
        if m:
            a = list(map(int, m.groups()[:6]))
            cmds.append(('f', a, m.group(7), m.group(8), m.group(9)))
            lo = min(lo, a[1], a[4]); hi = max(hi, a[1], a[4]); continue
        m = SET.match(line)
        if m:
            x, y, z = map(int, m.groups()[:3])
            cmds.append(('s', (x, y, z), m.group(4), None, None))
            lo = min(lo, y); hi = max(hi, y)
pal = ['minecraft:air']; pid = {'minecraft:air': 0}
def P(b):
    if b not in pid: pid[b] = len(pal); pal.append(b)
    return pid[b]
NY = hi - lo + 1
V = np.zeros((NY, N, N), np.uint16)
for kind, a, blk, mode, rb in cmds:
    v = P(blk)
    if kind == 's':
        x, y, z = a
        if -OFF <= x <= OFF and -OFF <= z <= OFF: V[y - lo, z + OFF, x + OFF] = v
        continue
    x1, x2 = sorted((a[0], a[3])); y1, y2 = sorted((a[1], a[4])); z1, z2 = sorted((a[2], a[5]))
    x1, x2 = max(x1, -OFF), min(x2, OFF); z1, z2 = max(z1, -OFF), min(z2, OFF)
    if x1 > x2 or z1 > z2: continue
    sl = (slice(y1 - lo, y2 - lo + 1), slice(z1 + OFF, z2 + OFF + 1), slice(x1 + OFF, x2 + OFF + 1))
    if mode == 'replace' and rb:
        sub = V[sl]; sub[sub == P(rb)] = v
    elif mode == 'keep':
        sub = V[sl]; sub[sub == 0] = v
    else:
        V[sl] = v
np.savez_compressed(out, V=V, pal=np.array(pal), low=np.array(lo))
print('voxels', V.shape, 'palette', len(pal), 'y', lo, hi, 'commands', len(cmds))
