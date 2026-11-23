execute if entity @s[tag=br.pvp_grace] run return 0
execute store result score #launch_roll oa.tmp run random value 1..5
# 1.9.239：通常命中の抽選は1/5（20%）。専用スキルの抽選・CTは変更しない。
execute unless score #launch_roll oa.tmp matches 1 run return 0
execute if entity @s[tag=oa.practice_dummy] run data merge entity @s {NoAI:0b,NoGravity:0b}
# 1.9.227：高さを約75%に（浮遊の強さ 12→10。3tick で外すのは同じ）
effect give @s minecraft:levitation 1 9 true
scoreboard players set @s oa.glift 3
particle minecraft:firework ~ ~0.2 ~ 0.4 0.1 0.4 0.1 24 normal @a[distance=..24]
playsound minecraft:entity.firework_rocket.launch player @a[distance=..24] ~ ~ ~ 1.2 1.4

tag @s add oa.gacha_lift

tag @s add oa.gacha_affected

# 1.9.227：落下ダメージを受ける（以前は着地まで落下ダメージ無効＝fall_damage_multiplier −1）。着地の判定（oa.taya_fall・fall_tick）は練習用ダミーのために残す
attribute @s minecraft:fall_damage_multiplier modifier remove oa:taya_fall
tag @s add oa.taya_fall
tag @s remove oa.taya_air
scoreboard players set @s oa.tfall 0
