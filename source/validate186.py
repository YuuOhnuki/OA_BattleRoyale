from pathlib import Path
import json,re,zipfile,shutil
p=Path('revision/pack');f=p/'data/oa/function'
for x in p.rglob('*.json'):json.loads(x.read_text())
for x in p.rglob('*.mcmeta'):json.loads(x.read_text())
for x in p.rglob('*.mcfunction'):
 for l in x.read_text().splitlines():
  if '$(' in l and not l.startswith('#'):assert l.startswith('$'),(x,l)
  assert not re.search(r'(?:^\$?|\brun )data modify storage \S+ (?:set|merge|append|prepend|insert)\b',l),(x,l)
  m=re.search(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',l)
  if m:
   ns,path=m[1].split(':');assert (p/'data'/ns/'function'/f'{path}.mcfunction').exists(),(x,m[1])
s=(f/'furoball/push.mcfunction').read_text();assert 'oa.kpush 6' not in s;assert 'function oa:furoball/push_once with storage oa:kb' in s;assert s.index('oa.kpush 0')>s.index('function oa:furoball/push_once')
lines=(f/'furoball/push_once.mcfunction').read_text().splitlines();commands=[s for s in lines if s.startswith('$')];assert len(commands)==36;assert all('oa.kpush matches 1..' in s for s in commands)
# A wall stops all later samples in the same event; no displacement is queued for later ticks.
for wall_at in [0,1,5,35,36]:
 active=True;steps=0
 for i in range(36):
  if active:
   if i>=wall_at:active=False
   else:steps+=1
 assert steps==wall_at
 active=False;assert not active
up=(f/'furoball/up.mcfunction').read_text()
assert up.count('Motion:')==1 and 'Motion:[0.0d,1.35d,0.0d]' in up
assert 'effect give' not in up
assert 'oa.fowner = @s oa.id' in up
assert 'execute on passengers run ride @s dismount' in (f/'furoball/carrier/release.mcfunction').read_text()
assert 'Motion[1]' in (f/'furoball/carrier/tick.mcfunction').read_text()
vy=1.35;height=0.;steps=0
while vy>0:
 height+=vy;vy=(vy-.08)*.98;steps+=1
assert 10.0<height<10.2 and steps==15
assert 'oa:furo_fall -1 add_multiplied_total' in up
assert 'modifier remove oa:furo_fall' in (f/'furoball/clear_up.mcfunction').read_text()
v=json.loads((p/'VALIDATION.json').read_text());v['version']='1.8.6'
v['features186']={'self_launch':'one initial armor-stand carrier Motion; release at apex; no repeated acceleration','carrier_initial_vy':1.35,'carrier_model_rise_m':height,'carrier_model_ascent_ticks':steps,'player_height':'unmeasured; seat/dismount offset may differ','fall_protection':'until first landing','constraint':'temporary riding; Shift can dismount early'}
v['validation186']={'json_macro_refs_storage_paths':'pass','carrier_refs_and_initial_motion':'pass','carrier_gravity_model':'pass','server_load':'not tested','player_tests':'not tested','multiplayer_tests':'not tested'}
(p/'VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2))
shutil.copyfile('release_1_8_6/validate186.py',p/'source/validate186.py')
out=Path('release_1_8_6/OA_BattleRoyale_v1.8.6.zip')
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
 for x in sorted(p.rglob('*')):
  if x.is_file() and '__pycache__' not in str(x):z.write(x,x.relative_to(p))
with zipfile.ZipFile(out) as z:assert z.testzip() is None
print('PASS formats/refs, storage paths, single-event wall-stop model, carrier initial impulse and rise model, ZIP CRC. Model rise:',round(height,6),'m. No server launched.')
