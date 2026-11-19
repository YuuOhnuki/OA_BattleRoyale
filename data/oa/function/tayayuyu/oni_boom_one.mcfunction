tellraw @a[tag=br.playing] [{text:"💥 ドカーン！ ",color:"red",bold:true},{selector:"@s",color:"white"},{text:" が時限爆弾で爆発した",color:"red"}]
particle minecraft:explosion_emitter ~ ~1 ~ 1 1 1 0 4 force @a[distance=..96]
particle minecraft:flame ~ ~1 ~ 1.5 1.5 1.5 0.25 150 force @a[distance=..96]
particle minecraft:lava ~ ~1 ~ 1 1 1 0 40 force @a[distance=..96]
particle minecraft:firework ~ ~1 ~ 1 1.5 1 0.4 120 force @a[distance=..96]
particle minecraft:flash{color:[1.0,0.4,0.1,1.0]} ~ ~1 ~ 0 0 0 0 1 force @a[distance=..96]
playsound minecraft:entity.generic.explode player @a[distance=..96] ~ ~ ~ 3 0.6
playsound minecraft:entity.dragon_fireball.explode player @a[distance=..96] ~ ~ ~ 2 0.8
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.firework_rocket.large_blast master @s ~ ~ ~ 1 0.6
function oa:tayayuyu/oni_drop
tag @s remove br.pvp_grace
tag @s remove br.spawn_protection
tag @s remove oa.curse_guard
effect clear @s minecraft:resistance
effect clear @s minecraft:absorption
execute if entity @a[tag=oa.g_source] unless entity @s[tag=oa.g_source] run return run damage @s 10000 oa:gacha_jackpot by @a[tag=oa.g_source,limit=1]
damage @s 10000 oa:gacha_jackpot
