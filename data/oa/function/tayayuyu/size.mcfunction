attribute @s minecraft:scale modifier remove oa:komame_small
attribute @s minecraft:scale modifier remove oa:gacha_size
$attribute @s minecraft:scale modifier add oa:gacha_size $(amount) add_multiplied_total
$scoreboard players set @s oa.gsize $(ticks)
tag @s add oa.gacha_affected
tag @s add oa.gacha_size
particle minecraft:happy_villager ~ ~1 ~ 0.5 0.5 0.5 0 16 normal @a[distance=..32]
playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 1.2 1.6
