function oa:nero/decoy_release
execute if entity @s[tag=oa.ambush_active] run function oa:yuttari/return
attribute @s minecraft:movement_speed modifier remove oa:staple_root
attribute @s minecraft:jump_strength modifier remove oa:staple_root
tag @s remove oa.stapled
scoreboard players set @s oa.root 0
scoreboard players operation #g_dest oa.tmp = @s oa.gslot
scoreboard players operation #g_dest oa.tmp += #g_offset oa.tmp
scoreboard players operation #g_dest oa.tmp %= #g_count oa.tmp
execute store result storage oa:g_move args.slot int 1 run scoreboard players get #g_dest oa.tmp
particle minecraft:portal ~ ~1 ~ 0.5 0.8 0.5 0.1 24 normal @a[distance=..32]
function oa:tayayuyu/move/tp with storage oa:g_move args
particle minecraft:reverse_portal ~ ~1 ~ 0.5 0.8 0.5 0.1 24 normal @a[distance=..32]
playsound minecraft:entity.enderman.teleport player @s ~ ~ ~ 1.4 1
