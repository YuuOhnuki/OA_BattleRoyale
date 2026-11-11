from pathlib import Path
import json,re,zipfile,shutil
p=Path('revision/pack');f=p/'data/oa/function'
x=p/'data/oa/item_modifier/tayayuyu_upgrade.json';j=json.loads(x.read_text());j['enchantments']={'oa:komame':1};x.write_text(json.dumps(j,ensure_ascii=False,indent=2))
x=p/'data/oa/enchantment/tayayuyu.json';x.unlink()
x=f/'komame/hit.mcfunction';s=x.read_text();prefix='''# Share the established enchantment registry entry; dispatch by the actual striking item.
scoreboard players set #taya_hit oa.tmp 0
execute on attacker if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:9}}] run scoreboard players set #taya_hit oa.tmp 1
execute if score #taya_hit oa.tmp matches 1 run return run function oa:tayayuyu/hit
''';x.write_text(prefix+s)
# Upgrade any kind-9 items that might already have existed after a server restart.
x=f/'inventory/upgrade_melee.mcfunction';x.write_text(x.read_text()+'\nexecute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:9}}] unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{taya_registry171:1b}}] run item modify entity @s weapon.mainhand oa:tayayuyu_upgrade\n')
x=p/'data/oa/item_modifier/tayayuyu_upgrade.json';j=json.loads(x.read_text());x.write_text(json.dumps({'type':'minecraft:sequence','functions':[j,{'type':'minecraft:set_custom_data','tag':'{oa:{taya_registry171:1b}}'}]},ensure_ascii=False,indent=2))
for x in p.rglob('*'):
 if x.is_file() and x.suffix in ['.md','.mcmeta','.mcfunction']:
  s=x.read_text();t=s.replace('1.7.0','1.7.1')
  if x.name=='README_JA.md':t=t.replace('OA_BattleRoyale_Resources_v1.7.1.zip','OA_BattleRoyale_Resources_v1.7.0.zip')
  if t!=s:x.write_text(t)
x=p/'README_JA.md';x.write_text(x.read_text()+'\n本体1.7.1は完全版リソースパック1.7.0と組み合わせます。固有武器の命中検知は既存の登録済みエンチャントを共有し、実際の武器データで分岐します。新しいエンチャントIDを要求しません。旧本体ZIPを重複配置せず交換してから再読み込みしてください。\n')
shutil.copyfile('release_1_7_1/fix_registry.py',p/'source/fix171_registry.py')
# Verify all enchantment references, not only syntactic JSON and function references.
refs=[]
def walk(o,src):
 if isinstance(o,dict):
  if o.get('type')=='minecraft:set_enchantments':refs.extend((src,k) for k in o.get('enchantments',{}))
  c=o.get('components',{});refs.extend((src,k) for k in c.get('minecraft:enchantments',{}))
  for v in o.values():walk(v,src)
 elif isinstance(o,list):
  for v in o:walk(v,src)
for x in p.rglob('*.json'):walk(json.loads(x.read_text()),str(x))
for src,ref in refs:
 if ref.startswith('oa:'):assert (p/'data/oa/enchantment'/(ref.split(':')[1]+'.json')).exists(),(src,ref)
for x in (p/'data').rglob('*'):
 if x.is_file():assert 'oa:tayayuyu"' not in x.read_text(errors='ignore') or '/items/' in str(x) or 'minecraft:item_model' in x.read_text(errors='ignore'),x
for x in p.rglob('*.mcfunction'):
 for l in x.read_text().splitlines():
  if '$(' in l and not l.startswith('#'):assert l.startswith('$'),(x,l)
  m=re.search(r'(?:^\$?|\brun )function ((?:oa(?:_map2|_map)?|jumppad):[a-z0-9_/]+)(?=\s|$)',l)
  if m:
   ns,path=m[1].split(':');assert (p/'data'/ns/'function'/f'{path}.mcfunction').exists(),m[1]
v=json.loads((p/'VALIDATION.json').read_text());v['version']='1.7.1';v['registry_fix171']={'new_enchantment_dependency':'removed; use existing oa:komame and dispatch by kind9','item_modifier_enchantment_refs':'static validated','server_load':'not tested'};(p/'VALIDATION.json').write_text(json.dumps(v,ensure_ascii=False,indent=2))
out=Path('release_1_7_1/OA_BattleRoyale_v1.7.1.zip')
with zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED) as z:
 for x in sorted(p.rglob('*')):
  if x.is_file() and '__pycache__' not in str(x):z.write(x,x.relative_to(p))
with zipfile.ZipFile(out) as z:assert z.testzip() is None
print('PASS JSON, enchantment references, macros, direct functions, ZIP CRC. No server launched.')
