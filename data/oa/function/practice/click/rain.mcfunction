advancement revoke @s only oa:practice/rain
execute unless entity @s[tag=oa.practice] run return 0
execute unless dimension oa:practice run return 0
weather rain 1000000t
playsound minecraft:block.note_block.pling player @s ~ ~ ~ 0.6 1.3
