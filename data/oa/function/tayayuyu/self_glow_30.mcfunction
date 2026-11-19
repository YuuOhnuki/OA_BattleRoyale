# 1.9.192: self_glow の30秒版（瀕死の時間）
effect give @s minecraft:glowing 30 0 true
execute unless score @s oa.gglow matches 600.. run scoreboard players set @s oa.gglow 600
tag @s add oa.gacha_glow
tag @s add oa.gacha_affected
