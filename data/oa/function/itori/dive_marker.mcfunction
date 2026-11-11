summon minecraft:marker ~ ~ ~ {Tags:["oa.i_dive_goal","oa.i_new"]}
scoreboard players set #i_diver oa.tmp 0
execute as @a[tag=oa.caster,limit=1] run scoreboard players operation #i_diver oa.tmp = @s oa.id
scoreboard players operation @e[tag=oa.i_new,limit=1] oa.owner = #i_diver oa.tmp
scoreboard players set #i_ground_steps oa.tmp 12
execute as @e[tag=oa.i_new,limit=1] at @s positioned ~ ~2 ~ run function oa:itori/dive_ground
execute as @e[tag=oa.i_new,tag=!oa.dive_valid] run kill @s
tag @e[tag=oa.i_new] remove oa.i_new
