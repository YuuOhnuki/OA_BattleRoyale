from pathlib import Path
p=Path('map300_project/build.py');s=p.read_text();needle='# Contain sea sources at the authored map edge.'
extra='''# Six real jump pads: imported jumppad pack detects pressure plate over bricks.
pad_base=b('bricks',(157,85,65));pad_plate=b('stone_pressure_plate',(160,160,160),powered='false')
jump_pads=[]
for px,pz in [(-36,0),(36,3),(5,40),(-14,-52),(-96,40),(111,22)]:
 py=h(px,pz)
 if py>-4 or any(abs(px-cx)<5 and abs(pz-cz)<5 for cx,cy,cz,_ in chests):continue
 box(px-1,py,pz-1,px+1,py,pz+1,pad_base)
 box(px-1,py+1,pz-1,px+1,py+3,pz+1,A)
 put(px,py+1,pz,pad_plate)
 put(px-1,py,pz-1,LIGHT);put(px+1,py,pz+1,LIGHT)
 jump_pads.append([px,py+1,pz])
'''
s=s.replace(needle,extra+needle);s=s.replace("'trees':len(trees)","'jump_pads':jump_pads,'trees':len(trees)");s=s.replace('1.4.0','1.6.0');p.write_text(s)
p=Path('map300_project/validate.py');p.write_text(p.read_text().replace('1.4.0','1.6.0'))
