advancement revoke @s only oa:practice/cooldown
execute unless entity @s[tag=oa.practice] run return 0
execute unless dimension oa:practice run return 0
function oa:practice/reset_cd
playsound minecraft:block.note_block.pling player @s ~ ~ ~ 0.6 1.3
