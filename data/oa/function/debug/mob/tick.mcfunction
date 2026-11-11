execute if entity @s[tag=oa.debug_dummy,tag=!oa.practice_dummy] unless entity @a[tag=oa.debug,distance=..64] run return run function oa:br/world/remove_mob
function oa:debug/damage_tick
execute if entity @s[nbt={Health:0.0f}] run return run function oa:debug/mob/cleanup
execute unless entity @s[tag=oa.practice_dummy] unless entity @a[tag=oa.debug,distance=..64] run return run function oa:debug/mob/cleanup
function oa:status/tick
function oa:hotchikisu/status_dispatch
execute if entity @s[tag=oa.gacha_affected] run function oa:tayayuyu/tick
execute if score @s oa.kpush matches 1.. run function oa:knockback/tick

execute if score @s oa.tpush matches 1.. run function oa:throwable/push/tick
function oa:debug/damage_tick
execute if entity @s[tag=oa.debug_dummy] run function oa:debug/dummy_tick
