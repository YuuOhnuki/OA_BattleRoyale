# Explicitly authorized consumable expiry; remove only the equipped Killing mask.
execute unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run return 0
item replace entity @s armor.head with minecraft:air
function oa:internal/cleanup
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.have 0
scoreboard players set @s oa.kind 0
scoreboard players set @s oa.old 0
particle minecraft:reverse_portal ~ ~1.5 ~ 0.4 0.4 0.4 0.03 25 normal @a[distance=..24]
playsound minecraft:entity.item.break player @s ~ ~ ~ 1 0.8
tellraw @s {text:"1分経過：キリングのマスクが壊れ、呪いが解けました",color:"light_purple"}
