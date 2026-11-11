from pathlib import Path
import json,re,zipfile,shutil
p=Path('revision/pack');f=p/'data/oa/function'
for x in p.rglob('*.json'):json.loads(x.read_text())
for x in p.rglob('*.mcmeta'):json.loads(x.read_text())
for x in p.rglob('*.mcfunction'):
 for l in x.read_text().splitlines():
  if '$(' in l and not l.startswith('#'):assert l.startswith('$'),(x,l)
  m=re.search(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',l)
  if m:
   ns,path=m[1].split(':');assert (p/'data'/ns/'function'/f'{path}.mcfunction').exists(),(x,m[1])
# Grounded, normal-gravity discrete motion model; this is not a player test.
v=0.;height=0.
for _ in range(2):height+=v;v=(v+(.05*73-v)*.2)*.98
for _ in range(100):
 height+=v;v=(v-.08)*.98
 if v<0:break
assert 9.5<height<10.2
# Immunity persists throughout descent and ends on the first subsequent grounded state.
def release_tick(states):
 age=0;air=False
 for grounded in states:
  age+=1
  if not grounded:air=True
  if (age>=4 and air and grounded) or (age>=20 and not air and grounded):return age
 return None
assert release_tick([True,True]+[False]*30+[True])==33
assert release_tick([True]*20)==20
assert release_tick([False]*1000) is None
up=(f/'furoball/up.mcfunction').read_text();clear=(f/'furoball/clear_up.mcfunction').read_text();assert 'levitation 1 72' in up and 'oa:furo_fall -1 add_multiplied_total' in up;assert 'modifier remove oa:furo_fall' in clear
assert 'as @a[tag=oa.furo_fall]' in (f/'tick.mcfunction').read_text()
assert 'as @a[tag=oa.furo_fall]' in (f/'br/finish.mcfunction').read_text()
for name in ['br/enter','br/eliminate','br/restore','test/reset','internal/rejoin','internal/death']:assert 'function oa:furoball/clear_up' in (f/(name+'.mcfunction')).read_text(),name
for rel in ['lobby/guide/book.mcfunction','admin/book.mcfunction']:
 s=(f/rel).read_text();a=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');e=s.index(',minecraft:custom_name=',a);json.loads(s[a:e])
v=json.loads((p/'VALIDATION.json').read_text());v['version']='1.8.1';v['features181']={'furo_self_levitation_amplifier':72,'simulation_pulse_frames':2,'modelled_grounded_rise_m':height,'hard_height_cap':False,'fall_immunity':'own fall_damage_multiplier modifier until first landing; water/lava/vehicle/death/end/rejoin/reset cleanup','server_load':'not tested','player_ascent_or_landing_test':'not tested','multiplayer_tests':'not tested'};v['validation181']={'json_macros_function_refs_books':'pass','discrete_motion_model':'pass','fall_protection_lifecycle_model':'pass','cleanup_hook_refs':'pass'};(p/'VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2))
shutil.copyfile('release_1_8_1/validate181.py',p/'source/validate181.py')
out=Path('release_1_8_1/OA_BattleRoyale_v1.8.1.zip')
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
 for x in sorted(p.rglob('*')):
  if x.is_file() and '__pycache__' not in str(x):z.write(x,x.relative_to(p))
with zipfile.ZipFile(out) as z:assert z.testzip() is None
print('PASS JSON/ref/macros/books, motion and single-flight cleanup models, hook coverage, ZIP CRC. Model rise:',round(height,3),'m; no server launched.')
