#!/usr/bin/env python3
"""試合用ディメンションの固定参照を、マップ番号(#map oa.mapid)ごとの分岐へ展開する。
再実行可能：まず展開済みの行を `in oa:br` / `dimension oa:br` の正準形へ戻し、現在の MAPS で展開し直す。
使い方: python3 -I scripts/multimap_expand.py <repo root>
MAPS を増やして再実行すれば、地下・エンドなどの追加時に全関数へ反映される。"""
import re,sys,glob,os
MAPS=[(0,"oa:br"),(1,"oa:br_nether")]
ALL=["oa:br","oa:br_nether","oa:br_cave","oa:br_end"]
D="|".join(re.escape(x) for x in sorted(ALL,key=len,reverse=True))
IN=re.compile(r'(?<![\w:/.])in oa:br(?=\s|$)')
DIM=re.compile(r'(?<![\w:/.])(if|unless) dimension oa:br(?=\s|$)')
C_IN=re.compile(r'if score #map oa\.mapid matches \d+ in (?:%s)(?=\s|$)'%D)
C_UN=re.compile(r'unless dimension (?:%s)(?: unless dimension (?:%s))+(?=\s|$)'%(D,D))
C_IF=re.compile(r'if dimension (?:%s)(?=\s|$)'%D)
def canon(l):
    l=C_IN.sub('in oa:br',l); l=C_UN.sub('unless dimension oa:br',l)
    l=C_IF.sub('if dimension oa:br',l)
    l=re.sub(r'unless dimension (?:%s)(?=\s|$)'%D,'unless dimension oa:br',l)
    return l
def expand(l):
    has_in=bool(IN.search(l)); dims=DIM.findall(l)
    if not has_in and not dims: return [l]
    if has_in:
        out=[]
        for i,d in MAPS:
            x=IN.sub(f'if score #map oa.mapid matches {i} in {d}',l)
            out.append(x)
        l_list=out
    else: l_list=[l]
    res=[]
    for base in l_list:
        if DIM.search(base):
            un=[m for m in DIM.finditer(base) if m.group(1)=='unless']
            ifs=[m for m in DIM.finditer(base) if m.group(1)=='if']
            # unless: すべてのマップ次元について否定を並べる
            b=DIM.sub(lambda m:(' '.join(f'unless dimension {d}' for _,d in MAPS) if m.group(1)=='unless' else 'IFDIM'),base)
            if 'IFDIM' in b:
                for _,d in MAPS: res.append(b.replace('IFDIM',f'if dimension {d}'))
            else: res.append(b)
        else: res.append(base)
    return res
root=sys.argv[1]
changed=0
for p in glob.glob(root+'/data/oa/function/**/*.mcfunction',recursive=True):
    rel=p[len(root):]
    lines=open(p,encoding='utf8').read().split('\n')
    # 正準化＋連続重複の圧縮（展開で生じた行のみ）
    can=[canon(x) for x in lines]; comp=[]; i=0
    while i<len(lines):
        j=i
        while j+1<len(lines) and can[j+1]==can[i] and can[i]!=lines[i] or (j+1<len(lines) and can[j+1]==can[i] and can[j+1]!=lines[j+1]): j+=1
        comp.append(can[i]); i=j+1
    new=[]
    for l in comp: new+=expand(l)
    if new!=lines:
        open(p,'w',encoding='utf8').write('\n'.join(new)); changed+=1
print("files changed",changed)
