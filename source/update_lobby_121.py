from pathlib import Path
import json,re,shutil,zipfile
R=Path('/workspace/scratch/221a7bbb4169');O=R/'release_1_2_1';P=R/'revision/pack';RP=O/'resourcepack';shutil.copytree(R/'release_1_2/resourcepack',RP,dirs_exist_ok=True)
p=P/'data/oa/function/lobby/build.mcfunction';s=p.read_text();lines=[]
for l in s.splitlines():
 if l.startswith('summon minecraft:text_display') and 'ミニアスレ ' in l:continue
 if l.startswith('fill ~-9 ~-1') and 'minecraft:sea_lantern' in l:continue
 if l.startswith('summon minecraft:item_display') and 'oa.lobby_map' in l:
  n=json.loads(l[l.index('{'):]);n['transformation']={'translation':[0.0,0.0,0.0],'left_rotation':[0.0,0.0,0.0,1.0],'scale':[6.0,6.0,1.0],'right_rotation':[0.0,0.0,0.0,1.0]};l=l[:l.index('{')]+json.dumps(n,separators=(',',':'))
 l=l.replace('fill ~-7 ~1 ~36 ~7 ~15 ~36','fill ~-4 ~4 ~36 ~4 ~12 ~36').replace('fill ~-6 ~2 ~35 ~6 ~14 ~35','fill ~-3 ~5 ~35 ~3 ~11 ~35').replace('~0.5 ~16.2 ~34','~0.5 ~13.2 ~34').replace('~0.5 ~1.2 ~33','~0.5 ~3 ~33')
 lines.append(l)
p.write_text('\n'.join(lines)+'\n')
# Explicit 16x16 model plane; sixfold display transform makes a six-block square.
model={'textures':{'map':'oa:item/br_map','particle':'oa:item/br_map'},'gui_light':'front','elements':[{'from':[0,0,7.99],'to':[16,16,8.01],'faces':{'north':{'uv':[0,0,16,16],'texture':'#map'},'south':{'uv':[16,0,0,16],'texture':'#map'}}}],'display':{'fixed':{'rotation':[0,0,0],'translation':[0,0,0],'scale':[1,1,1]}}}
(RP/'assets/oa/models/item/br_map.json').write_text(json.dumps(model,indent=2))
# README is rewritten in place, no release-note additions.
p=P/'README_JA.md';s=p.read_text().replace('短い高低差アスレ4本・BR俯瞰図','案内ホログラム・開始マーカーのない短い高低差アスレ4本・6×6ブロックのBR俯瞰図');p.write_text(s)
p=RP/'README_JA.md';s=p.read_text().replace('ロビーマップ','6×6ブロック表示のロビーマップ');p.write_text(s)
for base in [P,RP]:
 for p in base.rglob('*'):
  if p.is_file() and p.suffix in ['.json','.mcmeta','.mcfunction','.md']:
   try:s=p.read_text()
   except UnicodeError:continue
   if '1.2.0' in s:p.write_text(s.replace('1.2.0','1.2.1'))
p=P/'VALIDATION.json';v=json.loads(p.read_text());v['lobby_map_dimensions']=[6,6];v['map_transformation']='complete translation/quaternions/scale';v['parkour_labels_and_start_lanterns']=False;p.write_text(json.dumps(v,ensure_ascii=False,indent=2))
shutil.copyfile(__file__,P/'source/update_lobby_121.py')
for base,name in [(P,'OA_Weapons_26.3_Prototype.zip'),(RP,'OA_Visuals_26.3_Prototype.zip')]:
 for p in base.rglob('*.json'):json.loads(p.read_text())
 with zipfile.ZipFile(O/name,'w',zipfile.ZIP_DEFLATED) as z:
  for p in base.rglob('*'):
   if p.is_file() and '__pycache__' not in str(p):z.write(p,p.relative_to(base))
 with zipfile.ZipFile(O/name) as z:assert z.testzip() is None
s=(P/'data/oa/function/lobby/build.mcfunction').read_text();assert 'ミニアスレ ' not in s;assert 'fill ~-9 ~-1' not in s
for l in s.splitlines():
 if l.startswith('summon minecraft:item_display') and 'oa.lobby_map' in l:
  t=json.loads(l[l.index('{'):])['transformation'];assert set(t)=={'translation','left_rotation','scale','right_rotation'};assert t['scale']==[6,6,1]
for p in P.rglob('*.mcfunction'):
 for l in p.read_text().splitlines():
  if '$(' in l:assert l.startswith('$'),p
  for ref in re.findall(r'\bfunction (oa:[a-z0-9_/]+)',l):assert (P/'data/oa/function'/(ref.split(':')[1]+'.mcfunction')).exists(),(p,ref)
print('Static pass: complete6x6 map transform/model, 4 course labels/markers removed, JSON/ref/macros/ZIP')
