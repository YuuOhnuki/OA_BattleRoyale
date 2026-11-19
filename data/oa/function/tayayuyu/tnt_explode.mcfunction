# 1.9.191: TNTの雨の爆発。1.5m以内8HP、3m以内5HP、4.5m以内3HP（最大8HP）。地形は壊さない
particle minecraft:explosion_emitter ~ ~0.5 ~ 0 0 0 0 1 normal @a[distance=..48]
playsound minecraft:entity.generic.explode player @a[distance=..48] ~ ~ ~ 1.2 1
tag @a remove oa.g_source
scoreboard players operation #g_owner oa.tmp = @s oa.gby
execute as @a if score @s oa.id = #g_owner oa.tmp run tag @s add oa.g_source
execute as @a[tag=br.alive,tag=!br.pvp_grace,distance=..1.5] run function oa:tayayuyu/tnt_hit {amount:8}
execute as @a[tag=br.alive,tag=!br.pvp_grace,distance=1.5001..3] run function oa:tayayuyu/tnt_hit {amount:5}
execute as @a[tag=br.alive,tag=!br.pvp_grace,distance=3.0001..4.5] run function oa:tayayuyu/tnt_hit {amount:3}
tag @a remove oa.g_source
kill @s
