from pathlib import Path
p=Path('map300_project/build.py');s=p.read_text();a=s.index('# Six real jump pads:');b=s.index('# Contain sea sources',a)
s=s[:a]+'''# Eighteen spaced jump pads on safe natural terrain; no buildings/trees/ore overwritten.
pad_base=b('bricks',(157,85,65));pad_plate=b('stone_pressure_plate',(160,160,160),powered='false')
jump_pads=[]
def place_pad(px,pz):
 py=h(px,pz)
 if py>-4 or py<-14 or sea[pz+152,px+152]:return False
 if any((px-a)**2+(pz-c)**2<32**2 for a,_,c in jump_pads):return False
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
while len(jump_pads)<18:
 candidates=[(x,z) for x in range(-138,139,5) for z in range(-135,77,5)]
 candidates.sort(key=lambda q:min((q[0]-a)**2+(q[1]-c)**2 for a,_,c in jump_pads),reverse=True)
 if not any(place_pad(px,pz) for px,pz in candidates):raise AssertionError('Not enough safe pad sites')
assert len(jump_pads)==18
''' +s[b:];s=s.replace("'version':'1.6.0'","'version':'1.6.2'");p.write_text(s)
