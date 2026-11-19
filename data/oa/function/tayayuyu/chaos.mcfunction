function oa:nero/decoy_release
execute if entity @s[tag=oa.ambush_active] run function oa:yuttari/return
attribute @s minecraft:movement_speed modifier remove oa:staple_root
attribute @s minecraft:jump_strength modifier remove oa:staple_root
tag @s remove oa.stapled
scoreboard players set @s oa.root 0
execute unless data storage oa:spawn_pool points[0] run data modify storage oa:spawn_pool points set from storage oa:spawn_points points
function oa:br/spawn_points/pick
particle minecraft:portal ~ ~1 ~ 0.5 0.8 0.5 0.1 24 normal @a[distance=..32]
execute if data storage oa:spawn_pool selected.x run function oa:br/tp_position with storage oa:spawn_pool selected
execute at @s run particle minecraft:reverse_portal ~ ~1 ~ 0.5 0.8 0.5 0.1 40 normal @a[distance=..32]
execute at @s run playsound minecraft:entity.enderman.teleport player @a[distance=..32] ~ ~ ~ 1.4 0.8
title @s actionbar {text:"天変地異！ どこかへ飛ばされた",color:"light_purple"}
