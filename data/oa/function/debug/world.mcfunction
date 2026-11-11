execute as @e[distance=0..,tag=oa.debug_mob] at @s run function oa:debug/mob/tick
scoreboard players remove @e[distance=0..,type=minecraft:text_display,tag=oa.debug_damage_label,scores={oa.db_label=1..}] oa.db_label 1
kill @e[distance=0..,type=minecraft:text_display,tag=oa.debug_damage_label,scores={oa.db_label=..0}]

execute if dimension oa:practice as @e[distance=0..,type=minecraft:marker,tag=oa.practice_dummy_spawn] at @s run function oa:practice/dummy_slot

execute if dimension oa:practice as @e[type=minecraft:marker,tag=oa.practice_no_xp,distance=0..] at @s run function oa:practice/dummy_death_tick
