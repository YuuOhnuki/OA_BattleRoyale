scoreboard players set #yu_clock tdm.sys 0
execute store result score #yu_roll tdm.sys run random value 1..5
execute unless score #yu_roll tdm.sys matches 1..2 run return 0
scoreboard players set #drop_kind tdm.sys 103
execute as @e[tag=tdm.loot_point,sort=random,limit=1] at @s run function oa:tdm/loot/create
