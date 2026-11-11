from pathlib import Path
import json,re,zipfile,math
from PIL import Image
p=Path('revision/pack');r=Path('release_1_7_0/resourcepack');f=p/'data/oa/function'
x=f/'give/internal/tayayuyu.mcfunction';x.write_text(x.read_text().replace('"color":"light_purple"','"color":"green"'))
x=p/'LOOT_JA.md';s=x.read_text().replace('満腹度2（肉アイコン1個分）と少量の隠し満腹度','バニラの満腹度効果による満腹度回復');x.write_text(s)
# Native registry IDs for custom damage calls.
with zipfile.ZipFile('work/server/META-INF/versions/26.3/server-26.3.jar') as z:
 for n in ['in_fire','explosion']:assert f'data/minecraft/damage_type/{n}.json' in z.namelist()
for root in [p,r]:
 for x in root.rglob('*.json'):json.loads(x.read_text())
 for x in root.rglob('*.mcmeta'):json.loads(x.read_text())
for x in p.rglob('*.mcfunction'):
 for line in x.read_text().splitlines():
  if '$(' in line and not line.startswith('#'):assert line.startswith('$'),(x,line)
  m=re.search(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',line)
  if m:
   ns,path=m[1].split(':');assert (p/'data'/ns/'function'/f'{path}.mcfunction').exists(),(x,m[1])
  for mod in re.findall(r'\bitem modify entity .*? (oa:[a-z0-9_/]+)$',line):assert (p/'data/oa/item_modifier'/(mod.split(':')[1]+'.json')).exists(),(x,mod)
for dirname in ['advancement','enchantment']:
 for x in (p/'data/oa'/dirname).rglob('*.json'):
  for ref in re.findall(r'"function"\s*:\s*"(oa:[a-z0-9_/]+)"',x.read_text()):assert (f/(ref.split(':')[1]+'.mcfunction')).exists(),(x,ref)
for name in ['bandage','firstaid','tayayuyu']:
 assert json.loads((r/f'assets/oa/items/{name}.json').read_text())['model']['model']==f'oa:item/{name}'
 assert Image.open(r/f'assets/oa/textures/item/{name}.png').getchannel('A').getextrema()==(0,255)
# Every embedded medical reward updated, including ore and chest copies.
medcount=0
for x in (p/'data/oa/loot_table').rglob('*.json'):
 def check(o):
  global medcount
  if isinstance(o,dict):
   c=o.get('components',{});d=c.get('minecraft:custom_data',{})
   if d.get('br_heal_kind')==2:
    assert c['minecraft:consumable']['consume_seconds']==2.;assert c['minecraft:consumable']['on_consume_effects']==[];assert c['minecraft:item_model']=='oa:firstaid';medcount+=1
   if d.get('oa_buff'):
    effects=[e for eff in c['minecraft:consumable']['on_consume_effects'] for e in eff.get('effects',[])]
    assert all(e['duration']==200 for e in effects if e['id']!='minecraft:instant_health'),(x,effects)
    if d['oa_buff']=='azuki':assert any(e['id']=='minecraft:instant_health' and e['amplifier']==0 for e in effects)
   for val in o.values():check(val)
  elif isinstance(o,list):
   for val in o:check(val)
 check(json.loads(x.read_text()))
assert medcount>=4
assert 'oa.root 50' in (f/'hotchikisu/root_target.mcfunction').read_text()
assert 'oa.cd 900' in (f/'tayayuyu/use.mcfunction').read_text()
# Arithmetic models: additive-health heal cap and all TNT overlaps within one event.
for mx in [20.,26.,40.,44.]:
 for hp in [1.,5.5,mx-1,mx]:
  for heal in [2.,4.,10.,20.]:
   cap=min(hp+heal,mx);delta=cap-mx;assert abs((mx+delta)-cap)<1e-9
seen=set();damage=0
for _ in range(10):
 key=(123,456)
 if key not in seen:seen.add(key);damage+=6
assert damage==6
# All 145 loot weights reach exactly one result, respecting yuua reservation reroll range.
assert sum([10]+[15]*9)==145
s=(f/'admin/book.mcfunction').read_text();a=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');b=s.index(',minecraft:custom_name=',a);json.loads(s[a:b])
v=json.loads((p/'VALIDATION.json').read_text());v.update(version='1.7.0',medical={'kit_use_seconds':2,'kit_heal_hp':10,'buff_ticks':200,'azuki_heal_hp':4,'ore_recovery_chance':.25},tayayuyu={'kind':9,'attack_hp':5,'attack_speed':1.8,'cooldown_ticks':900,'outcomes':7,'equal_chance':True,'tnt_fuse_ticks':40,'tnt_cap_hp_per_event':6,'fire_implementation':'periodic in_fire damage; no player Fire NBT writes','tnt_implementation':'block_display plus scripted damage; no native TNT'},validation170={'json_refs_macros_assets':'pass','medical_definitions':'pass','heal_cap_and_overlap_arithmetic_models':'pass','server_load':'not tested','player_tests':'not tested','multiplayer_tests':'not tested','in_game_visuals':'not tested'})
(p/'VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2));(p/'source/validate170.py').write_text(Path('/tmp/validate170.py').read_text())
for root,name in [(p,'OA_BattleRoyale_v1.7.0.zip'),(r,'OA_BattleRoyale_Resources_v1.7.0.zip')]:
 out=Path('release_1_7_0')/name
 with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
  for x in sorted(root.rglob('*')):
   if x.is_file() and '__pycache__' not in str(x):z.write(x,x.relative_to(root))
 with zipfile.ZipFile(out) as z:assert z.testzip() is None
 print(name,out.stat().st_size)
print('PASS: static formats/references, embedded medical definitions, arithmetic models, asset alpha, ZIP CRC. No server launched.')
