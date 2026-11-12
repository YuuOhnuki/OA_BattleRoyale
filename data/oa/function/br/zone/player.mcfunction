execute unless dimension oa:br unless dimension oa:br_nether run return run function oa:br/zone/damage with storage oa:br_zone
execute store result score #px br.x run data get entity @s Pos[0] 1000
execute store result score #pz br.z run data get entity @s Pos[2] 1000
scoreboard players set #out br.flag 0
execute if score #px br.x < #minx br.x run scoreboard players set #out br.flag 1
execute if score #px br.x > #maxx br.x run scoreboard players set #out br.flag 1
execute if score #pz br.z < #minz br.z run scoreboard players set #out br.flag 1
execute if score #pz br.z > #maxz br.z run scoreboard players set #out br.flag 1
execute if score #out br.flag matches 1 run function oa:br/zone/damage with storage oa:br_zone
scoreboard players operation @s br.out = #out br.flag
