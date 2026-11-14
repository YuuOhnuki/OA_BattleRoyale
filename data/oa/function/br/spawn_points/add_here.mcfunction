function oa:br/spawn_points/check
execute unless score #spawn_floor br.flag matches 1 run return run tellraw @s [{text:"【",color:"gray"},{nbt:"label",storage:"oa:spawn_points",color:"aqua"},{text:"】",color:"gray"},{text:"登録できません。足元がブロックで（溶岩・火・水・クモの巣などの上は不可）、頭上に2ブロックの空間がある場所を選んでください",color:"red"}]
summon minecraft:marker ~ ~ ~ {Tags:["br.point_new"]}
data modify storage oa:spawn_points new set value {}
data modify storage oa:spawn_points new.x set from entity @e[type=minecraft:marker,tag=br.point_new,limit=1] Pos[0]
data modify storage oa:spawn_points new.y set from entity @e[type=minecraft:marker,tag=br.point_new,limit=1] Pos[1]
data modify storage oa:spawn_points new.z set from entity @e[type=minecraft:marker,tag=br.point_new,limit=1] Pos[2]
kill @e[type=minecraft:marker,tag=br.point_new]
function oa:br/spawn_points/append with storage oa:spawn_points new
