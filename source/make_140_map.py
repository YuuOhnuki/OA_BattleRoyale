from pathlib import Path
p=Path('map300_project/build.py');s=p.read_text().replace('1.1.0','1.4.0').replace('while len(trees)<175','while len(trees)<240')
needle='for _ in range(600):'
extra='''# Sight-line breaks outside roads, entrances and mining nodes.
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
'''
s=s.replace(needle,extra+needle);p.write_text(s)
p=Path('map300_project/validate.py');p.write_text(p.read_text().replace('1.1.0','1.4.0'))
