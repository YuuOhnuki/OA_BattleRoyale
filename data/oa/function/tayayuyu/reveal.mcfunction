effect give @s minecraft:glowing 10 0 true
execute unless score @s oa.gglow matches 200.. run scoreboard players set @s oa.gglow 200
tag @s add oa.gacha_glow
tag @s add oa.gacha_affected
function oa:tayayuyu/reveal_fx
