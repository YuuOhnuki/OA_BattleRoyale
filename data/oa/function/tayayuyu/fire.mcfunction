scoreboard players set @s oa.gfire 200
# 1.9.191: 10秒・発光10秒・各自の位置で派手な爆発音と花火の粒
function oa:tayayuyu/reveal
playsound minecraft:entity.generic.explode player @a[distance=..48] ~ ~ ~ 1.2 0.9
particle minecraft:flame ~ ~1 ~ 0.5 0.8 0.5 0.1 40 normal @a[distance=..48]
scoreboard players operation @s oa.gby = #gacha_caster oa.tmp

tag @s add oa.gacha_affected
