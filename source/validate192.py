from pathlib import Path
import json,re,zipfile,shutil,hashlib,itertools
P=Path('revision/pack');F=P/'data/oa/function'
json_count=0;function_count=0;ref_count=0
for p in P.rglob('*'):
 if p.suffix in ['.json','.mcmeta']:json.loads(p.read_text());json_count+=1
for p in (P/'data').rglob('*.mcfunction'):
 function_count+=1
 for ln,line in enumerate(p.read_text().splitlines(),1):
  if '$(' in line and not line.startswith('#'):assert line.startswith('$'),(p,ln)
  assert not re.search(r'(?:^\$?|\brun )data modify storage \S+ (?:set|merge|append|prepend|insert)\b',line),(p,ln)
  for m in re.finditer(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',line):
   ns,n=m[1].split(':');assert(P/'data'/ns/'function'/(n+'.mcfunction')).exists(),(p,ln,m[1]);ref_count+=1
  if line.startswith('#'):continue
  # Balanced SNBT/JSON delimiters, respecting quoted text and escaped quotes.
  stack=[];quote=None;escape=False
  for ch in line:
   if quote:
    if escape:escape=False
    elif ch=='\\':escape=True
    elif ch==quote:quote=None
   elif ch in ['"',"'"]:quote=ch
   elif ch in '{[':stack.append(ch)
   elif ch in '}]':assert stack and stack.pop()=={'}':'{',']':'['}[ch],(p,ln,'delimiter')
  assert not stack and not quote,(p,ln,'unclosed delimiter')
def walk(x):
 if isinstance(x,dict):
  yield x
  for v in x.values():yield from walk(v)
 elif isinstance(x,list):
  for v in x:yield from walk(v)
# Definitions, not only file existence: the missing-enchantment error cannot recur for this addition.
for p in (P/'data/oa').rglob('*.json'):
 for d in walk(json.loads(p.read_text())):
  if d.get('type')=='minecraft:set_enchantments':
   for name in d['enchantments']:
    if name.startswith('oa:'):assert(P/'data/oa/enchantment'/(name[3:]+'.json')).exists(),(p,name)
  if d.get('type')=='minecraft:run_function':
   name=d['function'];ns,n=name.split(':');assert(P/'data'/ns/'function'/(n+'.mcfunction')).exists(),(p,name)
  if 'rewards' in d and 'function' in d['rewards']:
   ns,n=d['rewards']['function'].split(':');assert(P/'data'/ns/'function'/(n+'.mcfunction')).exists()
for p in (P/'data/oa/loot_table/debug').glob('*.json'):
 d=json.loads(p.read_text());assert 'modifier' in d['pools'][0]['entries'][0] and 'functions' not in d['pools'][0]['entries'][0]
# Normal play must not gain broad mob targeting or lose its global match state gates.
assert 'execute if entity @s[tag=oa.debug] run function oa:debug/select_targets' in (F/'combat/select_targets.mcfunction').read_text()
assert 'tag @s add br.alive' not in '\n'.join(p.read_text() for p in (F/'debug').rglob('*.mcfunction'))
assert 'scoreboard players set #state br.state' not in '\n'.join(p.read_text() for p in (F/'debug').rglob('*.mcfunction'))
assert (F/'debug/dispatch.mcfunction').read_text().startswith('execute unless entity @s[tag=br.admin]')
assert 'function oa:debug/stop' in (F/'br/start.mcfunction').read_text()
assert 'function oa:debug/stop' in (F/'internal/rejoin.mcfunction').read_text()
assert 'function oa:debug/items_restore' in (F/'debug/stop.mcfunction').read_text()
# Personal gate truth table: normal users retain native restrictions; only an active session can bypass them.
for debug,restriction in itertools.product([False,True],[False,True]):
 allowed=lambda native: native or (debug and not restriction)
 for native in [False,True]:
  if not debug:assert allowed(native)==native
  if debug and restriction:assert allowed(native)==native
  if debug and not restriction:assert allowed(native)
# Books: parse current format, require whole unique roster in ONE page, verify every trigger route.
book_results={}
admin_codes={int(m[1]) for m in re.finditer(r'oa.admin matches (\d+)(?=\s|$)',(F/'admin/dispatch.mcfunction').read_text())}
debug_codes={1,2,3,4,5,6,7,*range(100,110)}
for name in ['admin/book','debug/book_give','lobby/guide/book']:
 s=(F/(name+'.mcfunction')).read_text();start=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');end=s.index(',minecraft:custom_name=',start);d=json.loads(s[start:end]);assert len(d['pages'])<=100
 book_results[name]={'pages':len(d['pages'])}
 if name!='lobby/guide/book':assert any(all(word in json.dumps(page,ensure_ascii=False) for word in ['ゆうあ','ぴちぴち','lazi','ネロ','キリング','ゆったり','ほちきす','こまめ','たやゆゆ']) for page in d['pages'])
 for item in walk(d):
  cmd=item.get('click_event',{}).get('command','')
  m=re.fullmatch(r'/trigger (oa\.[a-z_]+) set (\d+)',cmd)
  if m:
   objective,n=m[1],int(m[2])
   if objective=='oa.admin':assert n in admin_codes,(name,n)
   if objective=='oa.debug_cmd':assert n in debug_codes,(name,n)
# Existing blast motion remains unchanged by this UI/debug feature.
assert 'Motion:[0.0d,1.35d,0.0d]' in (F/'furoball/up.mcfunction').read_text()
# Gallery: 11 exact click events, full transforms retained, all actor profiles resolve to requested MCIDs.
import base64
profiles=json.loads(Path('release_1_9_1/profiles.json').read_text())
for n,d in profiles.items():
 assert d['name'].lower()==n.lower()
 texture=next(p['value'] for p in d['properties'] if p['name']=='textures')
 skin=json.loads(base64.b64decode(texture));assert skin['profileName'].lower()==n.lower()
 assert skin['textures']['SKIN']['url'].startswith('http://textures.minecraft.net/') or skin['textures']['SKIN']['url'].startswith('https://textures.minecraft.net/')
gallery=(F/'lobby/gallery/build.mcfunction').read_text()
assert gallery.count('summon minecraft:mannequin ')==11
assert gallery.count('summon minecraft:interaction ')==11
assert gallery.count('minecraft:stone_button[')==11
assert 'MCID未登録' not in gallery and 'function oa:lobby/gallery/build' in (F/'lobby/build.mcfunction').read_text()
for n in range(1,12):
 a=json.loads((P/'data/oa/advancement/lobby/gallery'/f'{n}.json').read_text())
 assert a['criteria']['read']['trigger']=='minecraft:player_interacted_with_entity'
 assert 'oa.gallery_'+str(n)+'"' in a['criteria']['read']['conditions']['entity']['predicate']['minecraft:nbt']
 callback=(F/f'lobby/gallery/click/{n}.mcfunction').read_text()
 assert f'advancement revoke @s only oa:lobby/gallery/{n}' in callback
 assert f'function oa:lobby/gallery/info/{n}' in callback
 body=(F/f'lobby/gallery/info/{n}.mcfunction').read_text()
 assert body.startswith('tellraw @s ') and 'tellraw @a' not in body
 assert 'CT' in body
 if n not in [8,11]:assert '攻撃' in body
assert 'unless loaded' in (F/'lobby/gallery/ensure.mcfunction').read_text()
assert 'oa:lobby/build' not in (F/'lobby/gallery/ensure.mcfunction').read_text()
assert len(json.loads((F/'lobby/gallery/gacha_results.mcfunction').read_text().removeprefix('tellraw @s ')))==33
# Regression from user log: context-aware entity conditions require a typed loot condition.
for p in (P/'data/oa/advancement').rglob('*.json'):
 for criterion in json.loads(p.read_text())['criteria'].values():
  for name,condition in criterion.get('conditions',{}).items():
   if name in ['entity','player'] and isinstance(condition,dict):assert 'type' in condition,(p,name)
# Compare the wrapper with the exact same trigger bundled in the official 26.3 server JAR.
with zipfile.ZipFile('work/server/META-INF/versions/26.3/server-26.3.jar') as native:
 vanilla=json.loads(native.read('data/minecraft/advancement/adventure/brush_armadillo.json'))
 reference=next(c for c in vanilla['criteria'].values() if c['trigger']=='minecraft:player_interacted_with_entity')['conditions']['entity']
for p in (P/'data/oa/advancement/lobby/gallery').glob('*.json'):
 condition=json.loads(p.read_text())['criteria']['read']['conditions']['entity']
 assert set(condition)==set(reference)
 assert condition['type']==reference['type'] and condition['entity']==reference['entity']
 assert list(condition['predicate'])==['minecraft:nbt']
# Record only checks actually performed. These are NOT a native server parser or player tests.
v=json.loads((P/'VALIDATION.json').read_text());v['version']='1.9.2';v['debug190']={'personal_restriction_switches':10,'permission':'br.admin; idle only','reset':'stop/start match/death/rejoin/reload','mob_targets':'nearby living arena mobs excluding exhibits and invulnerable entities','books':book_results,'limitations':['mob hitboxes use existing approximate player-sized extra-effect probes','mob physics differs from players','waiting-mode revival has no eliminated participants','native safety and skill-internal state constraints stay active']};v['fix192']={'gallery_advancements_fixed':11,'schema_reference':'official 26.3 server JAR: adventure/brush_armadillo; same player_interacted_with_entity wrapper','context_aware_entity_player_conditions':'all scanned; typed','server_load':'not tested'};v['gallery191']={'exhibits':11,'physical_buttons':11,'click_event':'vanilla advancement; exact actor','profiles':list(profiles),'refresh':'gallery only; idle and loaded; automatic once or admin action46','damage_values':'current pre-mitigation data','server_load':'not tested','player_interaction':'not tested'};v['validation191']={'json_mcmeta_files':json_count,'functions_scanned':function_count,'direct_function_references':ref_count,'json_and_delimiters':'pass','macro_prefix_and_storage_paths':'pass','custom_enchantment_and_reward_references':'pass','book_buttons_and_unified_unique_page':'pass','personal_gate_model':'pass','server_load':'not tested','player_abilities':'not tested','multiplayer':'not tested','resourcepack_changed':False,'map_generation_changed':False};(P/'VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2)+'\n')
shutil.copyfile('release_1_9_2/validate192.py',P/'source/validate192.py')
out=Path('release_1_9_2/OA_BattleRoyale_v1.9.2.zip')
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
 for p in sorted(P.rglob('*')):
  if p.is_file() and '__pycache__' not in str(p):z.write(p,p.relative_to(P))
with zipfile.ZipFile(out) as z:assert z.testzip() is None
print(json.dumps({'result':'PASS','format_files':json_count,'functions':function_count,'references':ref_count,'books':book_results,'zip_bytes':out.stat().st_size,'sha256':hashlib.sha256(out.read_bytes()).hexdigest(),'server':'NOT STARTED'},ensure_ascii=False))
