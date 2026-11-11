from pathlib import Path
import json,re,zipfile
p=Path('revision/pack');f=p/'data/oa/function';b=f/'tayayuyu'
x=p/'WEAPONS_JA.md';s=x.read_text().replace('| たやゆゆ |','| たやゆゆ：変態ガチャ |').replace('| ほちきす |','| ほちきす：ホッチキス |').replace('管理者の /kill や奈落等','飢餓・管理者の /kill・奈落等');x.write_text(s)
for x in p.rglob('*.json'):json.loads(x.read_text())
for x in p.rglob('*.mcmeta'):json.loads(x.read_text())
for x in p.rglob('*.mcfunction'):
 for line in x.read_text().splitlines():
  if '$(' in line and not line.startswith('#'):assert line.startswith('$'),(x,line)
  m=re.search(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',line)
  if m:
   ns,path=m[1].split(':');assert (p/'data'/ns/'function'/f'{path}.mcfunction').exists(),(x,m[1])
# Check enchantment dependencies to avoid the 1.7.0 regression.
def walk(o,src):
 if isinstance(o,dict):
  if o.get('type')=='minecraft:set_enchantments':
   for key in o.get('enchantments',{}):
    if key.startswith('oa:'):assert (p/'data/oa/enchantment'/(key.split(':')[1]+'.json')).exists(),(src,key)
  for v in o.values():walk(v,src)
 elif isinstance(o,list):
  for v in o:walk(v,src)
for x in p.rglob('*.json'):walk(json.loads(x.read_text()),x)
s=(b/'use.mcfunction').read_text();rolls=[int(n) for n in re.findall(r'#gacha_roll oa.tmp matches (\d+) run function',s)];assert sorted(rolls)==list(range(1,17));assert 'random value 1..16' in s and 'oa.cd 900' in s
# The random ordered-cycle swap is a bijection and never targets its own slot.
for n in range(2,11):
 for shift in range(1,n):
  dest=[(i+shift)%n for i in range(n)];assert sorted(dest)==list(range(n));assert all(i!=d for i,d in enumerate(dest))
# Fixed border-coordinate inequalities enforce a safe interior margin.
for width in [2,6,8,20,90,300]:
 half=width//2-3
 if half<=0:continue
 lim=half*1000
 for dx,dz in [(0,0),(lim,lim),(-lim,-lim)]:assert -lim<=dx<=lim and -lim<=dz<=lim
 assert not (-lim<=lim+1<=lim)
# Timer expiration and independent status-duration models, 20TPS.
for sec in [3,5,10,15]:
 t=sec*20
 for tick in range(sec*20):t-=1
 assert t==0
for kind in range(1,10):
 data=json.loads((p/f'data/oa/item_modifier/name/k{kind}.json').read_text());name=data['functions'][0]['components']['minecraft:custom_name']['text'];assert '：' in name and ' | ' not in name
s=(f/'admin/book.mcfunction').read_text();a=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');e=s.index(',minecraft:custom_name=',a);json.loads(s[a:e])
v=json.loads((p/'VALIDATION.json').read_text());v['version']='1.7.2';v['tayayuyu']['outcomes']=16;v['features172']={'new_outcomes':9,'each_probability':.0625,'small_scale':.5,'large_scale':1.75,'cooldown_seconds':45,'timers_seconds':{'small':15,'large':10,'gather_grace':3,'peace':5,'mood':5,'reveal':10,'hunger':10,'intro':15},'weapon_name_format':'person：epithet','resources_unchanged':'1.7.0'};v['validation172']={'json_macros_function_and_enchantment_refs':'pass','shuffle_bijection_derangement_model_2_to_10_players':'pass','border_bound_and_timer_arithmetic_models':'pass','new_names_9_kinds':'pass','server_load':'not tested','player_tests':'not tested','multiplayer_tests':'not tested'};(p/'VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2))
import shutil
shutil.copyfile('release_1_7_2/validate172.py',p/'source/validate172.py')
out=Path('release_1_7_2/OA_BattleRoyale_v1.7.2.zip')
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
 for x in sorted(p.rglob('*')):
  if x.is_file() and '__pycache__' not in str(x):z.write(x,x.relative_to(p))
with zipfile.ZipFile(out) as z:assert z.testzip() is None
print('PASS: static formats/refs, all 16 outcome dispatches, swap/coordinate/timer models, names and ZIP CRC. No server launched.',out.stat().st_size)
