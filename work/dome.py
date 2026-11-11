"""Dome frame generator for the OA plaza (relative coordinates: x,z centered on the plaza, y relative to selected plane; ground surface block y=-11)."""
import math
GROUND=-11            # top ground block y (stand level is GROUND+1)
K0=GROUND+1           # y of layer k=0
def Y(k): return K0+k
# --- parameters -------------------------------------------------------------
R_BASE=25.0; R_MID=17.0; R_TOP=9.0
K_BASE=21             # lowest frame layer (stand surface 22 above floor)
K_TOP=38
PYLON_ANGLES=[22.5+45*j for j in range(8)]
def sphere_k(r):
    # sphere through (R_BASE,K_BASE) and (R_TOP,K_TOP)
    kc=((R_TOP**2+K_TOP**2)-(R_BASE**2+K_BASE**2))/(2*(K_TOP-K_BASE))
    Rs2=R_BASE**2+(K_BASE-kc)**2
    return kc+math.sqrt(max(0,Rs2-r*r))
CU=['minecraft:waxed_cut_copper','minecraft:waxed_exposed_cut_copper','minecraft:waxed_weathered_cut_copper','minecraft:waxed_oxidized_cut_copper']
def tone(k):
    if k<=26:return CU[0]
    if k<=31:return CU[1]
    if k<=35:return CU[2]
    return CU[3]
LANT='minecraft:sea_lantern'; BLK='minecraft:polished_blackstone'; CHI='minecraft:waxed_chiseled_copper'
def line3(a,b):
    (x0,y0,z0),(x1,y1,z1)=a,b
    n=int(max(abs(x1-x0),abs(y1-y0),abs(z1-z0))*2)+1
    out=[]
    for i in range(n+1):
        t=i/n
        out.append((round(x0+(x1-x0)*t),round(y0+(y1-y0)*t),round(z0+(z1-z0)*t)))
    # dedupe preserving order
    seen=set();res=[]
    for p in out:
        if p not in seen:seen.add(p);res.append(p)
    return res
def pol(r,deg,k=None):
    a=math.radians(deg)
    return (r*math.cos(a), (sphere_k(r) if k is None else k), r*math.sin(a))
def build():
    B={}   # (x,y,z)->block
    def put(p,b,over=False):
        x,k,z=p
        key=(round(x),Y(round(k)),round(z))
        if over or key not in B:B[key]=b
    def put_k(x,k,z,b,over=False):
        key=(x,Y(k),z)
        if over or key not in B:B[key]=b
    # pylons: 2x2 columns, outer-offset so that the column center is at r~R_BASE
    pyl=[]
    for a in PYLON_ANGLES:
        cx=R_BASE*math.cos(math.radians(a)); cz=R_BASE*math.sin(math.radians(a))
        x0=math.floor(cx-0.5)+0; z0=math.floor(cz-0.5)+0   # 2x2 occupying x0..x0+1 (round center to .0)
        pyl.append((a,x0,z0))
        for dx in (0,1):
            for dz in (0,1):
                for k in range(0,K_BASE):
                    if k<2: b=BLK
                    elif k>=K_BASE-2: b=CHI
                    else: b=CU[0]
                    put_k(x0+dx,k,z0+dz,b,over=True)
        # inlaid lights on the inner face cell
        ix=x0+(0 if cx>0 else 1); iz=z0+(0 if cz>0 else 1)
        # choose the cell nearest to the plaza center
        best=min(((dx,dz) for dx in (0,1) for dz in (0,1)),key=lambda d:(x0+d[0])**2+(z0+d[1])**2)
        for k in (6,11,16):
            put_k(x0+best[0],k,z0+best[1],LANT,over=True)
    # rings
    def ring(r,k,block=None,steps=720):
        for i in range(steps):
            a=360*i/steps
            x=round(r*math.cos(math.radians(a))); z=round(r*math.sin(math.radians(a)))
            put_k(x,k,z,block or tone(k))
    kb=K_BASE; km=round(sphere_k(R_MID)); kt=K_TOP
    ring(R_BASE,kb); ring(R_MID,km); ring(R_TOP,kt)
    # meridians: 16; majors (j even over pylon angles) to the top ring, minors to mid ring
    major=[a for a in PYLON_ANGLES]
    minor=[a+22.5 for a in PYLON_ANGLES]   # cardinal/diagonal gate directions
    def meridian(deg,r_from,r_to):
        n=int(abs(r_from-r_to)*4)+1
        pts=[]
        for i in range(n+1):
            r=r_from+(r_to-r_from)*i/n
            x=round(r*math.cos(math.radians(deg))); z=round(r*math.sin(math.radians(deg))); k=round(sphere_k(r))
            pts.append((x,k,z))
        seen=set()
        for p in pts:
            if p in seen:continue
            seen.add(p); put_k(p[0],p[1],p[2],tone(p[1]))
    for a in major: meridian(a,R_BASE,R_TOP)
    for a in minor: meridian(a,R_BASE,R_MID)
    # pinwheel bracing (all diagonals rotate the same way): lower tier one diagonal per 22.5deg cell
    # from a major meridian at the base ring up to the next minor meridian at the mid ring; upper tier from a
    # major meridian at the mid ring to the next major meridian at the top ring.
    for a0 in major:
        a1=a0+22.5
        for (x,k,z) in line3(pol(R_BASE,a0,kb),pol(R_MID,a1,km)): put_k(x,k,z,tone(k))
        a1=a0+22.5
        # second diagonal of the lower tier: from the minor meridian at base up to next major at mid (keeps rotation)
        for (x,k,z) in line3(pol(R_BASE,a0+22.5,kb),pol(R_MID,a0+45,km)): put_k(x,k,z,tone(k))
    nodes=[]
    for a0 in major:
        p0=pol(R_MID,a0,km); p1=pol(R_TOP,a0+45,kt)
        for (x,k,z) in line3(p0,p1): put_k(x,k,z,tone(k))
        nodes.append((round((p0[0]+p1[0])/2),round((p0[1]+p1[1])/2),round((p0[2]+p1[2])/2)))
    # light nodes
    for a,x0,z0 in pyl:
        a_=math.radians(a); 
        put_k(round(R_BASE*math.cos(a_)),kb,round(R_BASE*math.sin(a_)),LANT,over=True)
    for a in major:
        a_=math.radians(a)
        put_k(round(R_MID*math.cos(a_)),km,round(R_MID*math.sin(a_)),LANT,over=True)
        put_k(round(R_TOP*math.cos(a_)),kt,round(R_TOP*math.sin(a_)),LANT,over=True)
    for (x,k,z) in nodes: put_k(x,k,z,LANT,over=True)
    return B,pyl
if __name__=='__main__':
    B,pyl=build()
    import collections
    print(len(B),collections.Counter(B.values()))
    print('ys',min(y for x,y,z in B),max(y for x,y,z in B))
    print('km',round(sphere_k(R_MID)))
