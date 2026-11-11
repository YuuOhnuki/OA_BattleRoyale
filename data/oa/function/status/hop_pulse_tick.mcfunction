scoreboard players remove @s[scores={oa.hlift=1..}] oa.hlift 1
execute if score @s oa.hlift matches 0 run function oa:status/hop_release
