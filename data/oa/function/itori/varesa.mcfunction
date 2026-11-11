execute store result score #i_divesize oa.tmp run attribute @s minecraft:scale get 1000
execute if score #i_divesize oa.tmp matches 1001.. run return run scoreboard players set #i_cast_ok oa.tmp 0
tellraw @s {"text": "ヴァレサ：シャイニングヴェント！", "color": "light_purple"}
function oa:itori/cast_begin
execute as @e[tag=oa.target,distance=5.01..] run tag @s remove oa.target
execute if entity @e[tag=oa.target] at @e[tag=oa.target,sort=nearest,limit=1] run function oa:itori/dive_marker
execute unless entity @e[tag=oa.target] rotated ~ 0 positioned ^ ^ ^2 run function oa:itori/dive_marker
function oa:itori/cast_end
execute store result storage oa:itori id int 1 run scoreboard players get @s oa.id
scoreboard players set #i_goal_found oa.tmp 0
function oa:itori/dive_exists with storage oa:itori
execute unless score #i_goal_found oa.tmp matches 1 run return run scoreboard players set #i_cast_ok oa.tmp 0
function oa:itori/dive_preview with storage oa:itori
scoreboard players set @s oa.i_dive 37
attribute @s minecraft:fall_damage_multiplier modifier remove oa:itori_dive
attribute @s minecraft:fall_damage_multiplier modifier add oa:itori_dive -1 add_multiplied_total
playsound minecraft:entity.breeze.jump player @a[distance=..32] ~ ~ ~ 1 1.3
attribute @s minecraft:gravity modifier remove oa:itori_dive
attribute @s minecraft:gravity modifier add oa:itori_dive -1 add_multiplied_total
particle minecraft:gust ~ ~0.1 ~ 0.35 0.05 0.35 0 6 normal @a[distance=..32]
playsound minecraft:entity.wind_charge.wind_burst player @a[distance=..32] ~ ~ ~ 1.0 0.85
