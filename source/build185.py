from pathlib import Path
import json,shutil
p=Path('revision/pack');f=p/'data/oa/function';b=f/'furoball'
def w(x,s):x.parent.mkdir(parents=True,exist_ok=True);x.write_text(s)
def add(x,s):w(x,x.read_text()+'\n'+s+'\n')
# A single initial Motion assignment; subsequent movement uses native entity physics.
w(b/'up.mcfunction','''# Replace the levitation pulse with the same native physics carrier technique as Jump Pad.
function oa:furoball/stop_lift
execute if data entity @s RootVehicle run return 0
summon minecraft:armor_stand ~ ~-0.95 ~ {Tags:["oa.furo_carrier","oa.furo_carrier_new"],Invisible:1b,Small:1b,Invulnerable:1b,NoBasePlate:1b,Silent:1b,Motion:[0.0d,0.62d,0.0d]}
scoreboard players operation @e[type=minecraft:armor_stand,tag=oa.furo_carrier_new] oa.fowner = @s oa.id
scoreboard players operation @e[type=minecraft:armor_stand,tag=oa.furo_carrier_new] br.round = #round br.round
scoreboard players set @e[type=minecraft:armor_stand,tag=oa.furo_carrier_new] oa.fcage 0
execute store success score #f_mounted oa.tmp run ride @s mount @e[type=minecraft:armor_stand,tag=oa.furo_carrier_new,limit=1]
execute unless score #f_mounted oa.tmp matches 1 run return run kill @e[type=minecraft:armor_stand,tag=oa.furo_carrier_new]
tag @e[type=minecraft:armor_stand,tag=oa.furo_carrier_new] remove oa.furo_carrier_new
scoreboard players set @s oa.fup 0
scoreboard players set @s oa.fage 0
scoreboard players set @s oa.fair 1
tag @s add oa.furo_up
tag @s add oa.furo_fall
attribute @s minecraft:fall_damage_multiplier modifier remove oa:furo_fall
attribute @s minecraft:fall_damage_multiplier modifier add oa:furo_fall -1 add_multiplied_total
particle minecraft:cloud ~ ~0.1 ~ 0.6 0.1 0.6 0.18 32 normal @a[distance=..32]
playsound minecraft:entity.firework_rocket.launch player @s ~ ~ ~ 1.3 0.8
''')
x=b/'stop_lift.mcfunction';s=x.read_text();w(x,'execute on vehicle if entity @s[type=minecraft:armor_stand,tag=oa.furo_carrier] run function oa:furoball/carrier/release\n'+s)
x=b/'up_tick.mcfunction';s=x.read_text();start=s.index('scoreboard players remove @s[scores={oa.fup=1..}]');end=s.index('execute if entity @s[nbt={OnGround:0b}]');s=s[:start]+'''# Do not remove protection while the player is using this item's own carrier.
execute on vehicle if entity @s[type=minecraft:armor_stand,tag=oa.furo_carrier] run return 0
'''+s[end:];w(x,s)
w(b/'carrier/tick.mcfunction','''execute unless score #state br.state matches 1 run return run function oa:furoball/carrier/release
execute unless score @s br.round = #round br.round run return run function oa:furoball/carrier/release
execute unless data entity @s Passengers[0] run return run function oa:furoball/carrier/release
scoreboard players add @s oa.fcage 1
execute if score @s oa.fcage matches 40.. run return run function oa:furoball/carrier/release
scoreboard players set #f_roof_clear oa.tmp 1
execute on passengers at @s run function oa:furoball/carrier/clearance
execute if score #f_roof_clear oa.tmp matches 0 run return run function oa:furoball/carrier/release
execute store result score #f_car_vy oa.tmp run data get entity @s Motion[1] 10000
execute if score @s oa.fcage matches 2.. if score #f_car_vy oa.tmp matches ..0 run return run function oa:furoball/carrier/release
execute if score @s oa.fcage matches 3.. if entity @s[nbt={OnGround:1b}] run function oa:furoball/carrier/release
''')
w(b/'carrier/release.mcfunction','''scoreboard players operation #f_car_owner oa.tmp = @s oa.fowner
execute on passengers run ride @s dismount
execute as @a if score @s oa.id = #f_car_owner oa.tmp run tag @s remove oa.furo_up
kill @s
''')
w(b/'carrier/clearance.mcfunction','''execute if entity @s[nbt={Health:0.0f}] run return run scoreboard players set #f_roof_clear oa.tmp 0
execute if entity @s[gamemode=spectator] run return run scoreboard players set #f_roof_clear oa.tmp 0
execute store result score #f_car_scale oa.tmp run attribute @s minecraft:scale get 1000
scoreboard players set #f_car_ten oa.tmp 10
scoreboard players set #f_car_18 oa.tmp 18
scoreboard players set #f_car_3 oa.tmp 3
scoreboard players operation #f_car_h oa.tmp = #f_car_scale oa.tmp
scoreboard players operation #f_car_h oa.tmp *= #f_car_18 oa.tmp
scoreboard players operation #f_car_h oa.tmp /= #f_car_ten oa.tmp
scoreboard players add #f_car_h oa.tmp 700
scoreboard players operation #f_car_w oa.tmp = #f_car_scale oa.tmp
scoreboard players operation #f_car_w oa.tmp *= #f_car_3 oa.tmp
scoreboard players operation #f_car_w oa.tmp /= #f_car_ten oa.tmp
scoreboard players set #f_car_neg oa.tmp 0
scoreboard players operation #f_car_neg oa.tmp -= #f_car_w oa.tmp
execute store result storage oa:furo_head height double 0.001 run scoreboard players get #f_car_h oa.tmp
execute store result storage oa:furo_head width double 0.001 run scoreboard players get #f_car_w oa.tmp
execute store result storage oa:furo_head neg double 0.001 run scoreboard players get #f_car_neg oa.tmp
function oa:furoball/carrier/head_probe with storage oa:furo_head
''')
s=''
for x in ['$(neg)','0','$(width)']:
 for z in ['$(neg)','0','$(width)']:s+=f'$execute unless block ~{x} ~$(height) ~{z} #minecraft:air run scoreboard players set #f_roof_clear oa.tmp 0\n'
w(b/'carrier/head_probe.mcfunction',s)
x=f/'world_tick.mcfunction';w(x,'execute as @e[type=minecraft:armor_stand,tag=oa.furo_carrier] at @s run function oa:furoball/carrier/tick\n'+x.read_text())
add(f/'load.mcfunction','scoreboard objectives add oa.fcage dummy')
# Clearing a player never removes another player's carrier. Finish also removes orphaned loaded carriers.
add(f/'br/finish.mcfunction','''execute in minecraft:overworld as @e[type=minecraft:armor_stand,tag=oa.furo_carrier] run function oa:furoball/carrier/release
execute in minecraft:the_nether as @e[type=minecraft:armor_stand,tag=oa.furo_carrier] run function oa:furoball/carrier/release
execute in minecraft:the_end as @e[type=minecraft:armor_stand,tag=oa.furo_carrier] run function oa:furoball/carrier/release''')
for x in p.rglob('*'):
 if x.is_file() and x.suffix in ['.md','.mcmeta','.mcfunction']:
  s=x.read_text();t=s.replace('1.8.4','1.8.5')
  if s!=t:w(x,t)
x=p/'WEAPONS_JA.md';s=x.read_text();s=s.replace('自身の上昇は1シミュレーションtickだけの浮遊加速で、その後は通常の重力です。','自身の上昇には一時的な透明防具立てを使い、初速を一度だけ設定します。浮遊での持ち上げや毎tickの速度再設定はしません。頂点付近で降車し、その後はプレイヤーが自然落下します。')
a=s.find('ふろボールの静止・通常重力モデルでの再計算：')
if a>=0:
 e=s.find('\n',a);s=s[:a]+s[e+1:]
s+='''
ふろボールの上昇は既存ジャンプパッドと同じ透明防具立ての物理キャリア方式です。爆発時に `Motion:[0.0d,0.62d,0.0d]` を1回だけ設定し、以後はネイティブの重力・抵抗で動きます。キャリアが頂点付近に達したら降車・削除します。Shift等で早く降りた場合もキャリアを削除します。着地までの落下ダメージ無効は維持します。他の乗り物に乗っているときは上向き発射を行いません。
初速0.62、重力0.08、抵抗0.98の離散モデルでは、キャリアの上昇量は約2.517ブロック、頂点まで8tickです。実際のプレイヤーの足元高度は搭乗・降車位置、天井や水等で変わり、実機未検証です。搭乗中は通常の歩行操作ができず、頂点付近で操作が戻ります。プレイヤーのMotionを直接書き換える処理ではありません。
''';w(x,s)
x=p/'README_JA.md';s=x.read_text().replace('自分への上向き加速も1シミュレーションtickのみ、その後は通常重力です。','自分への上昇は透明な物理キャリアへ初速を一度だけ与え、頂点付近で降車する方式です。');s+='\nふろボールは浮遊効果による持ち上げを廃止しました。ジャンプパッドと同じ一時的な物理キャリア方式で跳ね上げます。計算上のキャリア上昇量は約2.52mですが、実プレイヤー高度は実測未確認です。\n';w(x,s)
shutil.copyfile('release_1_8_5/build185.py',p/'source/build185.py')
print('185 one-shot native carrier launch written')
