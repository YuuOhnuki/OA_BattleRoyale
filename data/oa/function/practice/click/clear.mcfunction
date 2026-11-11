advancement revoke @s only oa:practice/clear
execute unless entity @s[tag=oa.practice] run return 0
execute unless dimension oa:practice run return 0
weather clear 1000000t
playsound minecraft:block.note_block.pling player @s ~ ~ ~ 0.6 1.3
