import math,sys
from PIL import Image,ImageDraw
sys.path.insert(0,'/tmp/claude-0/-home-claude/e1eb65de-8836-5b05-8032-ea1308616649/scratchpad/tools')
COL={'waxed_cut_copper':(205,120,80),'waxed_exposed_cut_copper':(190,140,110),'waxed_weathered_cut_copper':(110,160,120),'waxed_oxidized_cut_copper':(60,175,160),
 'polished_blackstone':(50,45,55),'waxed_chiseled_copper':(225,140,95),'sea_lantern':(250,245,210)}
def render(B,ground=None,yaw=35,pitch=28,scale=9,size=(1100,900),out='v.png',center=(0,0,5),bg=(150,190,235),title=''):
    W,H=size
    im=Image.new('RGB',size,bg); d=ImageDraw.Draw(im)
    ya=math.radians(yaw); pa=math.radians(pitch)
    def proj(x,y,z):
        x-=center[0]; y-=center[1]; z-=center[2]
        xr=x*math.cos(ya)-z*math.sin(ya); zr=x*math.sin(ya)+z*math.cos(ya)
        sy=y*math.cos(pa)-zr*math.sin(pa); depth=zr*math.cos(pa)+y*math.sin(pa)
        return W/2+xr*scale, H*0.62-sy*scale, depth
    items=[]
    if ground:
        for (x,y,z),c in ground.items(): items.append((x,y,z,c,True))
    for (x,y,z),b in B.items():
        n=b.split(':')[1].split('[')[0]
        items.append((x,y,z,COL.get(n,(200,0,200)),False))
    pts=[]
    for x,y,z,c,g in items:
        sx,sy,dp=proj(x,y,z); pts.append((dp,sx,sy,c,g))
    pts.sort(key=lambda t:t[0])
    s=scale
    for dp,sx,sy,c,g in pts:
        sh=1.0
        if not g:
            # depth cue
            sh=max(0.65,min(1.05,0.85+dp*0.004))
        col=tuple(int(min(255,v*sh)) for v in c)
        d.rectangle([sx-s*0.55,sy-s*0.55,sx+s*0.55,sy+s*0.55],fill=col,outline=None if g else (0,0,0))
    if title:d.text((10,10),title,fill=(0,0,0))
    im.save(out)
if __name__=='__main__':
    import dome
    B,_=dome.build()
    ground={}
    import math
    for x in range(-40,41):
        for z in range(-40,41):
            r=math.hypot(x,z)
            ground[(x,-11,z)]=(95,150,70) if r>26 else ((150,150,150) if r>23 else (120,130,110))
    render(B,ground,yaw=35,pitch=24,scale=9,out='../dome_a.png',center=(0,10,0))
    render(B,ground,yaw=0,pitch=2,scale=9,out='../dome_front.png',center=(0,10,0))
    render(B,ground,yaw=20,pitch=70,scale=9,out='../dome_top.png',center=(0,0,0))
