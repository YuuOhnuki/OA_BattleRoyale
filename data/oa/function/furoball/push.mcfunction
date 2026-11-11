execute if entity @s[tag=oa.debug_mob] run return run function oa:debug/mob/blast_push
tag @a remove oa.f_victim
tag @s add oa.f_victim
execute at @e[type=minecraft:item_display,tag=oa.f_current,limit=1] run summon minecraft:marker ~ ~ ~ {Tags:["oa.f_dir"]}
execute as @e[type=minecraft:marker,tag=oa.f_dir,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[tag=oa.f_victim,limit=1] feet
execute store result storage oa:fire_args id int 1 run scoreboard players get @s oa.id
function oa:furoball/save_push with storage oa:fire_args
# Consume the whole bounded displacement synchronously; no push timer survives the explosion.
scoreboard players set @s oa.kpush 1
scoreboard players set @s oa.kboost 0
execute store result storage oa:kb id int 1 run scoreboard players get @s oa.id
function oa:knockback/load with storage oa:kb
function oa:furoball/push_once with storage oa:kb
scoreboard players set @s oa.kpush 0
scoreboard players set @s oa.kboost 0
kill @e[type=minecraft:marker,tag=oa.f_dir]
tag @s remove oa.f_victim
