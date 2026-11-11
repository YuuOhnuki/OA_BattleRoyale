particle minecraft:explosion_emitter ~0.5 ~0.5 ~0.5 0 0 0 0 1 normal @a[distance=..48]
playsound minecraft:entity.generic.explode player @a[distance=..48] ~ ~ ~ 1.2 1
scoreboard players operation #g_owner oa.tmp = @s oa.gby
execute store result storage oa:gacha event int 1 run scoreboard players get @s oa.gevent
data modify storage oa:gacha ledger set value "hits"
execute if entity @s[tag=oa.db_projectile] run data modify storage oa:gacha ledger set value "debug_hits"
execute if entity @s[tag=oa.db_projectile] unless data storage oa:gacha_hits debug_hits run data modify storage oa:gacha_hits debug_hits set value {}
tag @a remove oa.g_source
execute as @a if score @s oa.id = #g_owner oa.tmp run tag @s add oa.g_source
execute unless entity @s[tag=oa.db_projectile] positioned ~0.5 ~0.5 ~0.5 as @a[tag=br.alive,tag=!br.pvp_grace,distance=..4] at @s run function oa:tayayuyu/bomb_prepare
execute if entity @s[tag=oa.db_projectile] positioned ~0.5 ~0.5 ~0.5 as @e[tag=oa.debug_mob,distance=..4] at @s run function oa:tayayuyu/bomb_prepare
execute if entity @s[tag=oa.db_projectile] positioned ~0.5 ~0.5 ~0.5 as @a[tag=oa.debug,distance=..4] at @s run function oa:tayayuyu/bomb_prepare
tag @a remove oa.g_source
execute if entity @s[tag=oa.db_projectile] run function oa:tayayuyu/debug_bomb_end with storage oa:gacha
kill @s
