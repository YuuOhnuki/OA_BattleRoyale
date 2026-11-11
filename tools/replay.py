import re,glob,sys,json,numpy as np
from pathlib import Path
# Replays tiles/place/N.mcfunction fills into a voxel grid. Relative origin: ~ = tile anchor (map center x=0,z=0, y=0 = upper plane)
root=Path(sys.argv[1]); out=sys.argv[2]
X0,Z0,W,LOW=-152,-152,305,-20
V=np.zeros((21,W,W),dtype=np.int32)   # palette index, 0 = air
pal=['minecraft:air']; pid={'minecraft:air':0}
def P(s):
    if s not in pid: pid[s]=len(pal); pal.append(s)
    return pid[s]
rx=re.compile(r'^fill (~-?\d+) (~-?\d+) (~-?\d+) (~-?\d+) (~-?\d+) (~-?\d+) (\S+)(?: (\S+))?\s*$')
def n(t): return int(t[1:] or 0)
cnt=0
for i in range(100):
    for l in open(root/f'data/oa/function/map/internal/tiles/place/{i}.mcfunction'):
        if not l.startswith('fill ~'): continue
        m=rx.match(l)
        assert m,(i,l)
        x0,y0,z0,x1,y1,z1=[n(m.group(k)) for k in range(1,7)]
        b=m.group(7); mode=m.group(8)
        assert mode in (None,), (i,l)
        p=P(b)
        xs=slice(min(x0,x1)-X0,max(x0,x1)-X0+1); zs=slice(min(z0,z1)-Z0,max(z0,z1)-Z0+1); ys=slice(min(y0,y1)-LOW,max(y0,y1)-LOW+1)
        V[ys,zs,xs]=p; cnt+=1

wcount=0
for i in range(100):
    for l in open(root/f'data/oa/function/map/internal/tiles/water/{i}.mcfunction'):
        if not l.startswith('fill ~'): continue
        m=rx.match(l); assert m,(i,l)
        x0,y0,z0,x1,y1,z1=[n(m.group(k)) for k in range(1,7)]
        b=m.group(7); assert m.group(8) is None
        p=P(b)
        V[min(y0,y1)-LOW:max(y0,y1)-LOW+1,min(z0,z1)-Z0:max(z0,z1)-Z0+1,min(x0,x1)-X0:max(x0,x1)-X0+1]=p; wcount+=1
print('water fills',wcount)
np.savez_compressed(out,V=V.astype(np.int16),pal=np.array(pal))
print('fills',cnt,'palette',len(pal),'nonair',(V>0).sum())
