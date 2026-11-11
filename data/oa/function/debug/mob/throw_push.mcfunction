execute store result entity @s Motion[0] double 0.00012 run scoreboard players get #mx oa.tmp
execute store result entity @s Motion[2] double 0.00012 run scoreboard players get #mz oa.tmp
data modify entity @s Motion[1] set value 0.1d
execute if score #obs_snow oa.tmp matches 0 store result entity @s Motion[0] double 0.00018 run scoreboard players get #mx oa.tmp
execute if score #obs_snow oa.tmp matches 0 store result entity @s Motion[2] double 0.00018 run scoreboard players get #mz oa.tmp
execute if score #obs_snow oa.tmp matches 0 run data modify entity @s Motion[1] set value 0.15d
