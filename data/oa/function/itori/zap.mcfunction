# 1.9.211: フリンズの雷の追撃。鈍足IIを2秒・発光3秒。使用者がシロネン中（#i_zap_boost=1）なら1.5倍
effect give @s minecraft:slowness 2 1 true
effect give @s minecraft:glowing 3 0 true
function oa:itori/lightning_fx
playsound minecraft:entity.lightning_bolt.thunder player @a[distance=..32] ~ ~ ~ 0.65 1.1
execute if score #i_zap_boost oa.tmp matches 1 run return run damage @s 1.5 oa:flins_lightning
damage @s 1 oa:flins_lightning
