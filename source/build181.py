from pathlib import Path
import json,shutil
p=Path('revision/pack');f=p/'data/oa/function';b=f/'furoball'
def w(x,s):x.parent.mkdir(parents=True,exist_ok=True);x.write_text(s)
def add(x,s):w(x,x.read_text()+'\n'+s+'\n')
w(b/'up.mcfunction','''# Two simulation-frame upward acceleration pulse. From rest, modelled rise ~9.84m.
effect give @s minecraft:levitation 1 72 true
scoreboard players set @s oa.fup 3
scoreboard players set @s oa.fage 0
scoreboard players set @s oa.fair 0
tag @s add oa.furo_up
tag @s add oa.furo_fall
attribute @s minecraft:fall_damage_multiplier modifier remove oa:furo_fall
attribute @s minecraft:fall_damage_multiplier modifier add oa:furo_fall -1 add_multiplied_total
particle minecraft:cloud ~ ~0.1 ~ 0.6 0.1 0.6 0.18 32 normal @a[distance=..32]
playsound minecraft:entity.firework_rocket.launch player @s ~ ~ ~ 1.3 0.8
''')
w(b/'stop_lift.mcfunction','''execute if entity @s[tag=oa.furo_up] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:72}] run effect clear @s minecraft:levitation
execute if entity @s[tag=oa.furo_up] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:44}] run effect clear @s minecraft:levitation
tag @s remove oa.furo_up
scoreboard players set @s oa.fup 0
''')
w(b/'up_tick.mcfunction','''execute unless entity @s[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] run return run function oa:furoball/clear_up
execute unless score #state br.state matches 1 run return run function oa:furoball/clear_up
scoreboard players add @s oa.fage 1
scoreboard players remove @s[scores={oa.fup=1..}] oa.fup 1
execute if score @s oa.fup matches 0 if entity @s[tag=oa.furo_up] run function oa:furoball/stop_lift
execute if entity @s[nbt={OnGround:0b}] run scoreboard players set @s oa.fair 1
# The next tick after landing removes only this item's own fall modifier.
execute if score @s oa.fage matches 4.. if score @s oa.fair matches 1 if entity @s[nbt={OnGround:1b}] run return run function oa:furoball/clear_up
# A blocked launch that never left the floor must not retain immunity indefinitely.
execute if score @s oa.fage matches 20.. if score @s oa.fair matches 0 if entity @s[nbt={OnGround:1b}] run return run function oa:furoball/clear_up
execute if score @s oa.fage matches 4.. if block ~ ~ ~ minecraft:water run return run function oa:furoball/clear_up
execute if score @s oa.fage matches 4.. if block ~ ~ ~ minecraft:lava run return run function oa:furoball/clear_up
execute if score @s oa.fage matches 4.. if data entity @s RootVehicle run return run function oa:furoball/clear_up
''')
w(b/'clear_up.mcfunction','''function oa:furoball/stop_lift
attribute @s minecraft:fall_damage_multiplier modifier remove oa:furo_fall
tag @s remove oa.furo_fall
scoreboard players set @s oa.fage 0
scoreboard players set @s oa.fair 0
''')
x=f/'tick.mcfunction';s=x.read_text().replace('execute as @a[tag=oa.furo_up] at @s run function oa:furoball/up_tick','execute as @a[tag=oa.furo_fall] at @s run function oa:furoball/up_tick');w(x,s)
x=f/'br/finish.mcfunction';w(x,x.read_text().replace('execute as @a[tag=oa.furo_up] run function oa:furoball/clear_up','execute as @a[tag=oa.furo_fall] run function oa:furoball/clear_up'))
for name in ['test/reset','internal/death']:add(f/(name+'.mcfunction'),'function oa:furoball/clear_up')
for obj in ['oa.fage','oa.fair']:add(f/'load.mcfunction',f'scoreboard objectives add {obj} dummy')
# Existing UI item explains the fall protection, new loot copies are consistent.
for x in (p/'data/oa/loot_table').rglob('*.json'):
 d=json.loads(x.read_text())
 def walk(o):
  if isinstance(o,dict):
   c=o.get('components',{});data=c.get('minecraft:custom_data',{})
   if data.get('oa_furoball'):
    c['minecraft:lore']=[{'text':'右クリック：爆風で周囲を吹き飛ばす','color':'gray','italic':False},{'text':'自分は約10m上昇／着地まで落下ダメージ無効','color':'gray','italic':False},{'text':'使い切り／再使用1秒','color':'gray','italic':False}]
   for v in o.values():walk(v)
  elif isinstance(o,list):
   for v in o:walk(v)
 walk(d);x.write_text(json.dumps(d,ensure_ascii=False,indent=2))
# Upgrade any existing held consumable without changing its count or other data.
d=json.loads((p/'data/oa/loot_table/br/test/furoball.json').read_text());lore=d['pools'][0]['entries'][0]['modifier'][0]['components']['minecraft:lore'];x=p/'data/oa/item_modifier/furo_lore181.json';w(x,json.dumps({'type':'minecraft:sequence','functions':[{'type':'minecraft:set_components','components':{'minecraft:lore':lore}},{'type':'minecraft:set_custom_data','tag':'{furo_lore181:1b}'}]},ensure_ascii=False,indent=2))
for slot in ['weapon.mainhand','weapon.offhand']:add(f/'normal/visual_tick.mcfunction',f'execute if items entity @s {slot} *[minecraft:custom_data~{{oa_furoball:1b}}] unless items entity @s {slot} *[minecraft:custom_data~{{furo_lore181:1b}}] run item modify entity @s {slot} oa:furo_lore181')
# Existing participant guides update automatically from their own version marker.
x=f/'lobby/guide/book.mcfunction';s=x.read_text().replace('guide_v180','guide_v181').replace('自分は上昇。','自分は約10m上昇し、着地まで落下ダメージ無効。');w(x,s)
for x in p.rglob('*'):
 if x.is_file() and x.suffix in ['.md','.mcmeta','.mcfunction']:
  s=x.read_text();t=s.replace('1.8.0','1.8.1')
  if x.suffix=='.md':
   t=t.replace('近くで爆発したときに上向き加速を受けます。落下ダメージは通常どおりです。','近くで爆発したときに約10mの上向き加速を受け、続く最初の着地まで落下ダメージを無効にします。着地・着水・乗り物への乗車・死亡・試合終了・退出後の再参加・テストリセットで専用補正を解除します。')
  if t!=s:w(x,t)
x=p/'WEAPONS_JA.md';add(x,'上昇の約10mは静止状態・通常重力での計算上の目安です。すでに上昇中／落下中、天井、水中、ほかの効果がある場合は変化し、厳密な高さ10mの位置制限ではありません。ふろボールが原因の飛行を終えた後の別の落下まで無効化する効果ではありません。')
x=p/'README_JA.md';add(x,'ふろボールの自分への上昇は約10mに調整し、その後の最初の着地まで落下ダメージを無効にします。本体1.8.0からの更新はZIP交換と `/reload` で反映できます。リソパ交換・マップ再生成は不要です。')
shutil.copy('release_1_8_1/build181.py',p/'source/build181.py')
print('181 rocket ascent and single-flight fall protection written')
