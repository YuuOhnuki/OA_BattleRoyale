execute if entity @s[tag=oa.debug_mob] run return run function oa:debug/mob/throw_push
# Independent of Yuttari displacement; fixed bounded zero-damage push.
scoreboard players set #px oa.tmp 0
scoreboard players set #pz oa.tmp 0
execute if score #mx oa.tmp matches 1.. run scoreboard players set #px oa.tmp 7
execute if score #mx oa.tmp matches ..-1 run scoreboard players set #px oa.tmp -7
execute if score #mz oa.tmp matches 1.. run scoreboard players set #pz oa.tmp 7
execute if score #mz oa.tmp matches ..-1 run scoreboard players set #pz oa.tmp -7
execute if score #px oa.tmp matches 0 if score #pz oa.tmp matches 0 run return 0
execute store result storage oa:throw_push args.x double 0.01 run scoreboard players get #px oa.tmp
execute store result storage oa:throw_push args.z double 0.01 run scoreboard players get #pz oa.tmp
# Eggs only: multiply horizontal displacement by 1.5 (0.07 -> 0.105 per step).
execute if score #obs_snow oa.tmp matches 0 store result storage oa:throw_push args.x double 0.015 run scoreboard players get #px oa.tmp
execute if score #obs_snow oa.tmp matches 0 store result storage oa:throw_push args.z double 0.015 run scoreboard players get #pz oa.tmp
execute store result storage oa:throw_push args.id int 1 run scoreboard players get @s oa.id
function oa:throwable/push/save with storage oa:throw_push args
scoreboard players set @s oa.tpush 3
