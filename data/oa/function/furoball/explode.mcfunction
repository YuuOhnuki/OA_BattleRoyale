particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1 normal @a[distance=..48]
particle minecraft:flame ~ ~ ~ 0.8 0.6 0.8 0.15 45 normal @a[distance=..48]
playsound minecraft:entity.generic.explode player @a[distance=..48] ~ ~ ~ 1.5 0.85
tag @a remove oa.f_source
execute as @a if score @s oa.id = #f_owner oa.tmp run tag @s add oa.f_source
execute unless entity @s[tag=oa.db_projectile] as @a[tag=br.alive,tag=!br.pvp_grace,gamemode=!spectator,distance=..9] at @s run function oa:furoball/blast
execute if entity @s[tag=oa.db_projectile] run function oa:debug/furo_targets
execute if entity @s[tag=oa.db_projectile] as @e[tag=oa.db_f_target,distance=..9] at @s run function oa:furoball/blast
tag @e[tag=oa.db_f_target] remove oa.db_f_target
tag @a remove oa.f_source
function oa:furoball/native_burst
kill @s
