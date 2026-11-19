particle minecraft:explosion_emitter ~ ~1 ~ 0 0 0 0 1 force @a[distance=..64]
particle minecraft:firework ~ ~1 ~ 0.6 1 0.6 0.4 80 force @a[distance=..64]
particle minecraft:flash{color:[1.0,0.85,0.2,1.0]} ~ ~1 ~ 0 0 0 0 1 force @a[distance=..64]
particle minecraft:soul_fire_flame ~ ~1 ~ 0.4 1 0.4 0.15 60 force @a[distance=..64]
# 保護（br.pvp_grace）・キリングのお面の無効化（oa.curse_guard）を外してから、防具・耐性・トーテムを無視するダメージ（oa:gacha_jackpot）
tag @s remove br.pvp_grace
tag @s remove br.spawn_protection
tag @s remove oa.curse_guard
effect clear @s minecraft:resistance
effect clear @s minecraft:absorption
execute if entity @a[tag=oa.g_jackpot_self] run return run damage @s 10000 oa:gacha_jackpot by @a[tag=oa.g_jackpot_self,limit=1]
damage @s 10000 oa:gacha_jackpot
