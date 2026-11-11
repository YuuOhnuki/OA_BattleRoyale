advancement revoke @s only oa:lobby/gallery/7
execute unless entity @s[type=minecraft:player] run return 0
execute if score @s oa.exread matches 1.. run return 0
scoreboard players set @s oa.exread 4
function oa:lobby/gallery/info/7
playsound minecraft:block.note_block.chime player @s ~ ~ ~ 0.65 1.4
