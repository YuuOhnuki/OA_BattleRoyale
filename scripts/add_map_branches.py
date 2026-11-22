#!/usr/bin/env python3
"""OA Battle Royale 1.9.230: マップごとの分岐に、天空島（id 3, oa:br_sky）と異界（id 4, oa:br_end）を足す。
洞窟（id 2, oa:br_cave）の行を手本に機械的に足す（1.9.167 で洞窟を足したときと同じやり方。HANDOFF 参照）。
使い方: py -3 scripts/add_map_branches.py <repo root> [--apply]   （--apply なしなら変更点を表示するだけ）
二度実行しても重ならない（すでに足した行があれば飛ばす）。
足さない（手で直す）もの：#map oa.mapid matches 2 だけで次元を見ない行（洞窟だけの動き：補給の吊り下ろし・落盤など）、
生成物（maps/*/tiles、disaster の生成物＝scripts/gen_disasters.py で作り直す、実績）。
"""
import sys, os, re, glob
ROOT = sys.argv[1]; APPLY = '--apply' in sys.argv
NEW = [('3', 'sky'), ('4', 'end')]
SKIP_DIRS = ('/maps/', '/ach/')
# 洞窟だけの動き（天井が低いので小さく、など）は手本にしない
MANUAL = ('tayayuyu/giant_all.mcfunction',)
GEN = ('disaster/announce.mcfunction', 'disaster/bar.mcfunction', 'disaster/available.mcfunction', 'disaster/stop/', 'disaster/admin/list.mcfunction',
       'disaster/cfg_defaults.mcfunction')

def variants(line, num, key):
    s = line.replace('#map oa.mapid matches 2 in oa:br_cave', f'#map oa.mapid matches {num} in oa:br_{key}')
    s = s.replace('oa:br_cave', f'oa:br_{key}').replace('oa:maps/cave/', f'oa:maps/{key}/')
    s = s.replace('#map oa.mapid matches 2 ', f'#map oa.mapid matches {num} ')
    s = re.sub(r'(scoreboard players set #map oa\.mapid) 2$', rf'\g<1> {num}', s)
    return s

changed = {}
for p in glob.glob(f"{ROOT}/data/oa/function/**/*.mcfunction", recursive=True):
    rel = p.replace('\\', '/').split('/data/oa/function/')[1]
    if any(d in '/' + rel for d in SKIP_DIRS) or any(rel.startswith(g) for g in GEN) or rel in MANUAL: continue
    src = open(p, encoding='utf-8').read()
    if 'br_cave' not in src: continue
    out = []; lines = src.split('\n'); i = 0; mod = False
    for line in lines:
        # (b) 「BRのディメンションでないなら」の並び：sky・end も足す
        if 'unless dimension oa:br_cave' in line and 'unless dimension oa:br_sky' not in line and '#map oa.mapid matches 2 unless dimension oa:br_cave' not in line:
            line = line.replace('unless dimension oa:br_cave', 'unless dimension oa:br_cave unless dimension oa:br_sky unless dimension oa:br_end'); mod = True
        if 'value{dim:"oa:br_cave"}' in line and 'unless data storage' in line and 'oa:br_sky' not in line:
            line = re.sub(r'(unless data storage oa:position value\{dim:"oa:br_cave"\})',
                          r'\1 unless data storage oa:position value{dim:"oa:br_sky"} unless data storage oa:position value{dim:"oa:br_end"}', line); mod = True
        out.append(line)
        dup = False
        if 'br_cave' in line and not line.lstrip().startswith('#') and 'maps/cave/finale' not in line:
            if '#map oa.mapid matches 2 in oa:br_cave' in line: dup = True
            elif re.search(r'(^|\s|\$)execute in oa:br_cave ', line) or line.startswith('$execute in oa:br_cave '): dup = True
            elif re.search(r'(?<!unless )if dimension oa:br_cave', line): dup = True
            elif re.search(r'\{dim:"oa:br_cave"\}', line) and 'unless data storage oa:position' not in line: dup = True
            elif 'in oa:br_cave' in line and 'matches 2' not in line: dup = True
        if dup:
            for num, key in NEW:
                v = variants(line, num, key)
                if v != line and v not in lines: out.append(v); mod = True
    if mod:
        changed[rel] = (src, '\n'.join(out))
for rel, (a, b) in sorted(changed.items()):
    al = a.split('\n'); bl = b.split('\n')
    print(f"== {rel}  (+{len(bl) - len(al)})")
    for l in bl:
        if l not in al: print('   +', l[:200])
if APPLY:
    for rel, (a, b) in changed.items():
        open(f"{ROOT}/data/oa/function/{rel}", 'w', encoding='utf-8', newline='\n').write(b)
    print('applied', len(changed))
