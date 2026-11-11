from pathlib import Path
import numpy as np,random,math,json,struct,gzip,zipfile,shutil
from PIL import Image,ImageDraw,ImageFont
R=random.Random(300263);ROOT=Path(__file__).resolve().parent;PACK=ROOT/'pack';OUT=ROOT/'output';F=PACK/'data/oa_map2/function';S=PACK/'data/oa_map2/structure/tile'
for d in [F,S,OUT]:d.mkdir(parents=True,exist_ok=True)
N=305;LOW=-20;NY=21;X,Z=np.meshgrid(np.arange(N)-152,np.arange(N)-152);pal=[];cols=[];lookup={}
def b(n,c,**p):
 key=(n,tuple(sorted(p.items())))
 if key not in lookup:
  lookup[key]=len(pal);o={'id':'minecraft:'+n}
  if p:o['properties']=p
  pal.append(o);cols.append(c)
 return lookup[key]
A=b('air',(0,0,0));STONE=b('stone',(127,134,135));DIRT=b('dirt',(130,99,61));GRASS=b('grass_block',(112,154,70));BED=b('bedrock',(56,58,60));SAND=b('sand',(222,210,155));WATER=b('water',(47,124,178),level='0');GRAVEL=b('gravel',(146,138,122));PATH=b('dirt_path',(172,151,94));COBBLE=b('cobblestone',(119,127,120));BRICK=b('stone_bricks',(147,151,146));MOSS=b('mossy_stone_bricks',(121,141,103));CRACK=b('cracked_stone_bricks',(135,137,127));SNOW=b('snow_block',(229,239,240));PACKICE=b('packed_ice',(131,181,214));ANDESITE=b('andesite',(142,146,145));DEEP=b('deepslate',(74,77,81),axis='y')
OAK=b('oak_planks',(179,147,95));SPRUCE=b('spruce_planks',(111,84,57));LOG=b('oak_log',(117,88,52),axis='y');SLOG=b('spruce_log',(79,62,41),axis='y');LEAF=b('oak_leaves',(62,117,49),persistent='true',distance='1');PINE=b('spruce_leaves',(48,91,68),persistent='true',distance='1');LIGHT=b('sea_lantern',(207,229,203));GLASS=b('glass_pane',(157,209,216));ROOF=b('bricks',(157,85,65));COPPER=b('waxed_oxidized_copper',(73,148,124));CHEST=b('chest',(182,126,50),facing='south',type='single',waterlogged='false');BARREL=b('barrel',(141,108,64),facing='up',open='false');CRAFT=b('crafting_table',(137,94,54));FURNACE=b('furnace',(107,113,110),facing='south',lit='false');BOOK=b('bookshelf',(151,119,75));HAY=b('hay_block',(191,168,47),axis='y');PUMPKIN=b('pumpkin',(205,128,40));COAL=b('coal_ore',(78,80,76));RED=b('redstone_ore',(157,83,76));DC=b('deepslate_coal_ore',(55,57,59));DR=b('deepslate_redstone_ore',(127,62,63));BARRIER=b('barrier',(104,117,121))
FLOWERS=[b('poppy',(203,53,54)),b('dandelion',(234,198,43)),b('azure_bluet',(216,225,215))]
height=-12+.6*np.sin(X/20)*np.cos(Z/26)
for cx,cz,amp,rx,rz in [(-105,-118,11,30,35),(-48,-130,10,31,27),(29,-120,11,34,32),(105,-112,10,33,36),(-12,-71,6,42,27),(83,-60,4,43,31)]:height+=amp*np.exp(-(((X-cx)/rx)**2+((Z-cz)/rz)**2))
def flat(cx,cz,r,y,fade=9):
 global height
 w=np.clip((r+fade-np.hypot(X-cx,Z-cz))/fade,0,1);w=w*w*(3-2*w);height=height*(1-w)+y*w
flat(0,0,35,-11,15)
for cx,cz,r,y in [(-96,-16,66,-12),(-94,59,26,-13),(-35,-86,29,-9)]:flat(cx,cz,r,y)
coast=83+7*np.sin(X/22)+3*np.cos(X/45)
sea=Z>coast;beach=(Z>coast-10)&~sea
height=np.where(beach,np.where(Z>coast-3,-14,-13),height)
height=np.where(sea,-15-np.clip(np.floor((Z-coast)/3),0,4),height)
H=np.clip(np.rint(height),-19,-1).astype(np.int16);V=np.zeros((NY,N,N),dtype=np.uint8)
for yi in range(NY):V[yi]=np.where(yi+LOW<=H,STONE,A)
V[0]=BED
for dy in [1,2]:
 yy=np.maximum(H-dy,LOW+1)-LOW;V[yy,np.arange(N)[:,None],np.arange(N)[None,:]]=DIRT
V[H-LOW,np.arange(N)[:,None],np.arange(N)[None,:]]=GRASS
slopes=np.hypot(*np.gradient(height))>.38
V[H-LOW,np.arange(N)[:,None],np.arange(N)[None,:]]=np.where((Z<-55)&slopes,STONE,GRASS)
for zi in range(N):
 for xi in range(N):
  y=int(H[zi,xi]);z=zi-152
  if sea[zi,xi]:
   V[y-LOW,zi,xi]=SAND;V[y-LOW+1:-14-LOW+1,zi,xi]=WATER
  elif beach[zi,xi]:V[y-LOW,zi,xi]=SAND
  elif z < (-105 + 9*math.sin((xi-152)/26) + 5*math.sin((xi-152)/11) + 2*math.sin((xi+zi)*0.8)) and y>=-11:V[y-LOW,zi,xi]=SNOW if (xi+zi)%17 else PACKICE
def valid(x,z):return -152<=x<153 and -152<=z<153
def h(x,z):return int(H[z+152,x+152])
def get(x,y,z):return int(V[y-LOW,z+152,x+152]) if valid(x,z) and LOW<=y<=0 else A
def put(x,y,z,v):
 if valid(x,z) and LOW<=y<=0:V[y-LOW,z+152,x+152]=v
def box(x0,y0,z0,x1,y1,z1,v):
 x0,x1=sorted((x0,x1));z0,z1=sorted((z0,z1));y0,y1=sorted((y0,y1))
 V[max(0,y0-LOW):min(NY,y1-LOW+1),max(0,z0+152):min(N,z1+153),max(0,x0+152):min(N,x1+153)]=v
roads=set()
def road(points,w=1):
 for (x0,z0),(x1,z1) in zip(points,points[1:]):
  for t in np.linspace(0,1,max(abs(x1-x0),abs(z1-z0))*2+1):
   xx,zz=round(x0+(x1-x0)*t),round(z0+(z1-z0)*t)
   for dx in range(-w,w+1):
    for dz in range(-w,w+1):
     x,z=xx+dx,zz+dz
     if valid(x,z) and not sea[z+152,x+152]:roads.add((x,z));put(x,h(x,z),z,PATH if R.random()<.7 else GRAVEL)
road([(-147,0),(-96,0),(-48,-3),(0,0),(65,3),(145,14)],2)
road([(0,-146),(-7,-102),(-14,-55),(0,0),(5,40),(0,78)],2)
road([(-130,-78),(-62,-78),(-38,-67),(-14,-55),(58,-63),(120,-77)],1)
road([(-96,-70),(-96,65),(-92,88)],1);road([(65,3),(79,43),(68,75)],1)
road([(-120,-45),(-112,-92),(-75,-104),(-22,-97),(40,-95),(96,-91),(128,-40),(111,22),(111,65)],1)
chests=[];houses=[];ores=[];mounds=[];trees=[];buildings=[]
def chest(x,y,z,k):
 if not valid(x,z) or not LOW+1<=y<0:return
 if any(abs(x-a)+abs(z-c)<3 for a,_,c,_ in chests):return
 put(x,y,z,CHEST);put(x,y+1,z,A);chests.append((x,y,z,k))
def house(cx,cz,y,style):
 wood=OAK if style%2==0 else SPRUCE;roof=ROOF if style%3 else SPRUCE
 box(cx-4,LOW+1,cz-4,cx+4,y,cz+4,COBBLE);box(cx-4,y+1,cz-3,cx+4,y+4,cz+3,wood);box(cx-3,y+1,cz-2,cx+3,y+4,cz+2,A)
 for x in [cx-4,cx+4]:
  for z in [cz-3,cz+3]:box(x,y+1,z,x,y+4,z,LOG)
 box(cx-4,y,cz-3,cx+4,y,cz+3,wood)
 box(cx,y+1,cz+3,cx,y+3,cz+3,A)
 for x,z in [(cx-4,cz),(cx+4,cz),(cx,cz-3)]:put(x,y+2,z,GLASS)
 for rise in range(3):box(cx-5+rise,y+5+rise,cz-4,cx+5-rise,y+5+rise,cz+4,roof)
 theme=style%8
 decor=[(BOOK,BOOK),(CRAFT,FURNACE),(b('smoker',(100,81,61),facing='south',lit='false'),HAY),(b('flower_pot',(128,76,47)),BOOK),(BARREL,BARREL),(b('loom',(166,131,82),facing='south'),b('white_wool',(230,228,218))),(b('anvil',(73,74,78),facing='north'),FURNACE),(BOOK,BARREL)][theme]
 put(cx+2,y+1,cz-2,decor[0]);put(cx+3,y+1,cz-2,decor[1]);put(cx-3,y+1,cz-2,BOOK if theme in [0,3,7] else BARREL);put(cx,y+4,cz,LIGHT)
 carpet=b(['red_carpet','blue_carpet','yellow_carpet','green_carpet','cyan_carpet','purple_carpet','orange_carpet','white_carpet'][theme],[(147,42,38),(55,69,142),(214,178,45),(67,112,49),(53,133,146),(126,67,149),(203,113,43),(227,226,216)][theme])
 box(cx-1,y+1,cz,cx+1,y+1,cz+1,carpet)
 if theme in [0,3,7]:
  put(cx+3,y+1,cz+1,b('oak_stairs',(179,147,95),facing='west',half='bottom',shape='straight',waterlogged='false'))
  put(cx+2,y+1,cz+1,b('oak_slab',(179,147,95),type='top',waterlogged='false'))
 elif theme in [1,6]:put(cx+3,y+1,cz+1,b('stonecutter',(135,131,122),facing='west'))
 elif theme==2:put(cx+3,y+1,cz+1,PUMPKIN)
 elif theme==4:put(cx+3,y+1,cz+1,b('cartography_table',(120,96,64)))
 else:put(cx+3,y+1,cz+1,b('bookshelf',(151,119,75)))
 chest(cx-2,y+1,cz-1,'house');houses.append((cx,cz,y))
for row,z in enumerate([-66,-46,-26,-6,14,34]):
 for col,x in enumerate([-132,-114,-96,-78,-60]):
  if (row+col)%2==0:house(x,z,-12,row*5+col)
for i,(x,z) in enumerate([(-115,57),(-79,57),(-97,75)]):house(x,z,-13,i)
for i,(x,z) in enumerate([(-52,-95),(-18,-95),(-35,-77)]):house(x,z,-9,i)
# Grade a short entry ramp for every house where village platforms meet a slope.
for cx,cz,y in houses:
 end=h(cx,cz+12)
 for step in range(9):
  z=cz+4+step;yy=round(y+(end-y)*step/8)
  for x in range(cx-1,cx+2):
   box(x,LOW+1,z,x,yy,z,COBBLE);box(x,yy+1,z,x,min(0,yy+3),z,A);put(x,yy,z,PATH);roads.add((x,z))
for j,z in enumerate([-56,-36,-16,4,24,44]):road([(-140,z),(-128,z-2),(-116,z+2),(-101,z),(-90,z-2),(-76,z+2),(-63,z),(-52,z)],1)
for x in [-123,-105,-87,-69]:road([(x,-75),(x+2,-60),(x,-46),(x-2,-31),(x,-16),(x+2,0),(x,14),(x-2,29),(x,44)],1)
# Village wells, market stalls, street lamps and hay yards.
for cx,cz,y in [(-96,-16,-12),(-97,66,-13)]:
 box(cx-2,y,cz-2,cx+2,y+1,cz+2,COBBLE);box(cx-1,y+1,cz-1,cx+1,y+1,cz+1,WATER)
 for dx,dz in [(-2,-2),(2,-2),(-2,2),(2,2)]:box(cx+dx,y+2,cz+dz,cx+dx,y+3,cz+dz,LOG)
 box(cx-3,y+4,cz-3,cx+3,y+4,cz+3,SPRUCE)
for cx,cz in [(-123,44),(-106,44),(-87,44),(-69,44)]:
 y=h(cx,cz);box(cx,y+1,cz,cx+4,y+1,cz+2,OAK);box(cx,y+4,cz,cx+4,y+4,cz+2,COPPER);put(cx,y+2,cz,LOG);put(cx+4,y+2,cz,LOG)
for x,z in [(-145,-40),(-145,-20),(-145,4),(-55,20),(-120,86)]:box(x,h(x,z)+1,z,x+3,h(x,z)+1,z+2,HAY)
# Central decorative plaza with solid, sealed tower. All blocks remain at/below selected Y.
for z in range(-34,35):
 for x in range(-34,35):
  d=math.hypot(x,z)
  if 23<=d<=26 or d<6:put(x,-11,z,BRICK if (x+z)%4 else CRACK)
for x,z in [(-18,-18),(18,-18),(-18,18),(18,18)]:
 box(x-3,-10,z-3,x+3,-10,z+3,BRICK);box(x-2,-9,z-2,x+2,-9,z+2,DIRT)
 for xx in range(x-2,x+3):
  for zz in range(z-2,z+3):put(xx,-8,zz,FLOWERS[(xx+zz)%3])
for x,z in [(-29,0),(29,0),(0,-29),(0,29)]:
 box(x,-10,z,x,-7,z,BRICK);put(x,-6,z,LIGHT)
for x,z in [(-14,8),(14,8),(-14,-7),(14,-7)]:
 box(x-2,-10,z,x+2,-10,z,BRICK);box(x-2,-9,z,x-2,-9,z,MOSS);box(x+2,-9,z,x+2,-9,z,MOSS)
# Open dome: eight pillars, rim and curved ribs; no enclosing roof.
for angle in range(0,360,45):
 a=math.radians(angle);px,pz=round(17*math.cos(a)),round(17*math.sin(a))
 box(px,-10,pz,px,-5,pz,BRICK);put(px,-4,pz,LIGHT)
for angle in range(360):
 a=math.radians(angle);put(round(17*math.cos(a)),-4,round(17*math.sin(a)),BRICK)
# Readable 5x7 OA lettering in the plaza floor, facing north on the overview.
for offset,glyph in [(-6,['01110','11011','11011','11011','11011','11011','01110']),(1,['01110','11011','11011','11111','11011','11011','11011'])]:
 for row,line in enumerate(glyph):
  for col,c in enumerate(line):
   if c=='1':put(offset+col,-11,row-3,LIGHT)
for x,z in [(-31,-20),(31,-20),(-31,20),(31,20)]:chest(x,-11 if (x,z)==(-31,-20) else -10,z,'plaza')
# Eastern ruins: small, low broken courtyards beneath forest cover.
for cx,cz in [(72,-32),(113,11),(78,55)]:
 y=h(cx,cz);box(cx-7,y,cz-5,cx+7,y,cz+5,BRICK)
 for x in range(cx-7,cx+8):box(x,y+1,cz-5,x,y+R.choice([1,2,3]),cz-5,MOSS if x%2 else CRACK)
 for dx,dz in [(-7,5),(7,5)]:box(cx+dx,y+1,cz+dz,cx+dx,y+4,cz+dz,BRICK)
 chest(cx-3,y+1,cz+1,'forest_ruin');chest(cx+4,y+1,cz+1,'forest_ruin')
# Fishing pier and a small beached wooden boat.
box(-94,-13,83,-90,-13,122,SPRUCE)
for z in range(86,123,7):box(-95,-18,z,-95,-11,z,SLOG);box(-89,-18,z,-89,-11,z,SLOG)
chest(-92,-12,116,'pier');chest(-87,-12,84,'harbor')
box(52,-13,96,64,-13,100,SPRUCE);box(52,-12,96,64,-12,96,OAK);box(52,-12,100,64,-12,100,OAK);box(52,-12,97,52,-11,99,OAK);box(64,-12,97,64,-11,99,OAK);box(58,-12,98,58,-6,98,LOG)
# Hand-built sealed wooden vessel: thick hull, accessible lower deck and aft cabin.
cx=-78
for z in range(93,130):
 half=min(7,z-92,131-z)
 box(cx-half,-18,z,cx+half,-11,z,SPRUCE)
 if half>=3:box(cx-half+2,-15,z,cx+half-2,-12,z,A)
 box(cx-half,-11,z,cx+half,-11,z,OAK)
 for x in [cx-half,cx+half]:
  put(x,-10,z,b('oak_fence',(153,115,66),north='true',south='true',east='false',west='false',waterlogged='false'))
# Cabin: solid glazed walls and pitched wooden roof, no open accidental holes.
box(-83,-10,117,-73,-7,126,SPRUCE);box(-82,-10,118,-74,-7,125,A)
box(-79,-10,117,-77,-8,117,A)
for x in [-83,-73]:
 for z in [120,123]:put(x,-8,z,b('glass',(168,209,216)))
box(-84,-6,116,-72,-6,127,SPRUCE);box(-83,-5,117,-73,-5,126,OAK);box(-81,-4,118,-75,-4,125,SPRUCE)
box(-79,-10,123,-77,-10,123,OAK);put(-81,-10,122,BARREL);put(-75,-10,123,BOOK);put(-78,-7,124,LIGHT)
# Lower deck cargo / bunks along side walls; keep central corridor clear.
for z in [108,113,118,123]:
 put(-82,-15,z,BARREL);put(-74,-15,z,BARREL);put(-78,-12,z,LIGHT)
for z in [108,119]:
 box(-81,-15,z,-80,-15,z+1,OAK);box(-76,-15,z,-75,-15,z+1,b('white_wool',(230,228,218)))
# A continuous stairwell through the deck leads to the lower cabin.
for i in range(5):
 z=100+i;yy=-12-i
 box(-79,yy,z,-77,yy,z,SPRUCE);box(-79,yy+1,z,-77,-9,z,A)
# Mast, crossbeams and cloth sail inside the authored vertical envelope.
box(-78,-10,110,-78,0,110,SLOG);box(-83,-2,110,-73,-2,110,SLOG)
for yy in range(-8,-2):box(-82,yy,109,-74,yy,109,b('white_wool',(230,228,218)))
for x,yy in [(-90,-13),(-89,-12),(-88,-11),(-87,-11),(-86,-11),(-85,-11)]:
 box(x,yy,110,x,yy,112,SPRUCE);box(x,yy+1,110,x,yy+3,112,A)
ship={'bounds':[-85,-17,93,-71,0,129],'boarding':[-90,-12,111],'lower_deck':[-78,-15,108],'cabin':[-78,-10,120]}
chest(-80,-15,110,'ship_lower');chest(-76,-10,124,'ship_cabin')
# Single-type ore outcrops. North has the majority, southern roadside has just two small pockets.
def mound(cx,cz,r,typ,region):
 y=h(cx,cz)
 if y>-4:return False
 if any(abs(cx-a)<r+6 and abs(cz-b)<r+6 for a,b,_ in houses):return False
 if get(cx,y+1,cz)!=A:return False
 base=STONE if typ==1 else DEEP;ore=COAL if typ==1 else RED
 # A small level quarry apron keeps every exposed node reachable on steep slopes.
 for dz in range(-r-1,r+2):
  for dx in range(-r-1,r+2):
   if math.hypot(dx,dz)<=r+1.4 and valid(cx+dx,cz+dz):
    box(cx+dx,LOW+1,cz+dz,cx+dx,y,cz+dz,base)
    box(cx+dx,y+1,cz+dz,cx+dx,0,cz+dz,A)
    H[cz+dz+152,cx+dx+152]=y
 for dz in range(-r,r+1):
  for dx in range(-r,r+1):
   d=math.hypot(dx,dz)
   if d<=r:
    yy=min(-1,y+max(1,round(3*(1-d/(r+1)))))
    box(cx+dx,y+1,cz+dz,cx+dx,yy,cz+dz,base)
 spots=[(cx-r,y+1,cz),(cx+r,y+1,cz),(cx,y+1,cz-r),(cx,y+1,cz+r)]
 if region=='south':spots=spots[:2]
 for x,oy,z in spots:
  oo=DC if region=='north' and typ==1 and R.random()<.3 else DR if region=='north' and typ==3 and R.random()<.3 else ore
  put(x,oy,z,oo);ores.append((x,oy,z,2 if oo==DC else 4 if oo==DR else typ,region))
 mounds.append((cx,cz,typ,region));return True
tries=0
while sum(m[3]=='north' for m in mounds)<18 and tries<5000:
 tries+=1;x=R.randint(-136,136);z=R.randint(-140,-58)
 if any(math.hypot(x-a,z-b)<14 for a,b,_,_ in mounds):continue
 if (x,z) in roads:continue
 mound(x,z,3,1 if x<0 else 3,'north')
for x,z,t in [(-139,5,1),(-41,18,3),(-21,46,1),(36,23,3),(57,-6,1),(128,54,3),(-21,-38,1),(116,-46,3)]:mound(x,z,2,t,'road')
for x,z,t in [(-26,71,1),(28,72,3)]:mound(x,z,2,t,'south')
# Solid city blocks at empty village plots: no entrance or usable interior.
WINDOW=b('gray_stained_glass',(105,136,146))
plots=[(x,z) for row,z in enumerate([-66,-46,-26,-6,14,34]) for col,x in enumerate([-132,-114,-96,-78,-60]) if (row+col)%2]
for i,(x,z) in enumerate(plots):
 if i%5==4:continue
 y=h(x,z);top=min(0,y+11+(i%2))
 box(x-4,LOW+1,z-4,x+4,top,z+4,BRICK if i%2 else ANDESITE)
 for floor in range(y+3,top,3):
  for dx in [-2,0,2]:
   for zz in [z-4,z+4]:put(x+dx,floor,zz,WINDOW)
  for dz in [-2,0,2]:
   for xx in [x-4,x+4]:put(xx,floor,z+dz,WINDOW)
 box(x-4,top,z-4,x+4,top,z+4,COPPER);buildings.append((x,z,y,top))
for x,z in [(-43,-25),(-43,28),(35,40),(12,54),(-28,55),(35,-20)]:
 y=h(x,z);box(x-3,y+1,z,x+3,min(0,y+3),z,MOSS)
# Winding forest trails link ruins through clustered woodland.
road([(43,-16),(55,-22),(60,-39),(75,-45),(89,-35),(98,-15),(118,-4),(126,15),(116,31),(96,37),(88,57),(70,69)],1)
road([(59,-39),(49,-58),(64,-78),(83,-82),(102,-65),(115,-47)],1)
# Dense eastern woodland; higher north slopes remain visibly exposed and snowy.
tries=0
while len(trees)<240 and tries<9000:
 tries+=1;x=R.randint(42,142);z=R.randint(-89,77);y=h(x,z)
 density=.50+.28*math.sin(x/13)*math.cos(z/18)+.20*math.sin((x+z)/9)
 if R.random()>density:continue
 if (x,z) in roads or any((x-a)**2+(z-b)**2<18 for a,b in trees):continue
 if any((x-a)**2+(z-b)**2<150 for a,b in [(72,-32),(113,11),(78,55)]):continue
 if any(abs(x-a)<7 and abs(z-b)<7 for a,b,_,_ in mounds):continue
 if get(x,y,z)!=GRASS or any(get(x,y+j,z)!=A for j in range(1,8)):continue
 ht=min(R.choice([8,9,10,10,11]),-y-1)
 if ht<4:continue
 box(x,y+1,z,x,y+ht,z,LOG)
 for dy,rr in [(ht-2,2),(ht-1,3),(ht,2),(ht+1,1)]:
  for dz in range(-rr,rr+1):
   for dx in range(-rr,rr+1):
    if dx*dx+dz*dz<=rr*rr+1 and get(x+dx,y+dy,z+dz)==A:put(x+dx,y+dy,z+dz,LEAF)
 trees.append((x,z))
 # Low foliage breaks ground-level sight lines beneath the raised canopy.
 for dx,dz in [(2,1),(-2,-1)]:
  if not any((x+dx-a)**2+(z+dz-b)**2<64 for a,b,_,_ in mounds):
   for dy in [1,2]:
    for ex in [-1,0,1]:
     if get(x+dx+ex,y+dy,z+dz)==A and (x+dx+ex,z+dz) not in roads:put(x+dx+ex,y+dy,z+dz,LEAF)
for x in range(-135,140,16):
 z=R.randint(-100,-80);y=h(x,z)
 if y>-7 or any(abs(x-a)<9 and abs(z-b)<9 for a,b,_ in houses):continue
 if any(abs(x-a)<8 and abs(z-b)<8 for a,b,_,_ in mounds):continue
 box(x,y+1,z,x,y+4,z,SLOG)
 for dy,rr in [(2,2),(3,2),(4,1),(5,0)]:
  for dz in range(-rr,rr+1):
   for dx in range(-rr,rr+1):
    if abs(dx)+abs(dz)<=rr+1 and get(x+dx,y+dy,z+dz)==A:put(x+dx,y+dy,z+dz,PINE)
 trees.append((x,z))
# Sight-line breaks outside roads, entrances and mining nodes.
for ox,oz in [(-44,-43),(-47,9),(-38,41),(20,44),(33,-42),(52,23),(87,64),(132,45),(-12,63),(-125,36),(-68,-36),(-108,-56)]:
 yy=h(ox,oz)
 if yy>-4 or any(abs(ox-a)<9 and abs(oz-b)<10 for a,b,_ in houses):continue
 if any(abs(ox-a)<8 and abs(oz-b)<8 for a,b,_,_ in mounds):continue
 for dx in range(-3,4):
  for dz in range(-1,2):
   xx,zz=ox+dx,oz+dz
   if (xx,zz) in roads or get(xx,h(xx,zz)+1,zz)!=A:continue
   for dy in [1,2]:put(xx,h(xx,zz)+dy,zz,MOSS if (dx+dz)%3 else COBBLE)
# Embedded road lights do not block movement or increase entity counts.
for ii,(xx,zz) in enumerate(sorted(roads)):
 if ii%41==0 and get(xx,h(xx,zz),zz) in [PATH,GRAVEL] and get(xx,h(xx,zz)+1,zz)==A:put(xx,h(xx,zz),zz,LIGHT)
for _ in range(600):
 x,z=R.randint(-140,140),R.randint(-95,78);y=h(x,z)
 if get(x,y,z)==GRASS and get(x,y+1,z)==A:put(x,y+1,z,R.choice(FLOWERS))
for i,(x,z,t,region) in enumerate(mounds):
 if i%4==0:
  xx=x+5;y=h(xx,z)
  if get(xx,y+1,z)==A:chest(xx,y+1,z,'ore_cache')
tries=0
while len(chests)<48 and tries<5000:
 tries+=1;x,z=R.randint(-139,139),R.randint(-139,86);y=h(x,z)
 if any((x-a)**2+(z-c)**2<13**2 for a,_,c,_ in chests):continue
 if abs(x)<20 and abs(z)<20:continue
 if get(x,y,z) not in [GRASS,STONE,SNOW,PATH,GRAVEL,SAND] or get(x,y+1,z)!=A or get(x,y+2,z)!=A:continue
 chest(x,y+1,z,'cache')
chests=[q for q in chests if get(q[0],q[1],q[2])==CHEST];oretypes={COAL:1,DC:2,RED:3,DR:4};ores=[q for q in ores if get(q[0],q[1],q[2]) in oretypes]
assert len(houses)==21 and len(chests)==48 and len(ores)>70
for x,y,z,t,reg in ores:assert get(x,y,z)=={1:COAL,2:DC,3:RED,4:DR}[t]
# Northern lake with a continuous shallow shelf and walkable banks on every side.
lake_cells=[]
for z in range(-69,-20):
 for x in range(-40,41):
  q=((x-1)/29)**2+((z+45)/14)**2
  edge=1+0.08*math.sin(x/5)+0.05*math.cos(z/3)
  q/=edge
  if q>1.6:continue
  if q>1:
   y=-11 if q<=1.3 else min(h(x,z),-10)
   box(x,y,z,x,0,z,A);put(x,y,z,GRAVEL if (x+z)%4 else SAND)
   H[z+152,x+152]=y
   continue
  floor=-15 if q<0.35 else -14 if q<0.55 else -13 if q<0.76 else -12
  box(x,floor,z,x,0,z,A);put(x,floor,z,GRAVEL if (x+z)%4 else SAND)
  box(x,floor+1,z,x,-11,z,WATER)
  H[z+152,x+152]=floor;lake_cells.append((x,z))
# Wide oak/spruce bridge with a gently raised central span and stair approaches.
FENCE=b('spruce_fence',(111,84,57),north='true',south='true',east='false',west='false',waterlogged='false')
LANTERN=b('lantern',(237,181,71),hanging='false',waterlogged='false')
STAIR_S=b('oak_stairs',(179,147,95),facing='south',half='bottom',shape='straight',waterlogged='false')
STAIR_N=b('oak_stairs',(179,147,95),facing='north',half='bottom',shape='straight',waterlogged='false')
SLAB=b('oak_slab',(179,147,95),type='top',waterlogged='false')
def bridge_x(z):return round(-14+(z+55)*14/55) if z>=-55 else round(-14+(z+55)*7/-47)
for z in range(-67,-22):
 cx=bridge_x(z)
 deck=-10 if z in [-24,-23] else -8 if -49<=z<=-39 else -9
 step=STAIR_S if z==-50 else STAIR_N if z in [-38,-25,-23] else OAK
 for dx in range(-3,4):
  box(cx+dx,deck,z,cx+dx,deck+3,z,A)
  put(cx+dx,deck,z,SPRUCE if abs(dx)==3 else SLAB if z==-67 else step)
 if -65<=z<=-25:
  for dx in [-3,3]:put(cx+dx,deck+1,z,FENCE)
 if z in [-61,-53,-45,-37,-29]:
  for dx in [-3,3]:
   box(cx+dx,h(cx+dx,z)+1,z,cx+dx,deck+1,z,SLOG)
   put(cx+dx,deck+2,z,LANTERN)
  box(cx-3,deck-1,z,cx+3,deck-1,z,SPRUCE)

# Keep the ore-cache chest displaced by the new lake on its western bank.
for ci,(cx,cy,cz,ck) in enumerate(chests):
 if get(cx,cy,cz)!=CHEST or get(cx,cy+1,cz)!=A:
  nx,nz=-33,-38;ny=h(nx,nz)+1
  put(nx,ny,nz,CHEST);put(nx,ny+1,nz,A)
  chests[ci]=(nx,ny,nz,ck)

# Move any ore node covered by the lake/bridge onto accessible nearby bank stone.
for oi,(ox,oy,oz,ot,oreg) in enumerate(ores):
 if get(ox,oy,oz) not in [COAL,RED,DC,DR]:
  nx,nz=-36,-44+oi%7;ny=h(nx,nz)
  put(nx,ny,nz,COAL if ot in [1,3] else RED)
  put(nx,ny+1,nz,A);put(nx,ny+2,nz,A)
  ores[oi]=(nx,ny,nz,ot,oreg)

# Eighteen spaced jump pads on safe natural terrain; no buildings/trees/ore overwritten.
pad_base=b('bricks',(157,85,65));pad_plate=b('stone_pressure_plate',(160,160,160),powered='false')
jump_pads=[]
def place_pad(px,pz):
 py=h(px,pz)
 if py>-4 or py<-14 or sea[pz+152,px+152]:return False
 if any((px-a)**2+(pz-c)**2<(32 if len(jump_pads)<18 else 24)**2 for a,_,c in jump_pads):return False
 if any(abs(px-cx)<6 and abs(pz-cz)<6 for cx,cy,cz,_ in chests):return False
 if any(abs(px-ox)<6 and abs(pz-oz)<6 for ox,oy,oz,*_ in ores):return False
 for dx in range(-1,2):
  for dz in range(-1,2):
   if abs(h(px+dx,pz+dz)-py)>1:return False
   if get(px+dx,h(px+dx,pz+dz),pz+dz) not in [GRASS,STONE,SNOW,PATH,GRAVEL,SAND]:return False
   if any(get(px+dx,py+dy,pz+dz)!=A for dy in [1,2,3]):return False
 box(px-1,py,pz-1,px+1,py,pz+1,pad_base)
 box(px-1,py+1,pz-1,px+1,py+3,pz+1,A)
 put(px,py+1,pz,pad_plate)
 put(px-1,py,pz-1,LIGHT);put(px+1,py,pz+1,LIGHT)
 jump_pads.append([px,py+1,pz]);return True
for px,pz in [(-36,0),(36,3),(5,40),(-14,-52),(-96,40),(111,22)]:place_pad(px,pz)
# Search a separate sector for each extra pad rather than clustering random positions.
for cx,cz in [(x,z) for z in [-105,-42,61] for x in [-120,-45,45,120]]:
 candidates=sorted([(x,z) for x in range(max(-140,cx-32),min(141,cx+33),2) for z in range(max(-140,cz-28),min(77,cz+29),2)],key=lambda q:(q[0]-cx)**2+(q[1]-cz)**2)
 for px,pz in candidates:
  if place_pad(px,pz):break
# Fill any sector rejected by obstacles using the largest available spacing first.
while len(jump_pads)<27:
 candidates=[(x,z) for x in range(-138,139,5) for z in range(-135,77,5)]
 candidates.sort(key=lambda q:min((q[0]-a)**2+(q[1]-c)**2 for a,_,c in jump_pads),reverse=True)
 if not any(place_pad(px,pz) for px,pz in candidates):raise AssertionError('Not enough safe pad sites')
assert len(jump_pads)==27
# Contain sea sources at the authored map edge. The water pass runs after all solid terrain.
for z in range(-152,153):
 for x in [-152,152]:
  if sea[z+152,x+152]:box(x,-19,z,x,-13,z,SAND)
for x in range(-152,153):
 if sea[304,x+152]:box(x,-19,152,x,-13,152,SAND)
# Fix approach direction and use the correct fence connection for each neighbor.
for z,yy,direction in [(-50,-9,'south'),(-38,-9,'north'),(-25,-9,'north'),(-24,-10,'north')]:
 for x in range(bridge_x(z)-2,bridge_x(z)+3):
  put(x,yy,z,b('oak_stairs',(179,147,95),facing=direction,half='bottom',shape='straight',waterlogged='false'))
for z in range(93,130):
 half=min(7,z-92,131-z)
 for x in (-78-half,-78+half):
  if get(x,-10,z)!=A and pal[get(x,-10,z)]['id']=='minecraft:oak_fence':
   flags={k:str(pal[get(x+dx,-10,z+dz)]['id'] in ['minecraft:oak_fence','minecraft:spruce_planks','minecraft:oak_planks']).lower() for k,dx,dz in [('north',0,-1),('south',0,1),('east',1,0),('west',-1,0)]}
   # Solid posts at the stepped bow/stern join otherwise diagonal rails.
   if half<7:put(x,-10,z,SLOG)
   else:put(x,-10,z,b('oak_fence',(153,115,66),**flags,waterlogged='false'))
# Boardable coastal sloop, with stepped stern and a low waterline swim ladder.
for x in range(48,69):
 w=min(4,1+min(x-48,68-x)//2)
 for z in range(98-w,99+w):
  for y in [-15,-14,-13,-12,-11]:
   put(x,y,z,SPRUCE if y<=-13 else OAK if y==-12 else A)
 for z in (98-w,98+w):
  put(x,-11,z,b('spruce_trapdoor',(100,70,49),facing='north' if z<98 else 'south',half='bottom',open='true',powered='false',waterlogged='false'))
box(56,-11,98,56,-2,98,SLOG)
box(56,-4,95,56,-4,101,SLOG)
for y in range(-8,-4):
 box(56,y,96,56,y,100,b('cyan_wool',(37,138,145)) if y==-6 else b('white_wool',(230,228,218)))
put(56,-2,99,b('red_wool',(174,46,44)))
for x,z in [(51,98),(63,97),(63,99)]:put(x,-11,z,BARREL)
put(64,-11,98,LANTERN)
for y in [-14,-13,-12,-11]:
 put(61,y,102,SLOG)
 put(61,y,103,b('ladder',(144,111,67),facing='south',waterlogged='false'))
chest(66,-11,98,'coastal_sloop')
# Mossy stepped jungle temple with an above-ground interior.
tx,tz,base=93,38,-11
moss_cob=b('mossy_cobblestone',(111,133,91))
box(tx-8,-19,tz-7,tx+8,base,tz+7,STONE)
box(tx-8,base+1,tz-7,tx+8,0,tz+7,A)
box(tx-8,base,tz-7,tx+8,base,tz+7,moss_cob)
for x in range(tx-7,tx+8):
 for z in range(tz-6,tz+7):
  if abs(x-tx)==7 or abs(z-tz)==6:
   if z==tz+6 and abs(x-tx)<=1:continue
   for y in range(base+1,base+6):put(x,y,z,moss_cob if (x+2*z+y)%4 else COBBLE)
for level in range(4):
 box(tx-7+level,base+6+level,tz-6+level,tx+7-level,base+6+level,tz+6-level,moss_cob if level%2==0 else COBBLE)
for x in (tx-7,tx+7):
 for z in (tz-6,tz+6):box(x,base+1,z,x,base+8,z,COBBLE)
for x in (tx-4,tx+4):
 put(x,base+1,tz-2,LANTERN)
 chest(x,base+1,tz-4,'forest_temple')
for x in range(tx-2,tx+3):
 put(x,base,tz+8,b('cobblestone_stairs',(123,123,123),facing='north',half='bottom',shape='straight',waterlogged='false'))
# Irregular sand shelf, mixed rock and a vegetated ridge inside the marked oval.
for z in range(116,151):
 for x in range(89,150):
  r=math.hypot((x-119)/29,(z-134+(x-119)*0.13)/15)
  r+=.065*math.sin(x*.43+z*.36)+.05*math.cos(z*.65-x*.2)
  if r>1.09:continue
  y=-15 if r>1 else -14 if r>.87 else -13 if r>.68 else -12 if r>.49 else -11 if r>.27 else -10
  for j in range(-18,y+1):
   put(x,j,z,SAND if r>.64 else GRASS if j==y else DIRT if j>=y-2 else STONE)
  H[z+152,x+152]=y
for x,z in [(111,132),(124,140),(132,129),(117,138)]:
 y=h(x,z)
 for dy in range(1,5):put(x+(dy>=3),y+dy,z,LOG)
 for dx in range(-3,4):
  for dz in range(-3,4):
   if abs(dx)+abs(dz)<=4:put(x+1+dx,y+5-(abs(dx)+abs(dz)>2),z+dz,LEAF)
for x,z in [(104,132),(122,137),(137,130)]:chest(x,h(x,z)+1,z,'island')
# Broad timber crossing on the marked corridor.
for z in range(65,124):
 deck=-11 if 69<=z<=120 else -12
 for x in range(110,119):
  box(x,deck+1,z,x,deck+3,z,A)
  put(x,deck,z,SPRUCE if x in (110,118) else OAK)
  if x in (110,118) and 68<=z<=121:put(x,deck+1,z,FENCE)
 if z%8==0:
  for x in (110,118):
   box(x,-18,z,x,deck+1,z,SLOG)
   put(x,deck+2,z,LANTERN)
for z,y,face in [(68,-12,'south'),(121,-12,'north')]:
 for x in range(111,118):put(x,y,z,b('oak_stairs',(179,147,95),facing=face,half='bottom',shape='straight',waterlogged='false'))
for z in range(124,129):
 for x in range(111,118):
  if h(x,z)<-12:box(x,-17,z,x,-12,z,SAND)
chest(117,-10,95,'island_bridge')

# Temple: broad projecting cornice, inset doorway and broken roof pinnacles.
for x in range(tx-8,tx+9):
 for z in range(tz-7,tz+8):
  if abs(x-tx)==8 or abs(z-tz)==7:
   for y in (base+3,base+4,base+5,base+6):
    put(x,y,z,moss_cob if (x*3+z+y)%5<3 else COBBLE)
for x,z in [(tx-7,tz+6),(tx+7,tz+6),(tx-7,tz-6),(tx+7,tz-6),(tx-4,tz+5),(tx+4,tz+5)]:
 box(x,base+6,z,x,base+(10 if abs(x-tx)==7 else 9),z,moss_cob)
for x in (tx-6,tx-3,tx+3,tx+6):
 box(x,base+2,tz+7,x,base+6,tz+7,moss_cob)
for x in (tx-5,tx+2,tx+5):
 for y in range(base+3,base+6):
  put(x,y,tz+8,b('vine',(68,104,45),north='true',south='false',east='false',west='false',up='false'))
# Align stair block tops to the upper deck, with full blocks underneath.
for z,face in [(68,'south'),(121,'north')]:
 for x in range(111,118):
  put(x,-12,z,OAK)
  put(x,-11,z,b('oak_stairs',(179,147,95),facing=face,half='bottom',shape='straight',waterlogged='false'))
put(117,-10,95,A)
chests[:]=[c for c in chests if c[3]!='island_bridge']
chest(114,-10,94,'island_bridge')
# Replace loose trapdoor rails with a shaped timber gunwale and continuous trim.
stripped=b('stripped_spruce_log',(126,97,65),axis='x')
for x in range(48,69):
 w=min(4,1+min(x-48,68-x)//2)
 for z in (98-w,98+w):
  if pal[get(x,-11,z)]['id']=='minecraft:spruce_trapdoor':put(x,-11,z,SPRUCE)
  put(x,-12,z,stripped)
for x,z in [(49,97),(49,100),(67,97),(67,100)]:
 put(x,-10,z,LANTERN)
put(61,-11,103,b('ladder',(144,111,67),facing='south',waterlogged='false'))
for y in range(-8,-4):
 for z in range(95,102):
  if abs(z-98)<=2+(y==-5):put(56,y,z,b('cyan_wool',(37,138,145)) if (z+y)%5==0 else b('white_wool',(230,228,218)))
# Framed cabin, light timber stripe and colored pennants on the large vessel.
for z in range(95,129):
 w=min(7,z-92,131-z)
 for x in (-78-w,-78+w):put(x,-12,z,stripped)
for x in (-83,-73):
 for z in (118,122,125):box(x,-10,z,x,-7,z,SLOG)
 for z in (120,123):put(x,-9,z,b('glass',(168,209,216)))
for z in range(116,128):
 for x,face in [(-84,'east'),(-72,'west')]:
  put(x,-6,z,b('spruce_stairs',(111,84,57),facing=face,half='bottom',shape='straight',waterlogged='false'))
for x,z in [(-84,106),(-72,106),(-84,114),(-72,114),(-82,128),(-74,128)]:
 put(x,-10,z,SLOG);put(x,-9,z,LANTERN)
for x in range(-81,-74):put(x,-6,109,b('light_blue_wool',(97,166,205)))
for x in (-77,-76,-75):put(x,0,110,b('blue_wool',(59,78,143)))

# Flush plaza inlays replace climbable columns, rim and raised planters.
gold_trim=b('waxed_cut_copper',(171,103,72))
dark_trim=b('polished_blackstone',(62,54,66))
quartz=b('smooth_quartz',(224,218,206))
for angle in range(360):
 a=math.radians(angle);x,z=round(17*math.cos(a)),round(17*math.sin(a))
 if get(x,-4,z) in (BRICK,LIGHT):put(x,-4,z,A)
for x,z in [(round(17*math.cos(math.radians(a))),round(17*math.sin(math.radians(a)))) for a in range(0,360,45)]+[(-29,0),(29,0),(0,-29),(0,29)]:
 for y in range(-10,-4):
  if get(x,y,z) in (BRICK,LIGHT):put(x,y,z,A)
for x,z in [(-18,-18),(18,-18),(-18,18),(18,18)]:
 box(x-3,-10,z-3,x+3,-8,z+3,A)
 for xx in range(x-3,x+4):
  for zz in range(z-3,z+4):
   dx,dz=abs(xx-x),abs(zz-z)
   put(xx,-11,zz,LIGHT if dx+dz==0 else gold_trim if dx+dz==3 else dark_trim if max(dx,dz)==3 else quartz)
for x,z in [(-14,8),(14,8),(-14,-7),(14,-7)]:
 box(x-2,-10,z,x+2,-9,z,A)
for z in range(-24,25):
 for x in range(-24,25):
  d=math.hypot(x,z)
  if 8.7<=d<=9.4 or 16.5<=d<=17.4 or 22.7<=d<=23.5:
   put(x,-11,z,LIGHT if (x+z)%11==0 else gold_trim if abs(x*z)%4==0 else dark_trim)
for x,z in [(-12,-12),(12,-12),(-12,12),(12,12)]:
 put(x,-11,z,quartz)
 chest(x,-10,z,'plaza_new')
# Set the stair top against the higher deck and rebuild the south landing.
for z,yy,face in [(-50,-8,'south'),(-38,-8,'north'),(-25,-9,'north'),(-23,-10,'north')]:
 for x in range(bridge_x(z)-2,bridge_x(z)+3):
  put(x,yy-1,z,OAK)
  put(x,yy,z,b('oak_stairs',(179,147,95),facing=face,half='bottom',shape='straight',waterlogged='false'))
  for y in (yy+1,yy+2):put(x,y,z,A)
for z,y in [(-24,-10),(-22,-11),(-21,-11),(-20,-11),(-19,-11)]:
 cx=bridge_x(z)
 for x in range(cx-2,cx+3):
  put(x,y,z,OAK if z==-24 else BRICK)
  for yy in range(y+1,y+4):put(x,yy,z,A)
# Offset, taper and branch the forest crowns without overwriting paths or buildings.
for x,z in trees:
 if x<42 or z>77:continue
 y=h(x,z)
 if get(x,y+1,z)!=LOG:continue
 ys=[yy for yy in range(y+1,0) if get(x,yy,z)==LOG]
 if len(ys)<4:continue
 top=max(ys)
 for i,(dx,dz) in enumerate([(1,0),(0,1),(-1,0),(0,-1)]):
  if (x+z+i)%5==0:continue
  by=top-3+(x+z+i)%2
  reach=2+(x-z+i)%2
  for step in range(1,reach+1):
   xx,zz=x+dx*step,z+dz*step
   yy=by+(step>1)
   if get(xx,yy,zz) in (A,LEAF):
    put(xx,yy,zz,b('oak_log',(117,88,52),axis='x' if dx else 'z'))
  bx,bz=x+dx*reach,z+dz*reach
  for yy in range(by, min(1,by+5)):
   for ox in range(-2,3):
    for oz in range(-2,3):
     if ox*ox+oz*oz+(yy-by-2)**2>5+(x+z+i)%3:continue
     if get(bx+ox,yy,bz+oz)==A:put(bx+ox,yy,bz+oz,LEAF)
# The island bridge gets deck marquetry and inset lighting, with no tall posts.
for z in range(69,121):
 for x in (111,117):
  put(x,-11,z,LIGHT if z%8==0 else b('dark_oak_planks',(79,56,35)))
 if z%8==0:
  for x in (110,118):
   put(x,-9,z,A)
   put(x,-10,z,FENCE)
 for x in range(112,117):
  if (z+x)%8==0 and (x,z)!=(114,94):put(x,-11,z,b('stripped_spruce_log',(126,97,65),axis='z'))

# Low stone-brick enclosure around the plaza, with four generous approaches.
for z in range(-25,26):
 for x in range(-25,26):
  d=math.hypot(x,z)
  if not (23.7<=d<=24.6) or min(abs(x),abs(z))<=4:continue
  put(x,-11,z,BRICK)
  put(x,-10,z,b('stone_brick_slab',(147,151,146),type='bottom',waterlogged='false') if (x+z)%5 else b('mossy_stone_brick_slab',(121,141,103),type='bottom',waterlogged='false'))
# Lake banks: broken bands of cobble, gravel and low reed beds.
for z in range(-65,-23):
 for x in range(-36,38):
  if abs(x-bridge_x(z))<6:continue
  y=h(x,z)
  if get(x,y,z) not in (SAND,GRAVEL,STONE,GRASS):continue
  if not any(get(x+dx,y,z+dz)==WATER for dx,dz in [(1,0),(-1,0),(0,1),(0,-1)]):continue
  if any(abs(x-a)<=2 and abs(z-c)<=2 for a,_,c,_ in chests):continue
  put(x,y,z,[GRAVEL,COBBLE,b('mossy_cobblestone',(111,133,91)),ANDESITE][(x*7+z*13)%4])
  if (x+2*z)%11==0 and get(x,y+1,z)==A:put(x,y+1,z,b('short_grass',(92,135,64)))
# Low bridge rails, contrasting timber joints and exposed structural braces.
for z in range(69,121):
 if z%6 not in (0,1):continue
 for x in (110,118):
  put(x,-11,z,b('stripped_dark_oak_log',(89,63,40),axis='z'))
  put(x,-10,z,b('dark_oak_fence',(89,63,40),north='true',south='true',east='false',west='false',waterlogged='false'))
  if z%6==0:put(x,-12,z,b('spruce_stairs',(111,84,57),facing='east' if x==110 else 'west',half='top',shape='straight',waterlogged='false'))
# Single mast and two extra access points from the water.
box(58,-10,98,58,-6,98,A)
for x in (57,63):
 for y in range(-14,-10):
  put(x,y,94,SPRUCE)
  put(x,y,93,b('ladder',(144,111,67),facing='north',waterlogged='true' if y<=-14 else 'false'))
# Varied, asymmetrical cover placed on empty terrain away from existing routes.
covers=[]
for cx,cz in [(-113,-45),(-56,-40),(-30,46),(-85,65),(29,48),(68,57),(105,58),(121,-31),(41,-67),(-48,-90),(64,-90),(11,-70),(-59,7),(57,12),(97,-65),(119,38)]:
 candidates=sorted(((x,z) for x in range(cx-13,cx+14) for z in range(cz-13,cz+14)),key=lambda q:(q[0]-cx)**2+(q[1]-cz)**2)
 for x,z in candidates:
  y=h(x,z)
  if y>-6 or sea[z+152,x+152] or math.hypot(x,z)<36:continue
  if any(abs(x-a)<=6 and abs(z-c)<=6 for a,_,c,*_ in chests+ores+jump_pads+covers):continue
  if any((xx,zz) in roads or abs(h(xx,zz)-y)>1 or any(get(xx,y+j,zz)!=A for j in (1,2,3)) for xx in range(x-2,x+3) for zz in range(z-2,z+3)):continue
  style=len(covers)%4
  for dx,dz,n in [[(-2,0,1),(-1,0,2),(-1,1,2),(0,1,1),(1,1,1),(2,1,1)], [(-2,-1,1),(-1,-1,2),(0,-1,2),(1,-1,1),(1,0,1),(1,1,2)], [(-2,0,1),(-1,0,2),(0,0,2),(0,1,1),(1,1,1),(1,2,1)], [(-2,-1,1),(-1,-1,2),(-1,0,1),(-1,1,2),(0,1,1),(1,1,1)]][style]:
   xx,zz=x+dx,z+dz; floor=h(xx,zz)
   mats=[(COBBLE,ANDESITE,GRAVEL),(MOSS,CRACK,BRICK),(SLOG,SPRUCE,BARREL),(SPRUCE,BARREL,LOG)][style]
   for dy in range(n):put(xx,floor+1+dy,zz,mats[(dx+dz+dy)%3])
  covers.append((x,y,z));break
print('Extra cover sites:',len(covers),flush=True)

def fn(n,s):q=F/(n+'.mcfunction');q.parent.mkdir(parents=True,exist_ok=True);q.write_text(s.strip()+'\n')
def js(q,v):q.parent.mkdir(parents=True,exist_ok=True);q.write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
def text(s):bb=s.encode();return struct.pack('>H',len(bb))+bb
def integer(n):return struct.pack('>i',int(n))
def tag(t,n,v):return bytes([t])+text(n)+v
def compound(fs):return b''.join(tag(t,n,v) for t,n,v in fs)+b'\0'
def ilist(v):return b'\x03'+integer(len(v))+b''.join(integer(x) for x in v)
def clist(v):return b'\x0a'+integer(len(v))+b''.join(v)
palette=[]
for ent in pal:
 fs=[(8,'id',text(ent['id']))]
 if 'properties' in ent:fs.append((10,'properties',compound([(8,k,text(v)) for k,v in ent['properties'].items()])))
 palette.append(compound(fs))
tiles=[];blocks=0
for z0 in range(0,N,32):
 for x0 in range(0,N,32):
  idx=len(tiles);w,d=min(32,N-x0),min(32,N-z0);x,z=x0-152,z0-152;x1,z1=x+w-1,z+d-1;arr=V[:,z0:z0+d,x0:x0+w];poses=np.argwhere((arr!=A)&(arr!=WATER));blocks+=len(poses);body=[]
  for yy,zz,xx in poses:
   state=int(arr[yy,zz,xx]);fs=[(9,'pos',ilist([xx,yy,zz])),(3,'state',integer(state))]
   if state in [CHEST,BARREL,FURNACE]:fs.append((10,'nbt',compound([(8,'id',text('minecraft:chest' if state==CHEST else 'minecraft:barrel' if state==BARREL else 'minecraft:furnace'))])))
   body.append(compound(fs))
  raw=tag(10,'',compound([(3,'DataVersion',integer(5023)),(9,'size',ilist([w,NY,d])),(9,'palette',clist(palette)),(9,'blocks',clist(body)),(9,'entities',clist([]))]));(S/f'{idx}.nbt').write_bytes(gzip.compress(raw,mtime=0))
  # Sampling every 16 blocks plus the last edge covers up to 3x3 chunks for any anchor alignment.
  xs=sorted(set([x,x+min(16,w-1),x1]));zs=sorted(set([z,z+min(16,d-1),z1]));points=[(xx,zz) for xx in xs for zz in zs]
  watercmd=[]
  for yy in range(NY):
   for zz in range(d):
    xx=0
    while xx<w:
     if arr[yy,zz,xx]!=WATER:xx+=1;continue
     end=xx
     while end+1<w and arr[yy,zz,end+1]==WATER:end+=1
     watercmd.append(f'fill ~{x+xx} ~{yy+LOW} ~{z+zz} ~{x+end} ~{yy+LOW} ~{z+zz} minecraft:water');xx=end+1
  fn(f'tiles/water/{idx}','\n'.join(watercmd) if watercmd else '# No water in this tile.')
  pre=[]
  if not watercmd:pre.append('execute if score #mode oa.map2 matches 2 run return run function oa_map2:job/skip_water')
  pre += [f'execute store success score #had{i} oa.map2 run forceload query ~{xx} ~{zz}' for i,(xx,zz) in enumerate(points)]
  pre += [f'forceload add ~{x} ~{z} ~{x1} ~{z1}','data modify storage oa_map2:job holding set value 1b','schedule function oa_map2:job/wait 1t replace'];fn(f'tiles/preload/{idx}','\n'.join(pre))
  wait=['scoreboard players set #ready oa.map2 1']+[f'execute unless loaded ~{xx} ~0 ~{zz} run scoreboard players set #ready oa.map2 0' for xx,zz in points]+['execute if score #ready oa.map2 matches 0 run return run schedule function oa_map2:job/wait 2t replace',f'function oa_map2:tiles/apply/{idx}'];fn(f'tiles/wait/{idx}','\n'.join(wait))
  rel=[f'execute if score #had{i} oa.map2 matches 0 run forceload remove ~{xx} ~{zz}' for i,(xx,zz) in enumerate(points)]+['data modify storage oa_map2:job holding set value 0b'];fn(f'tiles/release/{idx}','\n'.join(rel))
  # Direct horizontal runs avoid template decoding/placement dependencies.
  # Merge identical runs through adjacent Z rows to limit commands per tick.
  place=['scoreboard players set #stage oa.map2 1',f'fill ~{x} ~-20 ~{z} ~{x1} ~0 ~{z1} minecraft:air']
  runs={}
  for yy in range(NY):
   for zz in range(d):
    xx=0
    while xx<w:
     state=int(arr[yy,zz,xx]);end=xx
     while end+1<w and int(arr[yy,zz,end+1])==state:end+=1
     if state not in [A,WATER]:runs.setdefault((yy,xx,end,state),[]).append(zz)
     xx=end+1
  for (yy,xx,end,state),rows in runs.items():
   ent=pal[state];block=ent['id']
   if ent.get('properties'):block+='['+','.join(k+'='+v for k,v in ent['properties'].items())+']'
   start=last=rows[0]
   for row in rows[1:]+[d+1]:
    if row==last+1:last=row;continue
    place.append(f'fill ~{x+xx} ~{yy+LOW} ~{z+start} ~{x+end} ~{yy+LOW} ~{z+last} {block}')
    start=last=row
  for zz in range(z,z+d,16):
   for xx in range(x,x+w,16):
    ww,dd=min(16,x+w-xx),min(16,z+d-zz);cx,cz=xx+ww/2,zz+dd/2
    biome='plains' if cz<-55 else 'ocean' if cz>83+7*math.sin(cx/22)+3*math.cos(cx/45)+3 else 'beach' if cz>73+7*math.sin(cx/22)+3*math.cos(cx/45) else 'forest' if cx>38 else 'plains'
    place.append(f'fillbiome ~{xx} ~-20 ~{zz} ~{xx+ww-1} ~8 ~{zz+dd-1} minecraft:{biome}')
  fn(f'tiles/place/{idx}','\n'.join(place))
  lc=[q for q in chests if x<=q[0]<=x1 and z<=q[2]<=z1];lo=[q for q in ores if x<=q[0]<=x1 and z<=q[2]<=z1]
  waterapply=[f'function oa_map2:tiles/water/{idx}',f'function oa_map2:tiles/release/{idx}','scoreboard players add #tile oa.map2 1','execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2','execute if score #tile oa.map2 matches 100.. run return run function oa_map2:job/finish','schedule function oa_map2:job/next 1t replace'];fn(f'tiles/water_apply/{idx}','\n'.join(waterapply))
  apply=[f'execute if score #mode oa.map2 matches 2 run return run function oa_map2:tiles/water_apply/{idx}',f'execute if score #mode oa.map2 matches 0 run function oa_map2:tiles/place/{idx}','execute if score #state oa.map2 matches 2 run return 0',f'execute positioned ~{x} ~-20 ~{z} run kill @e[type=minecraft:marker,tag=br.chest,dx={w-1},dy=20,dz={d-1}]',f'execute positioned ~{x} ~-20 ~{z} run kill @e[type=minecraft:marker,tag=br.ore,dx={w-1},dy=20,dz={d-1}]','scoreboard players set #stage oa.map2 2',f'scoreboard players set #expectedc oa.map2 {len(lc)}',f'scoreboard players set #expectedo oa.map2 {len(lo)}','scoreboard players set #localc oa.map2 0','scoreboard players set #localo oa.map2 0']
  for cx,cy,cz,k in lc:
   apply.append(f'execute positioned ~{cx} ~{cy} ~{cz} if block ~ ~ ~ minecraft:chest align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa_map2:register/chest')
   apply.append(f'execute if score #mode oa.map2 matches 0 positioned ~{cx} ~{cy} ~{cz} if block ~ ~ ~ minecraft:chest run loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic')
  for cx,cy,cz,t,reg in lo:apply.append(f'execute positioned ~{cx} ~{cy} ~{cz} if block ~ ~ ~ minecraft:{ {1:"coal_ore",2:"deepslate_coal_ore",3:"redstone_ore",4:"deepslate_redstone_ore"}[t]} align xyz positioned ~0.5 ~0.5 ~0.5 summon minecraft:marker run function oa_map2:register/ore_{t}')
  apply += [f'execute unless score #localc oa.map2 matches {len(lc)} run return run function oa_map2:job/failed',f'execute unless score #localo oa.map2 matches {len(lo)} run return run function oa_map2:job/failed','scoreboard players operation #chests oa.map2 += #localc oa.map2','scoreboard players operation #ores oa.map2 += #localo oa.map2',f'function oa_map2:tiles/release/{idx}','scoreboard players add #tile oa.map2 1','execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2']
  if idx%10==9:apply.append(f'tellraw @a {{text:"[OA Map 305] {idx+1}/100 区画完了",color:"aqua"}}')
  apply+=['execute if score #tile oa.map2 matches 100.. run return run function oa_map2:job/finish','schedule function oa_map2:job/next 1t replace'];fn(f'tiles/apply/{idx}','\n'.join(apply));tiles.append({'tile':idx,'x':x,'z':z,'w':w,'d':d,'blocks':len(poses),'water_commands':len(watercmd),'chests':len(lc),'ores':len(lo),'force_points':points})
js(PACK/'pack.mcmeta',{'pack':{'description':'OA BR 305×305 四地方マップ v1.6.0 / Java26.3 / 地形Y-20〜Y','min_format':[121,0],'max_format':[121,0]}})
js(PACK/'data/minecraft/tags/function/load.json',{'values':['oa_map2:load']});js(PACK/'data/minecraft/tags/function/tick.json',{'values':['oa_map2:weather']})
fn('load','''scoreboard objectives add oa.map2 dummy
scoreboard players add #state oa.map2 0
schedule clear oa_map2:job/next
schedule clear oa_map2:job/wait
execute if score #state oa.map2 matches 1 run schedule function oa_map2:job/wait 2t replace''')
fn('start','''execute unless entity @s[type=minecraft:player] run return 0
execute at @s unless dimension minecraft:overworld run return run tellraw @s {text:"オーバーワールドで実行してください",color:"red"}
execute unless score #state oa.map2 matches 0 run return run tellraw @s {text:"生成済み／生成中です。状態はoa_map:status、登録し直しはoa_map:register_all",color:"red"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"BR本体v0.13.5を導入し、試合を停止してください",color:"red"}
execute store result score #y oa.map2 run data get entity @s Pos[1]
execute unless score #y oa.map2 matches 0..250 run return run tellraw @s {text:"基準Yは0〜250で指定してください",color:"red"}
execute at @s align xyz run summon minecraft:marker ~ ~ ~ {Tags:["oa_map2.origin_temp"]}
data modify storage oa_map2:args x set from entity @e[type=minecraft:marker,tag=oa_map2.origin_temp,limit=1] Pos[0]
data modify storage oa_map2:args y set from entity @e[type=minecraft:marker,tag=oa_map2.origin_temp,limit=1] Pos[1]
data modify storage oa_map2:args z set from entity @e[type=minecraft:marker,tag=oa_map2.origin_temp,limit=1] Pos[2]
execute store result score #y oa.map2 run data get entity @e[type=minecraft:marker,tag=oa_map2.origin_temp,limit=1] Pos[1]
scoreboard players remove #y oa.map2 10
execute store result storage oa_map2:args center_y int 1 run scoreboard players get #y oa.map2
kill @e[type=minecraft:marker,tag=oa_map2.origin_temp]
scoreboard players set #mode oa.map2 0
data modify storage oa_map2:job holding set value 0b
function oa_map2:job/begin''')
fn('job/begin','''scoreboard players set #state oa.map2 1
scoreboard players set #tile oa.map2 0
scoreboard players set #chests oa.map2 0
scoreboard players set #ores oa.map2 0
data modify storage oa_map2:args tile set value 0
data modify storage oa_map2:job working set value 1b
tellraw @a {text:"[OA Map 305] 処理開始。完了まで試合を開始しないでください。全100区画",color:"gold"}
function oa_map2:job/next''')
fn('register_all','''execute unless score #state oa.map2 matches 3 run return run tellraw @s {text:"生成完了後に実行してください。停止中はresume",color:"red"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合を停止してから実行してください",color:"red"}
scoreboard players set #mode oa.map2 1
function oa_map2:job/begin''')
for phase,sub in [('next','preload'),('wait','wait'),('release','release')]:fn(f'job/dispatch_{phase}',f'$execute in minecraft:overworld positioned $(x) $(y) $(z) align xyz run function oa_map2:tiles/{sub}/$(tile)')
fn('job/next','''execute unless score #state oa.map2 matches 1 run return 0
execute if score #tile oa.map2 matches 100.. run return run function oa_map2:job/finish
execute unless score #state br.state matches 0 run return run function oa_map2:pause
function oa_map2:job/dispatch_next with storage oa_map2:args''')
fn('job/wait','''execute unless score #state oa.map2 matches 1 run return 0
execute unless score #state br.state matches 0 run return run function oa_map2:pause
execute unless data storage oa_map2:job {holding:1b} run return run function oa_map2:job/next
function oa_map2:job/dispatch_wait with storage oa_map2:args''')
fn('pause','''execute unless score #state oa.map2 matches 1 run return 0
schedule clear oa_map2:job/next
schedule clear oa_map2:job/wait
execute if data storage oa_map2:job {holding:1b} run function oa_map2:job/dispatch_release with storage oa_map2:args
scoreboard players set #state oa.map2 2
tellraw @a {text:"[OA Map 305] 停止しました。再開は /function oa_map:resume",color:"yellow"}''')
fn('resume','''execute unless score #state oa.map2 matches 2 run return 0
execute unless score #state br.state matches 0 run return 0
scoreboard players set #state oa.map2 1
function oa_map2:job/next''')
fn('job/failed','''function oa_map2:pause
tellraw @a [{text:"[OA Map 305] 停止区画 ",color:"red"},{score:{name:"#tile",objective:"oa.map2"}},{text:" / 処理段階 "},{score:{name:"#stage",objective:"oa.map2"}},{text:"（1=配置、2=登録）"}]
tellraw @a [{text:"チェスト 登録/予定: ",color:"yellow"},{score:{name:"#localc",objective:"oa.map2"}},{text:"/"},{score:{name:"#expectedc",objective:"oa.map2"}},{text:" 鉱石 登録/予定: "},{score:{name:"#localo",objective:"oa.map2"}},{text:"/"},{score:{name:"#expectedo",objective:"oa.map2"}},{text:"。修正後 /function oa_map:resume"}]''')
fn('register/chest','''tag @s add br.chest
tag @s add oa_map2.registered
scoreboard players set @s br.round -1
scoreboard players set @s br.cstage 0
execute if entity @s[tag=br.chest] if score @s br.round matches -1 if score @s br.cstage matches 0 run scoreboard players add #localc oa.map2 1''')
for typ in [1,2,3,4]:fn(f'register/ore_{typ}',f'''tag @s add br.ore
tag @s add oa_map2.registered
scoreboard players set @s br.ore {typ}
scoreboard players set @s br.regen 0
scoreboard players set @s br.round -1
execute if entity @s[tag=br.ore] if score @s br.ore matches {typ} if score @s br.regen matches 0 run scoreboard players add #localo oa.map2 1''')
fn('job/skip_water','''scoreboard players add #tile oa.map2 1
execute store result storage oa_map2:args tile int 1 run scoreboard players get #tile oa.map2
function oa_map2:job/next''')
fn('job/start_water','''scoreboard players set #mode oa.map2 2
scoreboard players set #tile oa.map2 0
data modify storage oa_map2:args tile set value 0
tellraw @a {text:"[OA Map 305] 地形・登録完了。最後に海水を配置します",color:"aqua"}
schedule function oa_map2:job/next 1t replace''')
fn('job/finish','''execute if score #mode oa.map2 matches 0 run return run function oa_map2:job/start_water
scoreboard players set #state oa.map2 3
data modify storage oa_map2:job working set value 0b
function oa_map2:center with storage oa_map2:args
tellraw @a [{text:"[OA Map 305] 完了！登録成功 チェスト ",color:"green"},{score:{name:"#chests",objective:"oa.map2"}},{text:"個 / 鉱石 "},{score:{name:"#ores",objective:"oa.map2"}},{text:"個。BR中心も設定しました。"}]
execute as @a at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 0.6 1''')
fn('center','''data modify storage oa:br center set value {dim:"minecraft:overworld",yaw:0.0f,pitch:0.0f}
$data modify storage oa:br center.x set value $(x)
$data modify storage oa:br center.z set value $(z)
$data modify storage oa:br center.y set value $(center_y)
$execute in minecraft:overworld positioned $(x) $(y) $(z) summon minecraft:marker run function oa_map2:read_center''')
fn('read_center','''execute store result score #cx br.x run data get entity @s Pos[0] 1000
execute store result score #cz br.z run data get entity @s Pos[2] 1000
kill @s''')
fn('status','''tellraw @s [{text:"[OA Map 305] 状態 ",color:"aqua"},{score:{name:"#state",objective:"oa.map2"}},{text:"（0未生成/1処理中/2停止/3完成） 区画 "},{score:{name:"#tile",objective:"oa.map2"}},{text:"/100 登録成功：チェスト "},{score:{name:"#chests",objective:"oa.map2"}},{text:" / 鉱石 "},{score:{name:"#ores",objective:"oa.map2"}}]''')
fn('rebuild','''execute unless data storage oa_map2:args center_y run return run tellraw @s {text:"先にoa_map:startで中心を登録してください",color:"red"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"先に試合を停止してください",color:"red"}
function oa_map2:pause
scoreboard players set #mode oa.map2 0
function oa_map2:job/begin''')
for name in ['start','pause','resume','status','register_all','rebuild']:
 q=PACK/f'data/oa_map/function/{name}.mcfunction';q.parent.mkdir(parents=True,exist_ok=True);q.write_text(f'function oa_map2:{name}\n')
fn('weather','''execute unless score #state oa.map2 matches 3 run return 0
scoreboard players add #snow oa.map2 1
execute if score #snow oa.map2 matches 10.. as @a[tag=br.playing] at @s if dimension minecraft:overworld if biome ~ ~ ~ minecraft:snowy_plains run particle minecraft:snowflake ~ ~4 ~ 5 2 5 0.01 14 normal @s
execute if score #snow oa.map2 matches 10.. run scoreboard players set #snow oa.map2 0''')
manifest={'version':'1.9.14','size':[305,305],'y_range':[-20,0],'center_ground_y':-11,'selected_y_is_upper_plane':True,'tiles':len(tiles),'blocks':blocks,'houses':len(houses),'solid_buildings':buildings,'ship':ship,'jump_pads':jump_pads,'trees':len(trees),'chests':len(chests),'ore_nodes':len(ores),'ore_by_region':{reg:sum(o[4]==reg for o in ores) for reg in ['north','road','south']},'chest_locations':chests,'ore_locations':ores,'mounds':mounds,'palette':pal}
js(PACK/'MAP_MANIFEST.json',manifest);js(ROOT/'tiles.json',tiles);np.savez_compressed(ROOT/'source_voxels.npz',voxels=V,height=H,palette=json.dumps(pal))
# Top-down preview is the actual block layout.
top=NY-1-np.argmax((V[::-1]!=A)&(V[::-1]!=BARRIER),axis=0);mat=V[top,np.arange(N)[:,None],np.arange(N)[None,:]];rgb=np.array(cols,float)[mat];gz,gx=np.gradient(top.astype(float));rgb=np.clip(rgb*np.clip(.97-.06*gx-.08*gz,.65,1.13)[:,:,None],0,255).astype(np.uint8)
im=Image.fromarray(rgb).resize((1050,1050),Image.Resampling.NEAREST);c=Image.new('RGB',(1370,1190),(23,31,34));c.paste(im,(28,90));dr=ImageDraw.Draw(c);font='/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf';ft=ImageFont.truetype(font,24);sm=ImageFont.truetype(font,14)
dr.text((28,22),'OA BATTLE ROYALE  /  305 x 305  /  FOUR REGIONS',font=ft,fill='#f0e7d0');dr.text((28,57),'Actual block data | North: mountains / South: coast / East: forest / West: town',font=sm,fill='#bcc9bc')
for x,y,z,k in chests:
 px,pz=28+(x+152)*(1050/305),90+(z+152)*(1050/305);dr.rectangle((px-2,pz-2,px+2,pz+2),fill='#ffe274')
for i,line in enumerate(['NORTH','Rocky hills + ore pockets','Snow biome in far north','','SOUTH','Sea, sand beach, pier','Large ship + interior','','EAST','Dense forest, 3 small ruins','','WEST','Large town + market','Harbor homes','','CENTER','Decorative open plaza','Brick columns + OA floor','','Houses: '+str(len(houses)),'Chests: '+str(len(chests)),'Ore nodes: '+str(len(ores)),'Trees: '+str(len(trees)),'','All blocks: selected Y-20..Y','100 staged placement tiles','Yellow dots: loot chests']):dr.text((1097,100+i*34),line,font=sm,fill='#d9e2d0')
dr.text((28,1152),'Fixed layout | No concept art | Vanilla Java 26.3',font=sm,fill='#c5cdbc');c.save(OUT/'OA_BR_Map_Overview.png');shutil.copyfile(OUT/'OA_BR_Map_Overview.png',PACK/'MAP_OVERVIEW.png')
print({k:manifest[k] for k in ['size','tiles','blocks','houses','trees','chests','ore_nodes','ore_by_region']},flush=True)
