"""Offline generation checks. Full cube approximation; not a replacement for client play tests."""
from collections import deque
import json, math
import numpy as np

def veins(canvas,target,get,put,seed,host='minecraft:stone',surface=None):
    """Keep all original ore and add adjacent ore, never replace builds/chests. Ratio is preserved cumulatively."""
    rng=np.random.default_rng(seed);original=len(canvas.ores);front=list(canvas.ores);rng.shuffle(front)
    used={(x,y,z) for x,y,z,_ in canvas.ores};attempts=0
    while len(canvas.ores)<target and front and attempts<20000:
        x,y,z,k=front[attempts%len(front)];attempts+=1
        # A 3..8 block cluster budget, with remaining ore left as the original small deposits.
        budget=min(target-len(canvas.ores),int(rng.integers(2,8)))
        added=0
        for dx,dz in [(1,0),(-1,0),(0,1),(0,-1),(1,1),(-1,-1),(1,-1),(-1,1)]:
            if added>=budget:break
            a,c=x+dx,z+dz;b=get(a,y,c)
            if (a,y,c) in used or not canvas.inb(a,c):continue
            if b not in ('minecraft:air','minecraft:cave_air',host,'minecraft:end_stone','minecraft:stone'):continue
            if surface is not None and surface(a,c)!=y-1:continue
            if get(a,y-1,c) in (None,'minecraft:air','minecraft:cave_air','minecraft:water'):continue
            # Do not obstruct a chest, doorway, ladder or registered spawn.
            if any(abs(a-u)+abs(c-w)<=2 and abs(y-v)<3 for u,v,w in canvas.chests+canvas.riches+canvas.spawns):continue
            coal=sum(o[3]==1 for o in canvas.ores)
            ratio=sum(o[3]==1 for o in front)/len(front)
            kind=1 if coal<round((len(canvas.ores)+1)*ratio) else 3
            block='minecraft:coal_ore' if kind==1 else 'minecraft:redstone_ore'
            put(a,y,c,block)
            # Protected columns may reject a write. Never register a phantom ore.
            if get(a,y,c)!=block:continue
            canvas.ores.append((a,y,c,kind));used.add((a,y,c));added+=1
    return {'before':original,'target':target,'after':len(canvas.ores)}

def audit(canvas,pal,y0,put,base=None,repair=True):
    """Headroom, supported continuous ladders, water swimming, +/-1 steps and <=3-block drops.
    Relocate an inaccessible chest to nearby reachable ground rather than cutting a large route through a building.
    """
    def raw(x,y,z):
        b=canvas.get(x,y,z)
        if base is not None and b=='minecraft:air':b=base.get(x,y,z)
        return b or 'minecraft:air'
    ladder={}
    xs,zs,ys=np.nonzero(canvas.g)
    for ix,iz,iy in zip(xs,zs,ys):
        b=pal[canvas.g[ix,iz,iy]]
        if 'minecraft:ladder[' in b:ladder.setdefault((int(ix)+canvas.x1,int(iz)+canvas.z1,b),[]).append(int(iy)+y0)
    fixes=0
    for (x,z,b),yy in ladder.items():
        dx,dz=next((v for k,v in {'north':(0,1),'south':(0,-1),'west':(1,0),'east':(-1,0)}.items() if 'facing='+k in b),(0,-1))
        for y in range(min(yy),max(yy)+1):
            if repair:
                if raw(x,y,z)!=b:put(x,y,z,b);fixes+=1
                support=raw(x+dx,y,z+dz)
                if any(t in support for t in ('air','pane','ladder','water','slab','stairs')):put(x+dx,y,z+dz,'minecraft:stone_bricks');fixes+=1
        if repair:
            for y in (max(yy)+1,max(yy)+2):
                if 'chest' not in raw(x,y,z):put(x,y,z,'minecraft:air')
    grid=canvas.g.copy()
    if base is not None:
        bg=base.g[canvas.x1-base.x1:canvas.x2-base.x1+1,canvas.z1-base.z1:canvas.z2-base.z1+1,:]
        grid=np.where(grid!=0,grid,bg)
    names=list(pal)
    def passable(b):
        return any(t in b for t in ('air','ladder','water','grass','flower','carpet','torch','lantern','rail','vine','lichen','fern','mushroom','dead_bush','petals','end_rod','door')) and b not in ('minecraft:grass_block',) and 'trapdoor' not in b
    air=np.array([passable(b) for b in names],bool)[grid]
    swim=np.array(['water' in b or 'ladder' in b for b in names],bool)[grid]
    solid=~air
    standing=np.zeros(grid.shape,bool)
    standing[:,:,1:-1]=air[:,:,1:-1]&air[:,:,2:]&(solid[:,:,:-2]|swim[:,:,1:-1])
    starts=[(x-canvas.x1,z-canvas.z1,y-y0) for x,y,z in canvas.spawns]
    # Ring entrances are joined to the fixed bridges in the sky templates.
    if getattr(canvas,'isle',False):starts += [(x-canvas.x1,z-canvas.z1,1-y0) for x,z in ((27,0),(-27,0),(0,27),(0,-27))]
    seen=set();q=deque()
    for p in starts:
        if all(0<=p[i]<grid.shape[i] for i in range(3)) and standing[p]:seen.add(p);q.append(p)
    while q:
        x,z,y=q.popleft()
        for dx,dz in ((1,0),(-1,0),(0,1),(0,-1)):
            for dy in (0,1,-1,-2,-3):
                n=(x+dx,z+dz,y+dy)
                if n in seen or not all(0<=n[i]<grid.shape[i] for i in range(3)) or not standing[n]:continue
                if dy==1 and not air[x,z,min(y+2,grid.shape[2]-1)]:continue
                seen.add(n);q.append(n);break
        if swim[x,z,y] or (y and swim[x,z,y-1]):
            for dy in (-1,1):
                n=(x,z,y+dy)
                if 0<=n[2]<grid.shape[2] and n not in seen and standing[n]:seen.add(n);q.append(n)
    reachable={(x+canvas.x1,y+y0,z+canvas.z1) for x,z,y in seen}
    def access(c):
        x,y,z=c
        return any((x+dx,y+dy,z+dz) in reachable for dx,dz in ((1,0),(-1,0),(0,1),(0,-1)) for dy in (0,-1))
    moved=[];blocked=[]
    occupied=set(canvas.chests+canvas.riches)
    for group in (canvas.chests,canvas.riches):
        for i,c in enumerate(list(group)):
            x,y,z=c
            if repair and not passable(raw(x,y+1,z)):put(x,y+1,z,'minecraft:air');fixes+=1
            if access(c):continue
            candidates=[]
            for u,v,w in reachable:
                if abs(v-y)>40 or (u,v,w) in occupied or (u,v,w) in canvas.spawns or 'air' not in raw(u,v,w) or 'air' not in raw(u,v+1,w):continue
                if not any((u+dx,v,w+dz) in reachable for dx,dz in ((1,0),(-1,0),(0,1),(0,-1))):continue
                if any(abs(u-a)+abs(w-cz)<=1 and abs(v-b)<2 for a,b,cz in occupied):continue
                candidates.append(((u-x)**2+(w-z)**2+4*(v-y)**2,(u,v,w)))
            if repair and candidates:
                _,n=min(candidates);put(*c,'minecraft:air');put(*n,'minecraft:chest[facing=north]');group[i]=n;occupied.remove(c);occupied.add(n);moved.append({'from':c,'to':n})
            else:blocked.append(c)
    # A relocated chest is solid and may close a narrow route. Recheck the final
    # geometry instead of reporting reachability from before those placements.
    if repair:
        post=audit(canvas,pal,y0,put,base,repair=False)
        blocked=post['unreachable_chests']
    return {'method':'3D BFS, full-cube approximation; spawn/ring entry roots; recheck after repairs','walkable_reached':len(seen),'ladder_columns':len(ladder),'geometry_repairs':fixes,'relocated_chests':moved,'unreachable_chests':blocked}
