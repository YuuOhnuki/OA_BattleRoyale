# 1.9.189: 外に出て2秒（br.outt 40 tick）経つまでダメージなし（br/zone/out_track が数える）
execute unless dimension oa:br unless dimension oa:br_nether unless dimension oa:br_cave if score @s br.outt matches 40.. run return run function oa:br/zone/damage with storage oa:br_zone
execute unless dimension oa:br unless dimension oa:br_nether unless dimension oa:br_cave run return 0
execute store result score #px br.x run data get entity @s Pos[0] 1000
execute store result score #pz br.z run data get entity @s Pos[2] 1000
scoreboard players set #out br.flag 0
execute if score #px br.x < #minx br.x run scoreboard players set #out br.flag 1
execute if score #px br.x > #maxx br.x run scoreboard players set #out br.flag 1
execute if score #pz br.z < #minz br.z run scoreboard players set #out br.flag 1
execute if score #pz br.z > #maxz br.z run scoreboard players set #out br.flag 1
execute if score #out br.flag matches 1 if score @s br.outt matches 40.. run function oa:br/zone/damage with storage oa:br_zone
scoreboard players operation @s br.out = #out br.flag
