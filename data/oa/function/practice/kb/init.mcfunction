# 1.9.247：吹き飛ぶ標的の初期化（新しく出したゾンビとして）。ノックバックを受ける・自分では動かない・襲わない・倒れない
# NoAI にすると物理（重力・ノックバック）も止まるので使わない。歩く速さ・追う距離・攻撃力を0にする
tag @s add oa.kb_target
tag @s add oa.kb
scoreboard players operation @s oa.kb_pair = #kp oa.tmp
scoreboard players set @s oa.kb_idle 0
attribute @s minecraft:max_health base set 1024
attribute @s minecraft:knockback_resistance base set 0
attribute @s minecraft:movement_speed base set 0
attribute @s minecraft:armor base set 0
attribute @s minecraft:follow_range base set 0
attribute @s minecraft:attack_damage base set 0
data merge entity @s {Health:1024.0f,Silent:1b,PersistenceRequired:1b,IsBaby:0b,CanPickUpLoot:0b,DeathLootTable:"minecraft:empty",CustomName:{text:"吹き飛ぶ標的"},CustomNameVisible:1b}
data remove entity @s equipment
function oa:practice/no_burn
