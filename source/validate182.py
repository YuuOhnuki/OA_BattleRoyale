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
for x in (p/'data/oa/enchantment').rglob('*.json'):
 for ref in re.findall(r'"function"\s*:\s*"oa:([a-z0-9_/]+)"',x.read_text()):assert (f/(ref+'.mcfunction')).exists(),(x,ref)
def rise(amp):
 v=h=0.
 for _ in range(2):h+=v;v=(v+(.05*(amp+1)-v)*.2)*.98
 for _ in range(100):
  h+=v;v=(v-.08)*.98
  if v<0:break
 return h
old,new=rise(72),rise(31);assert .23<new/old<.27
for ident in [1,10,1000,100000]:
 for op in range(5):
  code=ident*10+op;assert code//10==ident and code%10+1==op+1
for rel in ['admin/book.mcfunction','lobby/guide/book.mcfunction']:
 s=(f/rel).read_text();a=s.index('minecraft:written_book_content=')+len('minecraft:written_book_content=');e=s.index(',minecraft:custom_name=',a);json.loads(s[a:e])
assert 'tag=!br.gm_override' in (f/'br/tick.mcfunction').read_text()
for rel in ['br/enter','br/eliminate','br/restore']:assert 'tag @s remove br.gm_override' in (f/(rel+'.mcfunction')).read_text()
for action in ['survival','adventure','creative','spectator','revive']:assert f'action:"{action}"' in (f/'manage.mcfunction').read_text()
assert 'unless entity @s[tag=br.admin]' in (f/'admin/control/dispatch.mcfunction').read_text()
assert 'unless entity @s[tag=br.admin]' in (f/'manage.mcfunction').read_text()
assert 'Health:0.0f' in (f/'admin/control/process.mcfunction').read_text()
assert 'oa.qleft' in (f/'admin/control/process.mcfunction').read_text()
assert 'oa:furo_fall -1 add_multiplied_total' in (f/'furoball/up.mcfunction').read_text()
v=json.loads((p/'VALIDATION.json').read_text());v['version']='1.8.2';v['features182']={'furo_amplifier':31,'model_rise_m':new,'model_ratio_to_previous':new/old,'fall_protection':'unchanged until landing','admin_modes':['survival','adventure','creative','spectator'],'admin_revive':'reuse current-border placement and original inventory backup; death screen queue','direct_command':'/function oa:manage {player:"MCID",action:"revive"}','scope':'registered in-game admin; online targets','mode_override':'spectator enforcement bypass, cleared on enter/eliminate/restore'};v['validation182']={'json_refs_macros_and_books':'pass','mode_code_encode_decode':'pass','motion_ratio_arithmetic_model':'pass','admin_guards_and_reset_hooks':'static checked','server_load':'not tested','player_tests':'not tested','multiplayer_tests':'not tested'};(p/'VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2))
shutil.copy('release_1_8_2/validate182.py',p/'source/validate182.py')
out=Path('release_1_8_2/OA_BattleRoyale_v1.8.2.zip')
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
 for x in sorted(p.rglob('*')):
  if x.is_file() and '__pycache__' not in str(x):z.write(x,x.relative_to(p))
with zipfile.ZipFile(out) as z:assert z.testzip() is None
print('PASS formats, refs, books, guards, control coding, cleanup hooks and ZIP CRC. Motion model:',round(new,3),'m; ratio',round(new/old,3),'. No server launched.')
