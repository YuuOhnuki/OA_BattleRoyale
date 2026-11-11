scoreboard players set @s br.edge 2000000000
scoreboard players operation #inset br.tmp = #half br.tmp
scoreboard players operation #inset br.tmp /= #two br.tmp
execute if score #inset br.tmp matches 3001.. run scoreboard players set #inset br.tmp 3000
scoreboard players operation #distance br.tmp = #px br.x
scoreboard players operation #distance br.tmp -= #minx br.x
function oa:br/zone/distance
execute if score #distance br.tmp matches ..-1 run function oa:br/zone/wall_minx with storage oa:br_zone
scoreboard players operation #distance br.tmp = #px br.x
scoreboard players operation #distance br.tmp -= #maxx br.x
function oa:br/zone/distance
execute if score #distance br.tmp matches ..-1 run function oa:br/zone/wall_maxx with storage oa:br_zone
scoreboard players operation #distance br.tmp = #pz br.z
scoreboard players operation #distance br.tmp -= #minz br.z
function oa:br/zone/distance
execute if score #distance br.tmp matches ..-1 run function oa:br/zone/wall_minz with storage oa:br_zone
scoreboard players operation #distance br.tmp = #pz br.z
scoreboard players operation #distance br.tmp -= #maxz br.z
function oa:br/zone/distance
execute if score #distance br.tmp matches ..-1 run function oa:br/zone/wall_maxz with storage oa:br_zone
scoreboard players operation @s br.edge /= #1000 br.tmp
execute if entity @s[tag=br.alive] if score @s br.out matches 1 run particle minecraft:dust{color:[1.0,0.03,0.01],scale:2.0} ~ ~1 ~ 0.5 0.8 0.5 0 12 force @s
