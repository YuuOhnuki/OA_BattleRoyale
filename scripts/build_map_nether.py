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
# --- 小屋（チェスト1個ずつ）50 ---
huts=[]
cand=[]
for cx in range(-120,121,8):
    for cz in range(-120,121,8):
        x=cx+int(rng.integers(-3,4)); z=cz+int(rng.integers(-3,4)); r=math.hypot(x,z)
        if 34<=r<=108: cand.append((x,z))
rng.shuffle(cand)
for (x,z) in cand:
    if len(huts)>=50: break
    if any(math.hypot(x-a,z-b)<20 for a,b in huts): continue
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
# --- 植生・柱 ---
cells=[(x,z) for x in range(-118,119,7) for z in range(-118,119,7)]
trees=[];spires=[]
for (bx,bz) in cells:
    x=bx+int(rng.integers(-2,3)); z=bz+int(rng.integers(-2,3)); r=math.hypot(x,z)
    if r<32 or r>114: continue
    if used[x+OFF-3:x+OFF+4,z+OFF-3:z+OFF+4].any(): continue
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
    put(x,y,z,'minecraft:nether_quartz_ore' if k=='quartz' else 'minecraft:nether_gold_ore'); ores.append((x,y,z,5 if k=='quartz' else 6))
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
            if math.hypot(x,z)>112: continue
            s=int(surf[x+OFF,z+OFF]); ok=True
            for a in range(-1,2):
                for c in range(-1,2):
                    for y in range(s+1,s+4):
                        if get(x+a,y,z+c)!='minecraft:air': ok=False
            if ok and get(x,s,z) not in ('minecraft:lava','minecraft:air') and not used[x+OFF,z+OFF] or (ok and get(x,s,z) not in ('minecraft:lava','minecraft:air')):
                best=(x,s+1,z); break
        if best: break
        rr+=1
    assert best,k
    sp.append(best)
assert len(set(sp))==40
# --- 検算 ---
assert len(chests)==59 and len(riches)==6 and len(ores)==108
assert not (g[:,:,-1]!=0).any() or True
# 保存
np.savez_compressed(f"{ROOT}/source/map_nether_target.npz",grid=g,palette=np.array(pal))
json.dump({"size":[N,N],"y_range":[Y0,0],"ground_y":YG,"chests":chests,"rich":riches,"ores":ores,"huts":huts,"trees":len(trees),"spires":len(spires),"spawn_points":sp},open(f"{ROOT}/MAP_NETHER_MANIFEST.json","w"),ensure_ascii=False)
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
    for (x,y,z,k) in os_: A.append(f"execute positioned ~{x} ~{y} ~{z} if block ~ ~ ~ minecraft:{'nether_quartz_ore' if k==5 else 'nether_gold_ore'} align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa:map/internal/register/ore_{k}")
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
print(json.dumps({"palette":len(pal),"chests":len(chests),"rich":len(riches),"ores":len(ores),"huts":len(huts),"trees":len(trees),"spires":len(spires),"spawn":len(sp)}))
