tellraw @a[tag=br.playing] {text:"たやゆゆ変態ガチャ：大ハズレ：大爆発",color:"dark_red",bold:true}
tellraw @a[tag=br.playing] {"text": " → 使用者がその場で大爆発（半径10mの人にも10HP）", "color": "gray"}
# 1.9.192: 使用者は倒れる。半径10mの生存者に10HP（oa:gacha_blast：防具を無視。使用者のダメージ）
particle minecraft:explosion_emitter ~ ~1 ~ 2 1 2 0 8 force @a[distance=..96]
particle minecraft:flame ~ ~1 ~ 3 2 3 0.3 250 force @a[distance=..96]
particle minecraft:lava ~ ~1 ~ 2 1 2 0 60 force @a[distance=..96]
particle minecraft:large_smoke ~ ~1 ~ 3 2 3 0.1 120 force @a[distance=..96]
particle minecraft:flash{color:[1.0,0.2,0.1,1.0]} ~ ~1 ~ 0 0 0 0 1 force @a[distance=..96]
playsound minecraft:entity.generic.explode player @a[distance=..96] ~ ~ ~ 4 0.5
playsound minecraft:entity.wither.death player @a[distance=..96] ~ ~ ~ 1.5 1.2
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.dragon_fireball.explode master @s ~ ~ ~ 1 0.6
tag @a remove oa.g_source
tag @s add oa.g_source
execute as @a[tag=br.alive,tag=!oa.g_source,tag=!br.pvp_grace,distance=..10] run function oa:tayayuyu/blast_hit
tag @a remove oa.g_source
tag @s remove br.pvp_grace
tag @s remove oa.curse_guard
effect clear @s minecraft:resistance
effect clear @s minecraft:absorption
damage @s 10000 oa:gacha_jackpot
