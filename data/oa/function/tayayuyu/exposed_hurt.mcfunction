advancement revoke @s only oa:tayayuyu/exposed_hurt
execute if entity @s[tag=oa.ex_extra] run return 0
execute if entity @s[tag=oa.gacha_internal] run return 0
execute unless entity @s[tag=oa.gacha_exposed,nbt=!{Health:0.0f}] run return 0
scoreboard players operation #ex_bonus oa.tmp = @s oa.ex_taken
scoreboard players operation #ex_bonus oa.tmp -= @s oa.ex_prev
scoreboard players operation #ex_bonus oa.tmp += @s oa.ex_absorb
scoreboard players operation #ex_bonus oa.tmp -= @s oa.ex_aprev
execute if score #ex_bonus oa.tmp matches 1.. run function oa:tayayuyu/exposed_bonus
scoreboard players operation @s oa.ex_prev = @s oa.ex_taken
scoreboard players operation @s oa.ex_aprev = @s oa.ex_absorb
