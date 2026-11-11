advancement revoke @s only oa:practice/day
execute unless entity @s[tag=oa.practice] run return 0
execute unless dimension oa:practice run return 0
time set 6000t
playsound minecraft:block.note_block.pling player @s ~ ~ ~ 0.6 1.3
