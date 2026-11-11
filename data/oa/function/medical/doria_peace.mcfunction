advancement revoke @s only oa:medical/doria_peace
execute unless entity @s[tag=oa.gacha_peace] run return 0
execute if score @s oa.gres_amp matches 1.. run return 0
scoreboard players set @s oa.gres_amp 0
execute unless score @s oa.gres_left matches 200.. run scoreboard players set @s oa.gres_left 200
