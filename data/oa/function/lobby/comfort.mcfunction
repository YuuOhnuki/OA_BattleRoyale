execute if entity @s[tag=br.playing] run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_heal] run return 0
execute unless entity @s[tag=oa.lobby_safe] run attribute @s minecraft:fall_damage_multiplier modifier add oa:lobby_fall -1 add_multiplied_total
tag @s add oa.lobby_safe
execute if score #perf oa.tmp matches 0 run effect give @s minecraft:fire_resistance 2 0 true
execute if score #perf oa.tmp matches 0 run effect give @s minecraft:water_breathing 2 0 true
execute if score #perf oa.tmp matches 0 run effect give @s minecraft:instant_health 1 1 true
execute if score #perf oa.tmp matches 0 run effect give @s minecraft:saturation 1 0 true
