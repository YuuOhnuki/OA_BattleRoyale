scoreboard players set #heal_clock tdm.sys 0
execute as @e[tag=tdm.loot_point,sort=random,limit=1] at @s unless entity @e[tag=tdm.pickup,distance=..3] run function oa:tdm/loot/heal_drop
