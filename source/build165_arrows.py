from pathlib import Path
import json,re,zipfile,shutil
p=Path('revision/pack')
for name,chance,lo,hi in [('chest_basic',50,1,3),('chest_upgraded',65,2,5)]:
 f=p/f'data/oa/loot_table/br/{name}.json';j=json.loads(f.read_text())
 for pool in j['pools']:
  if any(e.get('name')=='minecraft:arrow' for e in pool['entries']):
   for e in pool['entries']:
    if e.get('name')=='minecraft:arrow':
     e['weight']=chance
     for mod in e['modifier']:
      if mod['type']=='minecraft:set_count':mod['count']={'type':'minecraft:uniform','min':lo,'max':hi}
    elif e['type']=='minecraft:empty':e['weight']=100-chance
 f.write_text(json.dumps(j,ensure_ascii=False,indent=2))
for f in p.rglob('*'):
 if f.is_file() and f.suffix in ['.md','.mcmeta','.mcfunction']:
  s=f.read_text();t=s.replace('1.6.4','1.6.5').replace('| 矢 | 75.0000% | 1〜5 |','| 矢 | 50.0000% | 1〜3 |').replace('| 矢 | 90.0000% | 4〜10 |','| 矢 | 65.0000% | 2〜5 |')
  if t!=s:f.write_text(t)
v=json.loads((p/'VALIDATION.json').read_text());v['version']='1.6.5';v['chest_arrows']={'basic':{'chance':.5,'min':1,'max':3},'upgraded':{'chance':.65,'min':2,'max':5}};(p/'VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2))
shutil.copyfile('release_1_6_5/update_arrows.py',p/'source/build165_arrows.py')
for f in p.rglob('*.json'):json.loads(f.read_text())
for f in p.rglob('*.mcfunction'):
 for l in f.read_text().splitlines():
  if '$(' in l and not l.startswith('#'):assert l.startswith('$'),(f,l)
  m=re.search(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',l)
  if m:
   ns,path=m[1].split(':');assert (p/'data'/ns/'function'/f'{path}.mcfunction').exists(),m[1]
out=Path('release_1_6_5/OA_BattleRoyale_v1.6.5.zip')
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
 for f in sorted(p.rglob('*')):
  if f.is_file() and '__pycache__' not in str(f):z.write(f,f.relative_to(p))
with zipfile.ZipFile(out) as z:assert z.testzip() is None
print('PASS JSON, macro prefixes, references, ZIP CRC. Arrow expected count: basic 2.25 ->1; upgraded 6.3 ->2.275.')
