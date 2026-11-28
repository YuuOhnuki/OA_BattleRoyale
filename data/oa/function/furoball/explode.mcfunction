particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1 normal @a[distance=..48]
particle minecraft:flame ~ ~ ~ 0.8 0.6 0.8 0.15 45 normal @a[distance=..48]
playsound minecraft:entity.generic.explode player @a[distance=..48] ~ ~ ~ 1.5 0.85
tag @a remove oa.f_source
execute as @a if score @s oa.id = #f_owner oa.tmp run tag @s add oa.f_source
execute unless entity @s[tag=oa.db_projectile] as @a[tag=br.alive,tag=!br.pvp_grace,gamemode=!spectator,distance=..9] at @s run function oa:furoball/blast
# 1.9.271：モブ（ウォーデン・試合のモブ・練習の標的）と、練習場の模擬戦の相手にも爆風
execute unless entity @s[tag=oa.db_projectile] as @e[type=#oa:arena_mobs,distance=..9] at @s run function oa:furoball/blast
execute unless entity @s[tag=oa.db_projectile] if entity @a[tag=oa.f_source,tag=oa.spar] as @a[tag=oa.spar,tag=!br.alive,gamemode=!spectator,distance=..9] at @s run function oa:furoball/blast
execute if entity @s[tag=oa.db_projectile] run function oa:debug/furo_targets
execute if entity @s[tag=oa.db_projectile] as @e[tag=oa.db_f_target,distance=..9] at @s run function oa:furoball/blast
tag @e[tag=oa.db_f_target] remove oa.db_f_target
tag @a remove oa.f_source
function oa:furoball/native_burst
kill @s
