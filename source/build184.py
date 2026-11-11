from pathlib import Path
import json,shutil
p=Path('revision/pack');f=p/'data/oa/function';b=f/'furoball'
def w(x,s):x.parent.mkdir(parents=True,exist_ok=True);x.write_text(s)
def add(x,s):w(x,x.read_text()+'\n'+s+'\n')
x=b/'push.mcfunction';s=x.read_text();s=s.replace('scoreboard players set @s oa.kpush 6\nscoreboard players set @s oa.kboost 1','''# Consume the whole bounded displacement synchronously; no push timer survives the explosion.
scoreboard players set @s oa.kpush 1
scoreboard players set @s oa.kboost 0
execute store result storage oa:kb id int 1 run scoreboard players get @s oa.id
function oa:knockback/load with storage oa:kb
function oa:furoball/push_once with storage oa:kb
scoreboard players set @s oa.kpush 0
scoreboard players set @s oa.kboost 0''');w(x,s)
line='$execute if score @s oa.kpush matches 1.. at @s rotated $(yaw) 0 positioned ^ ^ ^0.2 run function oa:knockback/probe\n'
w(b/'push_once.mcfunction','# One explosion-time displacement, sampled in 0.2m increments to stop at walls.\n# 36 samples preserve the former maximum total of 7.2m; none are scheduled for later ticks.\n'+line*36)
x=b/'up.mcfunction';s=x.read_text().replace('# Two simulation-frame upward acceleration pulse. From rest, modelled rise ~2.41m.','# One simulation-frame acceleration only, followed by normal gravity.\n# From rest: vy=(0.05*(62+1))*0.2*0.98=0.6174; modelled rise ~2.497m.').replace('levitation 1 31','levitation 1 62').replace('oa.fup 3','oa.fup 2');w(x,s)
x=b/'stop_lift.mcfunction';w(x,'execute if entity @s[tag=oa.furo_up] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:62}] run effect clear @s minecraft:levitation\n'+x.read_text())
for x in p.rglob('*'):
 if x.is_file() and x.suffix in ['.md','.mcmeta','.mcfunction']:
  s=x.read_text();t=s.replace('1.8.3','1.8.4')
  if s!=t:w(x,t)
x=p/'WEAPONS_JA.md';s=x.read_text();s=s.replace('押し出しは壁を検査する短距離移動で、バニラ速度ノックバックではありません。自身の上昇は浮遊の短いパルスによる加速です。','敵への押し出しは爆発時の1回だけで、壁を検査する最大7.2mの単発移動です。0.2m刻みの検査は同じtick内で完了し、その後のtickでは押し続けません。バニラ速度ノックバックではありません。自身の上昇は1シミュレーションtickだけの浮遊加速で、その後は通常の重力です。')
s+='\nふろボールの静止・通常重力モデルでの再計算：加速後の上向き速度は0.6174ブロック/tick、その後は v=(v−0.08)×0.98 として、上昇合計は約2.497ブロック。爆発をworld_tickで処理した同じtickの末尾に加速カウンター2→1、次のtickで1→0として解除するため、加速は1シミュレーションtickだけです。着地までの落下ダメージ無効は維持します。これは実測ではなく、移動状態・天井・他効果による変動があります。\n';w(x,s)
x=p/'README_JA.md';add(x,'ふろボールの押し出しは爆発時の単発処理に統一しています。敵への移動検査は同じtick内で完結し、自分への上向き加速も1シミュレーションtickのみ、その後は通常重力です。静止時の上昇モデルは約2.50mで、着地までの落下ダメージ無効は維持します。')
shutil.copyfile('release_1_8_4/build184.py',p/'source/build184.py')
print('184 single-event push and one-frame self acceleration written')
