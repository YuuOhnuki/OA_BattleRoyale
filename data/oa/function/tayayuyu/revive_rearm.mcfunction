# 1.9.191: ガチャで復活した人が、キリングのお面を着けたままキルした（ach/new_kill から、本人として）。新しいお面（また60秒）に付け替える
item replace entity @s armor.head with minecraft:air
function oa:internal/cleanup
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.have 0
scoreboard players set @s oa.kind 0
scoreboard players set @s oa.old 0
scoreboard players add #serial oa.serial 1
execute store result storage oa:args serial int 1 run scoreboard players get #serial oa.serial
function oa:give/internal/killing with storage oa:args
function oa:tayayuyu/equip_mask with storage oa:args
particle minecraft:reverse_portal ~ ~1.5 ~ 0.4 0.4 0.4 0.05 30 normal @a[distance=..24]
playsound minecraft:entity.evoker.prepare_summon player @a[distance=..24] ~ ~ ~ 1 1.2
tellraw @s {text:"キル！ 新しいキリングのお面に付け替えた（また60秒）"}
