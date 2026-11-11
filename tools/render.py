import numpy as np,re,sys
from PIL import Image,ImageDraw
COL={'grass_block':(98,150,64),'dirt':(120,85,55),'stone':(125,125,125),'snow_block':(240,245,250),'packed_ice':(160,190,240),'dirt_path':(150,125,70),'gravel':(135,130,130),'sand':(222,208,150),
'bricks':(150,85,70),'stone_bricks':(120,120,120),'mossy_stone_bricks':(100,125,90),'cracked_stone_bricks':(110,110,110),'cobblestone':(110,110,110),'mossy_cobblestone':(95,115,90),
'sea_lantern':(250,240,200),'polished_blackstone':(45,42,50),'waxed_cut_copper':(190,110,75),'waxed_oxidized_copper':(70,150,130),'smooth_quartz':(235,230,225),'oak_planks':(170,130,80),'spruce_planks':(110,80,50),
'dark_oak_planks':(70,50,30),'oak_leaves':(50,120,40),'spruce_leaves':(40,90,50),'oak_log':(105,80,45),'spruce_log':(70,50,30),'chest':(240,200,40),'glass':(190,220,230),'glass_pane':(190,220,230),
'andesite':(135,135,135),'deepslate':(80,80,85),'coal_ore':(60,60,60),'deepslate_coal_ore':(50,50,55),'redstone_ore':(150,60,60),'deepslate_redstone_ore':(140,50,50),'bedrock':(30,30,30),
'poppy':(210,40,40),'dandelion':(240,220,60),'azure_bluet':(230,230,240),'short_grass':(90,160,60),'water':(50,100,200)}
def color(b):
    n=b.split(':')[1].split('[')[0]
    if n in COL:return COL[n]
    for k,v in COL.items():
        if k in n:return v
    if 'wool' in n or 'carpet' in n:
        return {'white':(230,230,230),'cyan':(30,140,150),'red':(170,40,40),'blue':(50,60,160),'light_blue':(100,160,220),'yellow':(230,200,50),'orange':(220,120,30)}.get(n.split('_wool')[0].split('_carpet')[0],(180,180,180))
    if 'stairs' in n or 'slab' in n or 'fence' in n or 'planks' in n:return (150,115,70)
    return (200,0,200)
def render(V,pal,x0,x1,z0,z1,s,ymax=0,water=None):
    W=(x1-x0+1)*s;H=(z1-z0+1)*s
    im=Image.new('RGB',(W,H));px=im.load()
    cols=[color(p) if p!='minecraft:air' else None for p in pal]
    for z in range(z0,z1+1):
        for x in range(x0,x1+1):
            col=V[:,z+152,x+152]
            top=None
            for y in range(20,-1,-1):
                if col[y]>0 and y-20<=ymax: top=y;break
            if top is None:c=(0,0,0)
            else:
                c=cols[col[top]]
                # shade by height diff to north neighbour
                def th(xx,zz):
                    cc=V[:,zz+152,xx+152]
                    for y in range(20,-1,-1):
                        if cc[y]>0 and y-20<=ymax:return y
                    return 0
                d=top-th(x,z-1) if z>z0 else 0
                f=1+0.08*max(-3,min(3,d))
                c=tuple(int(max(0,min(255,v*f))) for v in c)
            for dx in range(s):
                for dz in range(s):
                    px[(x-x0)*s+dx,(z-z0)*s+dz]=c
    return im
if __name__=='__main__':
    d=np.load(sys.argv[1]);V=d['V'];pal=list(map(str,d['pal']))
    render(V,pal,-152,152,-152,152,3).save(sys.argv[2])
    render(V,pal,-50,50,-50,50,10).save(sys.argv[3])
