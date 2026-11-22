scoreboard players set @s br.mdone 1
scoreboard players add @s oa.mclear 1
# 1.9.186: ごほうびは応急キット1つ。1.9.221：難しいお題は2つ
loot give @s loot oa:br/medkit
execute store result score #mission_hard br.tmp run data get storage oa:br mission.hard
execute if score #mission_hard br.tmp matches 1 run loot give @s loot oa:br/medkit
# 1.9.221：「今回のお題」にマウスを乗せると内容が見える
function oa:br/mission/clear_say with storage oa:br mission
playsound minecraft:entity.player.levelup player @s ~ ~ ~ 1 1
function oa:ach/give {id:"mission1",name:"お題達成"}
execute if score @s oa.mclear matches 5.. run function oa:ach/give {id:"mission5",name:"お題マスター"}
