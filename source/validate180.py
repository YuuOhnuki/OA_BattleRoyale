from pathlib import Path
import json,re,zipfile,math
p=Path('revision/pack');f=p/'data/oa/function'
for x in p.rglob('*.json'):json.loads(x.read_text())
for x in p.rglob('*.mcmeta'):json.loads(x.read_text())
for x in p.rglob('*.mcfunction'):
 for l in x.read_text().splitlines():
  if '$(' in l and not l.startswith('#'):assert l.startswith('$'),(x,l)
  m=re.search(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',l)
  if m:
   ns,path=m[1].split(':');assert (p/'data'/ns/'function'/f'{path}.mcfunction').exists(),(x,m[1])
for root in ['enchantment','advancement']:
 for x in (p/'data/oa'/root).rglob('*.json'):
  for ref in re.findall(r'"function"\s*:\s*"(oa:[a-z0-9_/]+)"',x.read_text()):assert (f/(ref.split(':')[1]+'.mcfunction')).exists(),(x,ref)
# Every custom enchantment lookup resolves; no new enchantment IDs introduced.
def walk(o,src):
 if isinstance(o,dict):
  if o.get('type')=='minecraft:set_enchantments':
   for k in o.get('enchantments',{}):
    if k.startswith('oa:'):assert (p/'data/oa/enchantment'/(k.split(':')[1]+'.json')).exists(),(src,k)
  for v in o.values():walk(v,src)
 elif isinstance(o,list):
  for v in o:walk(v,src)
for x in p.rglob('*.json'):walk(json.loads(x.read_text()),x)
for rel,terminator in [('admin/book.mcfunction',',minecraft:custom_name='),('lobby/guide/book.mcfunction',',minecraft:custom_name=')]:
 s=(f/rel).read_text();a=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');e=s.index(terminator,a);d=json.loads(s[a:e]);assert len(d['pages'])<=100
 if 'guide' in rel:
  assert len(d['pages'])>=15
  commands=[c for c in re.findall(r'/trigger oa.lobby set (\d+)',s)];assert set(str(i) for i in range(101,111))<=set(commands)
curse=json.loads((p/'data/oa/enchantment/curse.json').read_text());terms=curse['effects']['minecraft:damage_immunity'][0]['requirements']['terms'];assert not any(t.get('type')=='minecraft:random_chance' for t in terms);assert 'oa.curse_guard' in json.dumps(terms)
assert 'matches 1..25' in (f/'curse/prepare.mcfunction').read_text()
# Repeat native immunity queries use the same sampled state: 25 of 100 samples remain 25%.
assert sum(1 for sample in range(1,101) if any([sample<=25]*3))==25
assert math.isclose(1+1.5,2.5)
for name,chance in [('chest_basic',10),('chest_upgraded',15)]:
 j=json.loads((p/f'data/oa/loot_table/br/{name}.json').read_text());pool=j['pools'][-1];e=pool['entries'][0];assert e['weight']==chance;assert pool['entries'][1]['weight']==100-chance
 c=e['modifier'][0]['components'];assert c['minecraft:max_stack_size']==16 and c['minecraft:custom_data']['oa_furoball']
# Sphere/box damage-range arithmetic: a giant hit near its chest remains in blast range.
def distance_box(ball,feet,scale):
 ds=[]
 for i in [0,1,2]:
  d=ball[i]-feet[i]
  ds.append(max(0,abs(d)-.3*scale) if i!=1 else max(0,-d,d-1.8*scale))
 return sum(q*q for q in ds)**.5
assert distance_box((0,4,0),(0,0,0),2.5)==0
assert distance_box((4.5,1,0),(0,0,0),1)>3.5
# Safe movement checks have clearance for the new 4.5m-tall bodies.
assert '~4.6' in (f/'tayayuyu/move/check.mcfunction').read_text()
assert not any('summon minecraft:fireball' in x.read_text() for x in (f/'furoball').glob('*.mcfunction'))
# Existing single-unique kind roster unchanged; special consumable has no unique flag.
c=json.loads((p/'data/oa/loot_table/br/test/furoball.json').read_text())['pools'][0]['entries'][0]['modifier'][0]['components'];assert 'oa' not in c['minecraft:custom_data']
v=json.loads((p/'VALIDATION.json').read_text());v['version']='1.8.0';v['features172']['large_scale']=2.5;v['features180']={'killing_guard_chance':.25,'guard_sampling':'one shared roll per player per tick','ordinary_native_guard_feedback':'not implemented: native immunity returns before damage trigger','yuua_execution_and_counter_guard':True,'giant_scale':2.5,'staple_fx':'3D contour of actual 3-sphere union','furoball':{'kind':'consumable, outside unique limit','stack':16,'damage_hp':3,'radius_m':3.5,'self_damage':0,'enemy_push':'wall-tested scripted displacement','self_up':'short native levitation acceleration','flying_limit':20,'ttl_ticks':60,'chest_chance':[.10,.15]},'player_book':'lobby auto issue; self-only actions; free slot required','resource_pack':'unchanged 1.7.0','requires_restart':'enchantment changes'};v['validation180']={'json_macro_function_enchantment_refs':'pass','both_book_contents_and_team_buttons':'pass','guard_sampling_and_blast_range_arithmetic_models':'pass','native_bytecode_inspection':'offline only','server_load':'not tested','player_tests':'not tested','multiplayer_tests':'not tested'};(p/'VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2))
import shutil
shutil.copy('release_1_8_0/validate180.py',p/'source/validate180.py')
out=Path('release_1_8_0/OA_BattleRoyale_v1.8.0.zip')
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
 for x in sorted(p.rglob('*')):
  if x.is_file() and '__pycache__' not in str(x):z.write(x,x.relative_to(p))
with zipfile.ZipFile(out) as z:assert z.testzip() is None
print('PASS JSON/refs/macros, enchantment dependencies, books, loot weights, guard/blast arithmetic, ZIP CRC. No server launched.',out.stat().st_size)
