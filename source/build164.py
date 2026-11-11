from pathlib import Path
import json,shutil
p=Path('revision/pack');f=p/'data/oa/function';loot=p/'data/oa/loot_table';o=Path('release_1_6_4');o.mkdir(exist_ok=True)
def w(p,s):p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s)
def walk(o):
 if isinstance(o,dict):
  c=o.get('components',{});d=c.get('minecraft:custom_data',{})
  if d.get('oa_normal') in ['bat','kb_stick'] or d.get('oa_overwork'):c['minecraft:max_stack_size']=1
  for v in o.values():walk(v)
 elif isinstance(o,list):
  for v in o:walk(v)
for x in loot.rglob('*.json'):
 j=json.loads(x.read_text());walk(j);w(x,json.dumps(j,ensure_ascii=False,indent=2))
for n in ['overwork','internal/overwork']:
 x=f/'give'/f'{n}.mcfunction';w(x,x.read_text().replace('minecraft:max_stack_size=64','minecraft:max_stack_size=1'))
for n,chance in [('chest_basic',25),('chest_upgraded',35)]:
 x=loot/'br'/f'{n}.json';j=json.loads(x.read_text());pool=j['pools'][4];e=[a for a in pool['entries'] if a.get('name') in ['minecraft:cooked_beef','minecraft:apple']]
 for a in e:a['weight']=chance
 pool['entries']=e+[{'type':'minecraft:empty','weight':(100-chance)*2}]
 # Golden apples are excluded from the normal food pool as well.
 j['pools'][6]['entries']=[{'type':'minecraft:empty','weight':1}]
 w(x,json.dumps(j,ensure_ascii=False,indent=2))
x=loot/'br/food.json';j=json.loads(x.read_text());j['pools'][0]['entries']=[a for a in j['pools'][0]['entries'] if a.get('name') in ['minecraft:cooked_beef','minecraft:apple']];w(x,json.dumps(j,ensure_ascii=False,indent=2))
x=f/'br/enter.mcfunction';w(x,x.read_text().replace('give @s minecraft:bread 2\n',''))
x=f/'hotchikisu/root_target.mcfunction';w(x,x.read_text().replace('oa.root 40','oa.root 50'))
x=p/'data/oa/item_modifier/lore/k7.json';w(x,x.read_text().replace('敵を2秒拘束','敵を2.5秒拘束'))
# Prepare push direction before /damage invokes nested advancement functions which may reuse temporaries.
x=f/'throwable/observe/hit.mcfunction';s=x.read_text();s=s.replace('scoreboard players set #hit oa.tmp 1','scoreboard players set #hit oa.tmp 1\nfunction oa:throwable/push/start');s=s.replace('\nfunction oa:throwable/push/start\n','\n',1) if False else s
# Remove the old trailing push start, leaving only the first one.
idx=s.rfind('function oa:throwable/push/start');s=s[:idx]+s[idx:].replace('function oa:throwable/push/start','execute if entity @a[tag=oa.observe_owner,limit=1] run damage @s 0.1 minecraft:thrown by @a[tag=oa.observe_owner,limit=1]',1);w(x,s)
# Upgrade old unstacked items in place. Existing stacks are split without discarding contents.
b=f/'normal/nonstack'
w(p/'data/oa/item_modifier/nonstack.json',json.dumps({'type':'minecraft:set_components','components':{'minecraft:max_stack_size':1}}))
w(p/'data/oa/item_modifier/nonstack_one.json',json.dumps({'type':'minecraft:sequence','functions':[{'type':'minecraft:set_count','count':1},{'type':'minecraft:set_components','components':{'minecraft:max_stack_size':1}}]}))
slots=[f'hotbar.{i}' for i in range(9)]+[f'inventory.{i}' for i in range(27)]+['weapon.offhand']
s=''
for slot in slots:
 for tag in ['{oa_normal:"bat"}','{oa_normal:"kb_stick"}','{oa_overwork:1b}']:
  s+=f'execute if items entity @s {slot} *[minecraft:custom_data~{tag}] unless items entity @s {slot} *[minecraft:max_stack_size=1] run function oa:normal/nonstack/slot {{slot:"{slot}"}}\n'
w(b/'scan.mcfunction',s)
w(b/'slot.mcfunction','''summon minecraft:item_display ~ ~ ~ {Tags:["oa.stack_reader"]}
$item replace entity @e[type=minecraft:item_display,tag=oa.stack_reader,limit=1] contents from entity @s $(slot)
execute store result score #stack_count oa.tmp run data get entity @e[type=minecraft:item_display,tag=oa.stack_reader,limit=1] item.count
kill @e[type=minecraft:item_display,tag=oa.stack_reader]
$execute if score #stack_count oa.tmp matches ..1 run return run item modify entity @s $(slot) oa:nonstack
summon minecraft:item ~ ~0.5 ~ {Tags:["oa.stack_source"],PickupDelay:20s,Item:{id:"minecraft:stone",count:1}}
$execute store success score #stack_ok oa.tmp run item replace entity @e[type=minecraft:item,tag=oa.stack_source,limit=1] contents from entity @s $(slot)
execute unless score #stack_ok oa.tmp matches 1 run return run kill @e[type=minecraft:item,tag=oa.stack_source]
$item replace entity @s $(slot) with minecraft:air
execute as @e[type=minecraft:item,tag=oa.stack_source] at @s run function oa:normal/nonstack/split
tag @e[tag=oa.stack_source] remove oa.stack_source
''')
w(b/'split.mcfunction','''execute store result score #stack_count oa.tmp run data get entity @s Item.count
execute if score #stack_count oa.tmp matches ..1 run return run item modify entity @s contents oa:nonstack
summon minecraft:item ~ ~ ~ {Tags:["oa.stack_copy"],PickupDelay:20s,Item:{id:"minecraft:stone",count:1}}
execute store success score #stack_ok oa.tmp run item replace entity @e[type=minecraft:item,tag=oa.stack_copy,limit=1] contents from entity @s contents oa:nonstack_one
execute unless score #stack_ok oa.tmp matches 1 run return run kill @e[type=minecraft:item,tag=oa.stack_copy]
scoreboard players remove #stack_count oa.tmp 1
execute store result entity @s Item.count int 1 run scoreboard players get #stack_count oa.tmp
tag @e[type=minecraft:item,tag=oa.stack_copy] remove oa.stack_copy
function oa:normal/nonstack/split
''')
with (f/'normal/visual_tick.mcfunction').open('a') as t:t.write('\nfunction oa:normal/nonstack/scan\n')
s=''
for tag in ['{oa_normal:"bat"}','{oa_normal:"kb_stick"}','{oa_overwork:1b}']:
 s+=f'execute as @e[type=minecraft:item,nbt={{Item:{{components:{{"minecraft:custom_data":{tag}}}}}}}] unless items entity @s contents *[minecraft:max_stack_size=1] at @s run function oa:normal/nonstack/split\n'
with (f/'world_tick.mcfunction').open('a') as t:t.write('\n'+s)
# Source and existing docs, no additional readmes.
for x in p.rglob('*'):
 if x.is_file() and x.suffix in ['.md','.mcmeta','.mcfunction']:
  s=x.read_text();t=s.replace('1.6.3','1.6.4').replace('パン2個と採掘用ツルハシ','採掘用ツルハシのみ');
  if t!=s:w(x,t)
x=p/'WEAPONS_JA.md';s=x.read_text().replace('敵を2秒拘束','敵を2.5秒拘束').replace('プレイヤーへのダメージ0。','プレイヤーへの追加ダメージ0.1HP（投げ手由来）。');s+='\n木のバット・木のノックバック棒・ゆー | オーバーワークは最大スタック数1です。ゆーは固有装備の所持制限には含まず、別スロットに複数持つことは可能です。\n';w(x,s)
x=p/'README_JA.md';s=x.read_text().replace('補助命中推定時はダメージ0、','補助命中推定時は投げ手由来の0.1HPダメージ、');s+='\n通常食料はステーキ・りんごのみ（バフ医療品6種は別枠で維持）。初期配布に食料はありません。チェスト食料は前半25%、後半35%で1個。木のバット・ノックバック棒・ゆーはスタック不可。既存のスタックは個数を保持して1個ずつ足元へ分割するため、更新時は安全な場所で回収してください。雪玉・卵の0.1HP追加ダメージは通常の防具・耐性・被ダメージ間隔等の影響を受け、常にHPが0.1減る保証はありません。\n';w(x,s)
shutil.copy('/tmp/build164.py',p/'source/build164.py')
print('164 changes applied')
