from pathlib import Path
import re,json,zipfile,shutil,copy
p=Path('revision/pack');f=p/'data/oa/function'
for x in p.rglob('*.json'):json.loads(x.read_text())
for x in p.rglob('*.mcmeta'):json.loads(x.read_text())
count=0
for x in p.rglob('*.mcfunction'):
 for no,l in enumerate(x.read_text().splitlines(),1):
  if '$(' in l and not l.startswith('#'):assert l.startswith('$'),(x,no,'macro prefix')
  if re.search(r'(?:^\$?|\brun )data modify storage ',l):
   # A target NBT path must precede the modification operation.
   assert not re.search(r'data modify storage \S+ (?:set|merge|append|prepend|insert)\b',l),(x,no,'missing target path')
   count+=1
  m=re.search(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',l)
  if m:
   ns,path=m[1].split(':');assert (p/'data'/ns/'function'/f'{path}.mcfunction').exists(),(x,m[1])
  for store in ['oa:roster_spawn','oa:g_move','oa:throw_push']:
   if 'with storage '+store in l:assert l.endswith('with storage '+store+' args'),(x,no,l)
   if 'execute store result storage '+store in l:assert 'storage '+store+' args.' in l,(x,no,l)
# Regression: original erroneous forms are detected, corrected forms are not.
pattern=r'data modify storage \S+ (?:set|merge|append|prepend|insert)\b'
for store in ['oa:roster_spawn','oa:g_move','oa:throw_push']:
 assert re.search(pattern,f'data modify storage {store} set from storage oa:br center')
 assert not re.search(pattern,f'data modify storage {store} args set from storage oa:br center')
# Argument-compound models: required fields reach each macro at the new path.
center={'x':0.,'y':64.,'z':0.,'dim':'minecraft:overworld','yaw':0.,'pitch':0.}
for rel,fields in [('admin/players/spawn',{'x','y','z','range'}),('tayayuyu/move/scatter_one',{'x','z','range'}),('tayayuyu/move/offset',{'max'}),('tayayuyu/move/tp',{'slot'})]:
 args=copy.deepcopy(center);args.update(range=125,max=3,slot=1)
 used=set(re.findall(r'\$\((\w+)\)',(f/(rel+'.mcfunction')).read_text()));assert used==fields,(rel,used);assert used<=args.keys()
args={'id':42,'x':.07,'z':-.07};saved=copy.deepcopy(args);args={'id':42};args=copy.deepcopy(saved);assert args==saved
v=json.loads((p/'VALIDATION.json').read_text());v['version']='1.8.3';v['fix183']={'cause':'missing target NBT path in data modify storage','fixed':['admin/players/live_join','tayayuyu/move/prepare','throwable/push/load'],'argument_compounds':'args, consistently used by stores/source copies/function macros','storage_modify_lines_scanned':count};v['validation183']={'json_macros_function_refs':'pass','missing_storage_target_path_regression_check':'pass','argument_path_models':'pass','server_load':'not tested','player_tests':'not tested','multiplayer_tests':'not tested'};(p/'VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2))
shutil.copyfile('release_1_8_3/validate183.py',p/'source/validate183.py')
out=Path('release_1_8_3/OA_BattleRoyale_v1.8.3.zip')
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
 for x in sorted(p.rglob('*')):
  if x.is_file() and '__pycache__' not in str(x):z.write(x,x.relative_to(p))
with zipfile.ZipFile(out) as z:assert z.testzip() is None
print('PASS JSON/macros/function refs,',count,'storage modification lines, missing-path regression, argument-compound models, ZIP CRC. No server launched.')
