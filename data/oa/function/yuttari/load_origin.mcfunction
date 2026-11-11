$data modify storage oa:ambush returning set from storage oa:players p$(id).ambush_origin
function oa:yuttari/teleport_fx
function oa:internal/tp with storage oa:ambush returning
execute at @s run function oa:yuttari/teleport_fx
$data remove storage oa:players p$(id).ambush_origin
execute at @s run particle minecraft:reverse_portal ~ ~1 ~ 0.4 0.6 0.4 0.04 24 normal @a[distance=..32]
execute at @s run playsound minecraft:entity.enderman.teleport player @a[distance=..32] ~ ~ ~ 1.2 1.2
