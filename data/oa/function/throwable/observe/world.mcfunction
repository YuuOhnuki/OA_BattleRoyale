execute unless entity @a[tag=oa.debug,tag=oa.db_free_match] unless score #state br.state matches 1 run return run kill @e[distance=0..,tag=oa.throw_observer]
execute as @e[distance=0..,type=minecraft:snowball,tag=!oa.throw_observed] at @s run function oa:throwable/observe/init
execute as @e[distance=0..,type=minecraft:egg,tag=!oa.throw_observed] at @s run function oa:throwable/observe/init
execute as @e[distance=0..,type=minecraft:marker,tag=oa.throw_observer] at @s run function oa:throwable/observe/tick
