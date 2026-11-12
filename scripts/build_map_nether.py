#!/usr/bin/env python3
"""OA Battle Royale 1.9.108: ネザー会場 (oa:br_nether) の生成。
使い方: python3 -I scripts/build_map_nether.py <repo root>
- data/oa/function/maps/nether/tiles/{preload,wait,release,apply,place}/0..99 と maps/nether/post を書き出す
- モデル全体を source/map_nether_target.npz、配置一覧を MAP_NETHER_MANIFEST.json に保存
座標は中心(0,0)基準 x,z∈[-152,152]、y∈[-20,0]（地面の最上面 y=-12、チェストは y=-11）。全ブロックは y<=0。"""
import sys,os,re,glob,json,math
import numpy as np
ROOT=sys.argv[1]; OUT=f"{ROOT}/data/oa/function/maps/nether/tiles"
SRC=f"{ROOT}/data/oa/function/map/internal/tiles"
SEED=20261113; rng=np.random.default_rng(SEED)
N=305; OFF=152; Y0=-20; NY=21; YG=-12
pal=['minecraft:air']; pid={'minecraft:air':0}
def P(b):
    if b not in pid: pid[b]=len(pal); pal.append(b)
    return pid[b]
g=np.zeros((N,N,NY),np.uint16)
def inb(x,z): return -OFF<=x<=OFF and -OFF<=z<=OFF
def put(x,y,z,b):
    if inb(x,z) and Y0<=y<=0: g[x+OFF,z+OFF,y-Y0]=P(b)
def get(x,y,z): return pal[g[x+OFF,z+OFF,y-Y0]] if inb(x,z) and Y0<=y<=0 else 'minecraft:air'
def box(x1,y1,z1,x2,y2,z2,b):
    x1,x2=sorted((max(x1,-OFF),min(x2,OFF))) if False else (max(min(x1,x2),-OFF),min(max(x1,x2),OFF))
    z1,z2=max(min(z1,z2),-OFF),min(max(z1,z2),OFF); y1,y2=max(min(y1,y2),Y0),min(max(y1,y2),0)
    if x1<=x2 and z1<=z2 and y1<=y2: g[x1+OFF:x2+OFF+1,z1+OFF:z2+OFF+1,y1-Y0:y2-Y0+1]=P(b)
def smooth(scale,seed):
    r=np.random.default_rng(seed); k=N//scale+3; a=r.random((k,k))
    xs=np.linspace(0,k-3,N); i=xs.astype(int); f=xs-i
    def lerp2(a):
        t=a[i][:,i]; return t  # placeholder
    A=a[i][:,i]*(1-f)[:,None]*(1-f)[None,:]+a[i+1][:,i]*f[:,None]*(1-f)[None,:]+a[i][:,i+1]*(1-f)[:,None]*f[None,:]+a[i+1][:,i+1]*f[:,None]*f[None,:]
    return A
n1=smooth(40,1)*2-1; n2=smooth(40,2)*2-1; nv=smooth(25,3)
X,Z=np.meshgrid(np.arange(-OFF,OFF+1),np.arange(-OFF,OFF+1),indexing='ij')
R=np.hypot(X,Z); xw=X+14*n1; zw=Z+14*n2
BIO=np.where(xw>0,np.where(zw<0,0,1),np.where(zw>0,2,3))   # 0基部 1ソウル 2真紅 3歪み
hsh=rng.random((N,N))
surf=np.full((N,N),YG,int)
# --- 地形 ---
for xi in range(N):
    for zi in range(N):
        pass
g[:,:,0]=P('minecraft:bedrock')
g[:,:,1:7]=P('minecraft:netherrack')   # y -19..-14
g[:,:,7]=P('minecraft:netherrack')     # y -13（溶岩域で上書き）
def top(b):
    return b
B0=['minecraft:blackstone']*9+['minecraft:basalt']*5+['minecraft:smooth_basalt']*3+['minecraft:magma_block']*1+['minecraft:netherrack']*2
B1=['minecraft:soul_soil']*14+['minecraft:soul_sand']*5+['minecraft:basalt']*1
B2=['minecraft:crimson_nylium']*16+['minecraft:netherrack']*3+['minecraft:nether_wart_block']*1
B3=['minecraft:warped_nylium']*16+['minecraft:netherrack']*3+['minecraft:warped_wart_block']*1
TB=[B0,B1,B2,B3]
valley=(BIO==1)&(R>38)&(R<108)&(nv>0.42)
for xi in range(N):
    for zi in range(N):
        x=xi-OFF; z=zi-OFF; r=R[xi,zi]
        if max(abs(x),abs(z))>=150:
            g[xi,zi,0:9]=P('minecraft:blackstone'); g[xi,zi,0]=P('minecraft:bedrock'); surf[xi,zi]=YG; continue
        if r>=125:
            g[xi,zi,2:8]=P('minecraft:lava')   # y -18..-13
            surf[xi,zi]=-14; continue
        if r>=123:
            g[xi,zi,8]=P('minecraft:blackstone'); surf[xi,zi]=-13; continue
        lst=TB[BIO[xi,zi]]; b=lst[int(hsh[xi,zi]*len(lst))%len(lst)]
        if r>=120: b='minecraft:blackstone' if hsh[xi,zi]<0.8 else 'minecraft:polished_blackstone'
        if valley[xi,zi]:
            g[xi,zi,8]=P(b); g[xi,zi,9]=0 if False else 0; surf[xi,zi]=-13
            g[xi,zi,8]=P(b)  # y=-12 ... overwritten below
            g[xi,zi,8]=P('minecraft:netherrack'); g[xi,zi,7]=P(b); 
        else:
            g[xi,zi,8]=P(b)
# 谷は y=-13 が表面（y=-12 は空気）
for xi,zi in zip(*np.nonzero(valley&(R<123))): g[xi,zi,8]=0
used=np.zeros((N,N),bool)  # 構造物・装飾の占有
def mark(x,z,rad):
    for a in range(x-rad,x+rad+1):
        for b in range(z-rad,z+rad+1):
            if inb(a,b): used[a+OFF,b+OFF]=True
# --- 外周: 柵 ---
FENCE='minecraft:nether_brick_fence'
fence_cells=set()
for xi in range(N):
    for zi in range(N):
        r=R[xi,zi]
        if 121.9<=r<123.3 and max(abs(xi-OFF),abs(zi-OFF))<150: fence_cells.add((xi-OFF,zi-OFF))
for (x,z) in fence_cells: put(x,YG+1,z,FENCE)
used[R>=118]=True
# --- 中央の宝物庫 ---
PB='minecraft:polished_blackstone_bricks'; BB='minecraft:cracked_polished_blackstone_bricks'; CB='minecraft:chiseled_polished_blackstone'; GB='minecraft:gilded_blackstone'; CPB='minecraft:polished_blackstone'
def mixw(x,y,z): return [PB,PB,BB,CPB,PB,BB][(x*5+y*3+z*7)%6]
H=22
for x in range(-H,H+1):
    for z in range(-H,H+1):
        put(x,YG+1,z,PB if (x+z)%2==0 else BB)
        if max(abs(x),abs(z))==H and not (min(abs(x),abs(z))<=2):
            for y in range(YG+2,YG+7): put(x,y,z,CB if y==YG+4 else mixw(x,y,z))
        if max(abs(x),abs(z))==H and min(abs(x),abs(z))<=2:
            put(x,YG+6,z,CB)           # 門のまぐさ
for sx in (-1,1):
    for sz in (-1,1):
        cx,cz=sx*H,sz*H
        for a in range(-2,3):
            for b in range(-2,3):
                if max(abs(a),abs(b))==2:
                    for y in range(YG+2,YG+10): put(cx+a,y,cz+b,CB if y in (YG+5,YG+9) else mixw(cx+a,y,cz+b))
        put(cx,YG+2,cz,'minecraft:lava'); 
        put(cx,YG+2,cz,'minecraft:air')
        for y in range(YG+2,YG+8): put(cx,y,cz,'minecraft:air')
        put(cx,YG+10,cz,'minecraft:lantern[hanging=false]')
# 内室
C=9
for x in range(-C,C+1):
    for z in range(-C,C+1):
        put(x,YG+1,z,GB if (abs(x)+abs(z))%4==0 else (CB if (x+z)%2==0 else PB))
        if max(abs(x),abs(z))==C and min(abs(x),abs(z))>1:
            for y in range(YG+2,YG+8): put(x,y,z,CB if y==YG+5 else mixw(x,y,z))
        if max(abs(x),abs(z))==C and min(abs(x),abs(z))<=1: put(x,YG+7,z,CB)
        if max(abs(x),abs(z))==C and min(abs(x),abs(z))<=1:
            for y in range(YG+8,YG+8): pass
# 溶岩だまり（柵つき）4か所
for sx in (-1,1):
    for sz in (-1,1):
        cx,cz=sx*14,sz*14
        for a in range(-2,3):
            for b in range(-2,3):
                if max(abs(a),abs(b))==2: put(cx+a,YG+2,cz+b,FENCE); fence_cells.add((cx+a,cz+b)) if False else None
                elif max(abs(a),abs(b))<=1:
                    put(cx+a,YG+1,cz+b,'minecraft:lava'); put(cx+a,YG,cz+b,'minecraft:lava')
# 柱
for sx in (-1,1):
    for sz in (-1,1):
        for (px,pz) in ((sx*16,sz*5),(sx*5,sz*16)):
            for y in range(YG+2,YG+7): put(px,y,pz,'minecraft:polished_blackstone' if y<YG+6 else CB)
mark(0,0,26)
used[R<=26]=True
# 柵セルの接続状態を割り当て（段付き：柵は全て y=YG+2 または YG+1 の同一平面で処理）
def fence_pass():
    for y in (YG+1,YG+2):
        cells=[(xi-OFF,zi-OFF) for xi,zi in zip(*np.nonzero(g[:,:,y-Y0]==pid[FENCE]))]
        S=set(cells)
        for (x,z) in cells:
            st=f"[east={'true' if (x+1,z) in S else 'false'},north={'true' if (x,z-1) in S else 'false'},south={'true' if (x,z+1) in S else 'false'},west={'true' if (x-1,z) in S else 'false'}]"
            put(x,y,z,FENCE+st)
chests=[];riches=[];ores=[]
CHEST=lambda f:f'minecraft:chest[facing={f},type=single,waterlogged=false]'
for (cx,cz) in [(-6,-6),(6,-6),(-6,6),(6,6),(0,-6),(0,6)]:
    put(cx,YG+2,cz,CHEST('south' if cz<=0 else 'north')); riches.append((cx,YG+2,cz))
for (cx,cz) in [(-17,-17),(17,-17),(-17,17),(17,17),(0,-17),(0,17),(-17,0),(17,0),(0,0)]:
    put(cx,YG+2,cz,CHEST('south' if cz<=0 else 'north')); chests.append((cx,YG+2,cz))
# --- 1.9.111: 大要塞（約61×61＝マップ幅の約1/5）。小屋・植生・鉱石・開始地点はここを避ける ---
# 高さは外壁4（胸壁5）・隅の塔5まで。階段・屋根なし。溶岩なし。チェスト 通常8＋上位2 を内部に置く。
FX,FZ,FH=-72,0,30
FB=['minecraft:nether_bricks','minecraft:red_nether_bricks','minecraft:cracked_nether_bricks','minecraft:polished_blackstone_bricks','minecraft:nether_bricks']
def fmat(x,y,z): return FB[(x*7+y*3+z*5)%len(FB)]
def in_fort(x,z,m=0): return FX-FH-m<=x<=FX+FH+m and FZ-FH-m<=z<=FZ+FH+m
_sl=surf[FX+OFF-FH-2:FX+OFF+FH+3,FZ+OFF-FH-2:FZ+OFF+FH+3]
assert (_sl==YG).all() and max(math.hypot(a,b) for a in (FX-FH,FX+FH) for b in (FZ-FH,FZ+FH))<110
def fput(a,y,c,b): put(FX+a,y,FZ+c,b)
for a in range(-FH,FH+1):
    for c in range(-FH,FH+1):
        fput(a,YG,c,'minecraft:polished_blackstone' if (abs(a)<=2 or abs(c)<=2) else fmat(a,YG,c))
        e=max(abs(a),abs(c))
        if e==FH:
            gate=min(abs(a),abs(c))<=2
            for y in range(YG+1,YG+5):
                if gate and y<=YG+3: continue
                fput(a,y,c,'minecraft:chiseled_polished_blackstone' if gate else fmat(a,y,c))
            if not gate and (a+c)%2==0: fput(a,YG+5,c,fmat(a,YG+5,c))
# 隅の塔（内部に通常チェスト1、出入口は内側向き）
fchests=[];frich=[]
CH=lambda f:f'minecraft:chest[facing={f},type=single,waterlogged=false]'
for sx in (-1,1):
    for sz in (-1,1):
        cx,cz=sx*26,sz*26
        for a in range(-3,4):
            for c in range(-3,4):
                if max(abs(a),abs(c))!=3: fput(cx+a,YG,cz+c,'minecraft:polished_blackstone'); continue
                inner=(a==-3*sx and abs(c)<=0) or (c==-3*sz and abs(a)<=0)
                for y in range(YG+1,YG+6):
                    if inner and y<=YG+2: continue
                    fput(cx+a,y,cz+c,fmat(cx+a,y,cz+c))
        fput(cx,YG+1,cz,CH('east' if sx<0 else 'west')); fchests.append((FX+cx,YG+1,FZ+cz))
# 中央の城（21×21、壁高4、四方に幅3の出入口、上位チェスト2）
for a in range(-10,11):
    for c in range(-10,11):
        fput(a,YG,c,'minecraft:gilded_blackstone' if (abs(a)+abs(c))%5==0 else ('minecraft:chiseled_polished_blackstone' if (a+c)%2==0 else 'minecraft:polished_blackstone_bricks'))
        if max(abs(a),abs(c))==10:
            gate=min(abs(a),abs(c))<=1
            for y in range(YG+1,YG+(6 if (abs(a)==10 and abs(c)==10) else 5)):
                if gate and y<=YG+3: continue
                fput(a,y,c,fmat(a,y,c))
for (a,c) in ((-5,-5),(5,-5),(-5,5),(5,5)):
    for y in range(YG+1,YG+4): fput(a,y,c,'minecraft:polished_blackstone_bricks')
for (a,c,f) in ((-7,0,'east'),(7,0,'west')):
    fput(a,YG+1,c,CH(f)); frich.append((FX+a,YG+1,FZ+c))
# 四隅の小さな東屋（屋根なしの廃墟、通常チェスト1）
for sx in (-1,1):
    for sz in (-1,1):
        cx,cz=sx*18,sz*18
        for a in range(-3,4):
            for c in range(-3,4):
                if max(abs(a),abs(c))!=3: continue
                door=(a==-3*sx and c==0) or (c==-3*sz and a==0)
                for y in range(YG+1,YG+4):
                    if door and y<=YG+2: continue
                    if y==YG+3 and (a+c)%2==0: continue
                    fput(cx+a,y,cz+c,fmat(cx+a,y,cz+c))
        fput(cx,YG+1,cz,CH('south' if sz<0 else 'north')); fchests.append((FX+cx,YG+1,FZ+cz))
# 中庭の障害物：崩れた低い壁と柱
_fr=np.random.default_rng(SEED+11)
for _ in range(40):
    a=int(_fr.integers(-25,26)); c=int(_fr.integers(-25,26)); ln=int(_fr.integers(3,6)); ax=int(_fr.integers(0,2)); h=int(_fr.integers(2,4))
    if abs(a)<=13 and abs(c)<=13: continue            # 城の周りは空ける
    if abs(a)<=4 or abs(c)<=4: continue               # 十字の参道は空ける
    if (abs(a)>=14 and abs(c)>=14 and abs(a)<=21 and abs(c)<=21) or (abs(a)>=22 and abs(c)>=22): continue
    for i in range(ln):
        for y in range(YG+1,YG+1+h): fput(a+(i if ax==0 else 0),y,c+(i if ax==1 else 0),fmat(a+i,y,c))
for a in range(-24,25,6):
    for c in range(-24,25,6):
        if abs(a)<=4 or abs(c)<=4 or max(abs(a),abs(c))<=12 or (abs(a)>=14 and abs(c)>=14): continue
        for y in range(YG+1,YG+5): fput(a,y,c,'minecraft:polished_blackstone' if y<YG+4 else 'minecraft:chiseled_polished_blackstone')
for a in range(-FH-2,FH+3):
    for c in range(-FH-2,FH+3): pass
mark(FX,FZ,FH+2)
for (x,y,z) in fchests: chests.append((x,y,z))
for (x,y,z) in frich: riches.append((x,y,z))
# --- 小屋（チェスト1個ずつ）50 ---
huts=[]
cand=[]
for cx in range(-120,121,8):
    for cz in range(-120,121,8):
        x=cx+int(rng.integers(-3,4)); z=cz+int(rng.integers(-3,4)); r=math.hypot(x,z)
        if 34<=r<=108 and max(abs(x),abs(z))>=33 and not in_fort(x,z,8): cand.append((x,z))
rng.shuffle(cand)
for (x,z) in cand:
    if len(huts)>=50: break
    if any(math.hypot(x-a,z-b)<18 for a,b in huts): continue
    huts.append((x,z))
assert len(huts)==50,len(huts)
for (x,z) in huts:
    mark(x,z,5)
    r=math.hypot(x,z); dx,dz=(-x/r,-z/r)
    side=('x',1 if dx>0 else -1) if abs(dx)>abs(dz) else ('z',1 if dz>0 else -1)
    for a in range(-2,3):
        for b in range(-2,3):
            put(x+a,YG,z+b,'minecraft:polished_blackstone')
            if max(abs(a),abs(b))==2:
                door=(side[0]=='x' and a==2*side[1] and b==0) or (side[0]=='z' and b==2*side[1] and a==0)
                for y in range(YG+1,YG+4):
                    if door and y<=YG+2: continue
                    if y==YG+3 and rng.random()<0.3: continue
                    put(x+a,y,z+b,mixw(x+a,y,z+b))
            else:
                put(x+a,YG+1,z+b,'minecraft:air')
    put(x,YG+1,z,CHEST('south' if side[0]=='z' and side[1]>0 else ('north' if side[0]=='z' else ('east' if side[1]>0 else 'west')).replace('east','west') if False else 'south'))
    chests.append((x,YG+1,z))
# --- 1.9.111: 建築物・障害物の追加（既存の配置を変えないよう別の乱数列を使う） ---
# 配置順: 小屋の後・植生/鉱石の前（植生と鉱石が避ける）。
# 方針: 高さは最大5。内部に階段や足場を作らず、ぴちぴち等で登って一方的に有利になる場所を作らない。
# 建築物どうし・既存構造物との間は5ブロック以上あけ、通路を確保する。チェスト・鉱石の数は変えない。
rng2=np.random.default_rng(SEED+7)
RB='minecraft:red_nether_bricks'; NBk='minecraft:nether_bricks'; CNB='minecraft:cracked_nether_bricks'
def mat(x,y,z,b):
    L={2:[RB,NBk,CNB,PB,NBk],3:[NBk,CNB,PB,BB,NBk],1:[PB,BB,CPB,NBk,PB]}.get(b,[PB,BB,CPB,PB,BB,CNB])
    return L[(x*7+y*3+z*5)%len(L)]
spu=np.zeros((N,N),bool)   # 建築物どうしの間隔用（植生には影響しない）
def smark(x,z,rad):
    spu[x+OFF-rad:x+OFF+rad+1,z+OFF-rad:z+OFF+rad+1]=True
OKG=[0]+[pid[k] for k in ('minecraft:crimson_roots','minecraft:warped_roots') if k in pid]
def free(x,z,rad):
    r=math.hypot(x,z)
    if r<38 or r>108: return False
    xa,xb,za,zb=x+OFF-rad,x+OFF+rad+1,z+OFF-rad,z+OFF+rad+1
    if used[xa:xb,za:zb].any() or spu[xa:xb,za:zb].any() or (surf[xa:xb,za:zb]!=YG).any() or (~np.isin(g[xa:xb,za:zb,YG+1-Y0],OKG)).any(): return False
    return True
def place_many(count,half,builder,tries=40000,margin=2):
    n=0;t=0;rad=half+margin
    while n<count and t<tries:
        t+=1
        x=int(rng2.integers(-108,109)); z=int(rng2.integers(-108,109))
        if not free(x,z,rad): continue
        builder(x,z); smark(x,z,rad); mark(x,z,half); n+=1
    print('placed',builder.__name__,n,'/',count)
    assert n>=count,(builder.__name__,n,count)
    return n
def bastion(x,z):
    b=int(BIO[x+OFF,z+OFF]); Hh=6; doors=set(int(v) for v in rng2.permutation(4)[:2])
    for a in range(-Hh,Hh+1):
        for c in range(-Hh,Hh+1):
            put(x+a,YG,z+c,mat(x+a,YG,z+c,b) if (a+c)%2==0 else NBk)
            if max(abs(a),abs(c))!=Hh: continue
            door=(0 in doors and a==Hh and abs(c)<=1) or (1 in doors and a==-Hh and abs(c)<=1) or (2 in doors and c==Hh and abs(a)<=1) or (3 in doors and c==-Hh and abs(a)<=1)
            corner=abs(a)==Hh and abs(c)==Hh
            for y in range(YG+1,YG+(6 if corner else 5)):
                if door and y<=YG+3: continue
                if not corner and y>=YG+3 and rng2.random()<0.25: continue
                if not corner and y==YG+2 and not door and rng2.random()<0.06: continue
                put(x+a,y,z+c,CB if (corner and y==YG+5) else mat(x+a,y,z+c,b))
    for (a,c) in ((-3,-3),(3,-3),(-3,3),(3,3)):
        for y in range(YG+1,YG+4): put(x+a,y,z+c,mat(x+a,y,z+c,b))
    put(x,YG+1,z,GB)
    put(x,YG+1,z+2,CHEST('north')); riches.append((x,YG+1,z+2))   # 1.9.113: 砦に上位1＋通常1
    put(x,YG+1,z-2,CHEST('south')); chests.append((x,YG+1,z-2))
def tower(x,z):
    b=int(BIO[x+OFF,z+OFF]); door=int(rng2.integers(0,4))
    put(x,YG+1,z,CHEST('south')); chests.append((x,YG+1,z))   # 1.9.113: 見張り塔に通常1
    for a in range(-2,3):
        for c in range(-2,3):
            put(x+a,YG,z+c,PB)
            if max(abs(a),abs(c))!=2: continue
            isdoor=(door==0 and a==2 and c==0) or (door==1 and a==-2 and c==0) or (door==2 and c==2 and a==0) or (door==3 and c==-2 and a==0)
            window=(a==0 or c==0) and not isdoor
            for y in range(YG+1,YG+6):
                if isdoor and y<=YG+2: continue
                if window and y==YG+3: continue
                if y==YG+5 and rng2.random()<0.5: continue
                if y==YG+4 and rng2.random()<0.2: continue
                put(x+a,y,z+c,CB if y==YG+4 else mat(x+a,y,z+c,b))
def wallseg(count):
    n=0;t=0
    while n<count and t<6000:
        t+=1
        x=int(rng2.integers(-108,109)); z=int(rng2.integers(-108,109)); L=int(rng2.integers(9,18)); ax=int(rng2.integers(0,2))
        pts=[(x+(i if ax==0 else 0),z+(i if ax==1 else 0)) for i in range(L)]
        if not all(free(px,pz,2) for px,pz in pts[::3]+[pts[-1]]): continue
        b=int(BIO[x+OFF,z+OFF])
        for i,(px,pz) in enumerate(pts):
            if rng2.random()<0.1 and 0<i<L-1: continue
            h=int(rng2.integers(2,4)) if i%4 else 3
            for y in range(YG+1,YG+1+h): put(px,y,pz,mat(px,y,pz,b))
        for px,pz in pts[::3]+[pts[-1]]: smark(px,pz,2); mark(px,pz,0)
        n+=1
    print('placed wallseg',n,'/',count)
    assert n>=count,('wallseg',n)
    return n
def arch(x,z):
    b=int(BIO[x+OFF,z+OFF]); ax=int(rng2.integers(0,2))
    for a in range(-3,4):
        px,pz=(x+a,z) if ax==0 else (x,z+a)
        if abs(a)==3:
            for y in range(YG+1,YG+6): put(px,y,pz,CB if y==YG+5 else mat(px,y,pz,b))
        elif rng2.random()<0.88: put(px,YG+5,pz,mat(px,YG+5,pz,b))
def boulder(x,z):
    b=int(BIO[x+OFF,z+OFF]); Lm=['minecraft:blackstone','minecraft:basalt','minecraft:smooth_basalt','minecraft:netherrack'] if b!=1 else ['minecraft:basalt','minecraft:blackstone','minecraft:soul_soil']
    for _ in range(int(rng2.integers(4,8))):
        ox=int(rng2.integers(-1,2)); oz=int(rng2.integers(-1,2)); rr=int(rng2.integers(1,3)); h=int(rng2.integers(1,4))
        for a in range(-rr,rr+1):
            for c in range(-rr,rr+1):
                if a*a+c*c>rr*rr+1: continue
                for y in range(YG+1,YG+1+h): put(x+ox+a,y,z+oz+c,Lm[int(rng2.integers(0,len(Lm)))])
EXTRA={'bastions':place_many(8,6,bastion),'towers':place_many(14,2,tower),'walls':wallseg(28),'arches':place_many(14,3,arch),'boulders':place_many(40,3,boulder,margin=1)}
# --- 植生・柱 ---
cells=[(x,z) for x in range(-118,119,7) for z in range(-118,119,7)]
trees=[];spires=[]
for (bx,bz) in cells:
    x=bx+int(rng.integers(-2,3)); z=bz+int(rng.integers(-2,3)); r=math.hypot(x,z)
    if r<32 or r>114: continue
    if used[x+OFF-2:x+OFF+3,z+OFF-2:z+OFF+3].any(): continue
    b=int(BIO[x+OFF,z+OFF]); s=int(surf[x+OFF,z+OFF])
    if rng.random()<0.45: continue
    if b in (2,3):
        h=int(rng.integers(5,8)) if rng.random()<0.85 else 9
        stem='minecraft:crimson_stem' if b==2 else 'minecraft:warped_stem'
        wart='minecraft:nether_wart_block' if b==2 else 'minecraft:warped_wart_block'
        for y in range(s+1,s+h+1): put(x,y,z,stem)
        yt=s+h
        for a in range(-2,3):
            for c in range(-2,3):
                if abs(a)==2 and abs(c)==2: continue
                if (a,c)!=(0,0): put(x+a,yt-1,z+c,wart) if max(abs(a),abs(c))<=2 and (abs(a)+abs(c))>=1 else None
                put(x+a,yt,z+c,wart)
        for a in range(-1,2):
            for c in range(-1,2): put(x+a,yt+1,z+c,wart)
        for _ in range(2):
            a=int(rng.integers(-1,2)); c=int(rng.integers(-1,2))
            if (a,c)!=(0,0): put(x+a,yt-1,z+c,'minecraft:shroomlight')
        mark(x,z,3); trees.append((x,z,h))
    elif b==0:
        h=int(rng.integers(4,10)); big=rng.random()<0.12
        if big: h=11
        sz=2 if big else 1
        for a in range(sz):
            for c in range(sz):
                for y in range(s+1,s+h+1): put(x+a,y,z+c,'minecraft:basalt' if y<s+h else 'minecraft:polished_basalt')
        mark(x,z,3); spires.append((x,z,h))
    elif b==1:
        if rng.random()<0.5:
            h=int(rng.integers(2,4))
            for y in range(s+1,s+h+1): put(x,y,z,'minecraft:bone_block[axis=y]')
        else:
            for y in range(s+1,s+3): put(x,y,z,FENCE)
            put(x,s+3,z,'minecraft:soul_lantern[hanging=false]')
            fence_cells.add((x,z))
        mark(x,z,3)
# 草（根・菌）
for xi in range(N):
    for zi in range(N):
        x=xi-OFF; z=zi-OFF
        if used[xi,zi] or R[xi,zi]<30 or R[xi,zi]>118: continue
        if hsh[xi,zi]>0.965 and surf[xi,zi]==YG and g[xi,zi,YG+1-Y0+0]==0 if False else (hsh[xi,zi]>0.96 and get(x,YG+1,z)=='minecraft:air' and surf[xi,zi]==YG):
            b=int(BIO[xi,zi])
            if b==2: put(x,YG+1,z,'minecraft:crimson_roots')
            elif b==3: put(x,YG+1,z,'minecraft:warped_roots')
# --- 鉱石 108（クォーツ54／金54） ---
oc=[]
while len(oc)<108:
    x=int(rng.integers(-115,116)); z=int(rng.integers(-115,116)); r=math.hypot(x,z)
    if r<30 or r>114 or used[x+OFF,z+OFF]: continue
    if any(math.hypot(x-a,z-b)<7 for a,b,_ in oc): continue
    if get(x,int(surf[x+OFF,z+OFF])+1,z)!='minecraft:air': continue
    oc.append((x,z,'quartz' if len(oc)%2==0 else 'gold'))
for (x,z,k) in oc:
    y=int(surf[x+OFF,z+OFF])+1
    put(x,y,z,'minecraft:coal_ore' if k=='quartz' else 'minecraft:redstone_ore'); ores.append((x,y,z,1 if k=='quartz' else 3))   # 1.9.114: 地上と同じ石炭(1)とレッドストーン(3)
# 柵セルの再収集（ランタン柱など）と接続計算
for xi,zi in zip(*np.nonzero(g[:,:,YG+2-Y0]==pid[FENCE])): pass
fence_pass()
# --- 開始地点 ---
sp=[]
for k in range(40):
    ang=2*math.pi*k/40; rr=[66,84,100][k%3]
    best=None
    for dr in range(0,12):
        for da in (0,0.02,-0.02,0.04,-0.04):
            x=int(round(rr*math.cos(ang+da)))+0; z=int(round(rr*math.sin(ang+da)))
            if math.hypot(x,z)>112 or in_fort(x,z,2): continue
            s=int(surf[x+OFF,z+OFF]); ok=True
            for a in range(-1,2):
                for c in range(-1,2):
                    for y in range(s+1,s+4):
                        if get(x+a,y,z+c)!='minecraft:air': ok=False
            if ok and get(x,s,z) not in ('minecraft:lava','minecraft:air') and not used[x+OFF,z+OFF] or (ok and get(x,s,z) not in ('minecraft:lava','minecraft:air')):
                best=(x,s+1,z); break
        if best: break
        rr+=1
    if not best:   # 大要塞の前などで見つからない場合は、角度を大きくずらして探す
        for da in (0.1,-0.1,0.2,-0.2,0.3,-0.3,0.4,-0.4):
            for rr2 in (70,86,100,60):
                x=int(round(rr2*math.cos(ang+da))); z=int(round(rr2*math.sin(ang+da)))
                if math.hypot(x,z)>112 or in_fort(x,z,2): continue
                s=int(surf[x+OFF,z+OFF])
                if all(get(x+a,y,z+c)=='minecraft:air' for a in range(-1,2) for c in range(-1,2) for y in range(s+1,s+4)) and get(x,s,z) not in ('minecraft:lava','minecraft:air') and (x,s+1,z) not in sp:
                    best=(x,s+1,z); break
            if best: break
    assert best,k
    sp.append(best)
assert len(set(sp))==40
# --- 到達性の検算（歩いて行けるか） ---
from collections import deque
SOLID=lambda b: b not in ('minecraft:air','minecraft:lava') and 'roots' not in b and 'lantern' not in b
BASE_OK=lambda b: SOLID(b) and 'fence' not in b
sol=np.zeros((N,N,NY),bool); base=np.zeros((N,N,NY),bool)
for i,b in enumerate(pal): sol[g==i]=SOLID(b); base[g==i]=BASE_OK(b)
def stand(xi,zi):
    for y in (YG+1,YG,YG-1):
        yi=y-Y0
        if base[xi,zi,yi] and not sol[xi,zi,yi+1] and not sol[xi,zi,yi+2] and g[xi,zi,yi+1]!=pid.get('minecraft:lava',-1): return y
    return None
st={}
for xi in range(N):
    for zi in range(N):
        v=stand(xi,zi)
        if v is not None: st[(xi,zi)]=v
start=min(st,key=lambda k:(k[0]-OFF-40)**2+(k[1]-OFF)**2); seen={start}; q=deque([start])
while q:
    cx,cz=q.popleft()
    for dx,dz in ((1,0),(-1,0),(0,1),(0,-1)):
        k=(cx+dx,cz+dz)
        if k in st and k not in seen and abs(st[k]-st[(cx,cz)])<=1: seen.add(k); q.append(k)
def reach(x,z): return any(((x+OFF+dx,z+OFF+dz) in seen) for dx,dz in ((0,0),(1,0),(-1,0),(0,1),(0,-1)))
bad_sp=[p for p in sp if (p[0]+OFF,p[2]+OFF) not in seen]
bad_ch=[c for c in chests+riches if not reach(c[0],c[2])]
bad_or=[o for o in ores if not reach(o[0],o[2])]
maxr=max(math.hypot(a-OFF,b-OFF) for a,b in seen)
print("reach",len(seen),"max_r",round(maxr,1),"bad spawn/chest/ore",len(bad_sp),len(bad_ch),len(bad_or))
print("bad_ch",bad_ch,"bad_sp",bad_sp)
assert not bad_sp and not bad_ch and not bad_or and maxr<123
# --- 検算 ---
assert len(chests)==89 and len(riches)==16 and len(ores)==108
assert not (g[:,:,-1]!=0).any() or True
# 保存
np.savez_compressed(f"{ROOT}/source/map_nether_target.npz",grid=g,palette=np.array(pal))
json.dump({"size":[N,N],"y_range":[Y0,0],"ground_y":YG,"chests":chests,"rich":riches,"ores":ores,"huts":huts,"fortress":[FX,FZ,FH],"extras":EXTRA,"trees":len(trees),"spires":len(spires),"spawn_points":sp},open(f"{ROOT}/MAP_NETHER_MANIFEST.json","w"),ensure_ascii=False)
# --- 関数出力 ---
os.makedirs(OUT,exist_ok=True)
for d in ('preload','wait','release','apply','place'): os.makedirs(f"{OUT}/{d}",exist_ok=True)
rects={}
for p in glob.glob(SRC+'/preload/*.mcfunction'):
    n=int(os.path.basename(p)[:-11]); s=open(p,encoding='utf8').read()
    m=re.search(r'forceload add ~(-?\d+) ~(-?\d+) ~(-?\d+) ~(-?\d+)',s); rects[n]=tuple(map(int,m.groups()))
    for d in ('preload','wait','release'):
        t=open(f"{SRC}/{d}/{n}.mcfunction",encoding='utf8').read().replace('oa:map/internal/tiles/','oa:maps/nether/tiles/')
        open(f"{OUT}/{d}/{n}.mcfunction",'w',encoding='utf8').write(t)
assert len(rects)==100
def boxes(sub,x1,z1):
    """sub[x,z,y] → 行程の貪欲マージ → 直方体リスト"""
    nx,nz,ny=sub.shape; out=[]
    for y in range(ny):
        layer=sub[:,:,y]; open_={}  # key(x1,x2,id)->(z1,z2)
        rows=[]
        for z in range(nz):
            runs=[]; x=0
            while x<nx:
                v=layer[x,z]
                if v==0: x+=1; continue
                x2=x
                while x2+1<nx and layer[x2+1,z]==v: x2+=1
                runs.append((x,x2,int(v))); x=x2+1
            rows.append(runs)
        cur={}
        for z in range(nz+1):
            now=set(rows[z]) if z<nz else set()
            for key in list(cur):
                if key not in now:
                    out.append((key[0],cur[key],key[1],y,z-1,key[2])); del cur[key]
            for key in now:
                if key not in cur: cur[key]=z
        # rects→(x1,z1,x2,z2,y,id) 後で y 方向マージ
    return out
def tile_cmds(n):
    x1,z1,x2,z2=rects[n]
    sub=g[x1+OFF:x2+OFF+1,z1+OFF:z2+OFF+1,:]
    nx,nz,ny=sub.shape
    rects_y={}
    for y in range(ny):
        layer=sub[:,:,y]; rows=[]
        for z in range(nz):
            runs=[];x=0
            while x<nx:
                v=layer[x,z]
                if v==0: x+=1; continue
                x2_=x
                while x2_+1<nx and layer[x2_+1,z]==v: x2_+=1
                runs.append((x,x2_,int(v))); x=x2_+1
            rows.append(runs)
        cur={}
        for z in range(nz+1):
            now=set(rows[z]) if z<nz else set()
            for key in list(cur):
                if key not in now:
                    rects_y.setdefault((key[0],cur[key],key[1],z-1,key[2]),[]).append(y); del cur[key]
            for key in now:
                if key not in cur: cur[key]=z
    lines=['scoreboard players set #stage oa.map2 1',f"fill ~{x1} ~{Y0} ~{z1} ~{x2} ~0 ~{z2} minecraft:air"]
    for (a,za,b,zb,v),ys in rects_y.items():
        ys.sort(); s=ys[0]; prev=ys[0]
        for yy in ys[1:]+[None]:
            if yy is not None and yy==prev+1: prev=yy; continue
            X1,X2=x1+a,x1+b; Z1,Z2=z1+za,z1+zb; Y1,Y2=Y0+s,Y0+prev
            bl=pal[v]
            if (X2-X1+1)*(Z2-Z1+1)*(Y2-Y1+1)==1: lines.append(f"setblock ~{X1} ~{Y1} ~{Z1} {bl}")
            else:
                vol=(X2-X1+1)*(Z2-Z1+1)*(Y2-Y1+1)
                assert vol<=32768
                lines.append(f"fill ~{X1} ~{Y1} ~{Z1} ~{X2} ~{Y2} ~{Z2} {bl}")
            if yy is not None: s=prev=yy
    return lines
def inrect(r,x,z): return r[0]<=x<=r[2] and r[1]<=z<=r[3]
total_lines=0
for n in range(100):
    r=rects[n]; x1,z1,x2,z2=r
    open(f"{OUT}/place/{n}.mcfunction",'w',encoding='utf8').write('\n'.join(tile_cmds(n))+'\n'); total_lines+=0
    cs=[c for c in chests if inrect(r,c[0],c[2])]; rs=[c for c in riches if inrect(r,c[0],c[2])]; os_=[o for o in ores if inrect(r,o[0],o[2])]
    A=[]
    A.append(f"execute if score #mode oa.map2 matches 0 run function oa:maps/nether/tiles/place/{n}")
    A.append("execute if score #state oa.map2 matches 2 run return 0")
    A.append(f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:marker,tag=br.chest,dx={x2-x1},dy=20,dz={z2-z1}]")
    A.append(f"execute positioned ~{x1} ~{Y0} ~{z1} run kill @e[type=minecraft:marker,tag=br.ore,dx={x2-x1},dy=20,dz={z2-z1}]")
    A+=["scoreboard players set #stage oa.map2 2",f"scoreboard players set #expectedc oa.map2 {len(cs)+len(rs)}",f"scoreboard players set #expectedo oa.map2 {len(os_)}","scoreboard players set #localc oa.map2 0","scoreboard players set #localo oa.map2 0"]
    for (x,y,z,k) in os_: A.append(f"execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:{'coal_ore' if k==1 else 'redstone_ore'} align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_{k}")
    for (x,y,z) in rs: A.append(f"execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest_rich")
    for (x,y,z) in cs: A.append(f"execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/chest")
    for (x,y,z) in rs: A.append(f"execute if score #mode oa.map2 matches 0 positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_site")
    for (x,y,z) in cs: A.append(f"execute if score #mode oa.map2 matches 0 positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic")
    A+=[f"execute unless score #localc oa.map2 matches {len(cs)+len(rs)} run return run function oa:map/internal/job/failed",
        f"execute unless score #localo oa.map2 matches {len(os_)} run return run function oa:map/internal/job/failed",
        "scoreboard players operation #chests oa.map2 += #localc oa.map2","scoreboard players operation #ores oa.map2 += #localo oa.map2",
        f"function oa:maps/nether/tiles/release/{n}","scoreboard players add #tile oa.map2 1",
        "execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2",
        "execute if score #tile oa.map2 matches 100.. run return run function oa:map/internal/job/finish",
        "schedule function oa:map/internal/job/next 1t replace"]
    open(f"{OUT}/apply/{n}.mcfunction",'w',encoding='utf8').write('\n'.join(A)+'\n')
pts=",".join(f"{{x:{x}.5d,y:{y+80}.0d,z:{z}.5d}}" for x,y,z in sp)
open(f"{ROOT}/data/oa/function/maps/nether/post.mcfunction",'w',encoding='utf8').write(
 f"# ネザー会場の生成完了後に呼ばれる（開始地点の登録）\ndata modify storage oa:spawn_points dim set value \"oa:br_nether\"\ndata modify storage oa:spawn_points points set value [{pts}]\ntellraw @a[tag=br.admin] {{text:\"ネザー会場の開始地点を40か所登録しました。\",color:\"green\"}}\n")
print(json.dumps({"extras":EXTRA,"palette":len(pal),"chests":len(chests),"rich":len(riches),"ores":len(ores),"huts":len(huts),"trees":len(trees),"spires":len(spires),"spawn":len(sp)}))
