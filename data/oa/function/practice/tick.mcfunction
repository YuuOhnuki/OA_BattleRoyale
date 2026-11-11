execute if entity @s[tag=oa.practice_exiting] run return 0
execute unless dimension oa:practice run return run function oa:practice/leave
execute unless data storage oa:practice {layout:1996} unless data storage oa:practice {building:1b} run function oa:practice/prepare
execute unless entity @s[x=-50,y=59,z=-50,dx=100,dy=150,dz=100] run tp @s 0.5 65 35.5 180 0
execute if score #perf oa.tmp matches 0 run function oa:debug/items_tick
execute if score #perf oa.tmp matches 0 run effect give @s minecraft:saturation 2 3 true
execute if score #perf oa.tmp matches 0 run effect give @s minecraft:resistance infinite 4 true
execute if score #perf oa.tmp matches 0 run tag @s remove br.login_pending

execute unless entity @s[team=oa_practice] run team join oa_practice @s
