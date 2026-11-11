scoreboard players set #ex_projectile oa.tmp 0
execute on origin if entity @s[tag=oa.gacha_exposed] run scoreboard players set #ex_projectile oa.tmp 1
execute if score #ex_projectile oa.tmp matches 1 if entity @s[type=minecraft:trident] run return run data merge entity @s {DealtDamage:1b,Motion:[0.0d,-0.1d,0.0d]}
execute if score #ex_projectile oa.tmp matches 1 run kill @s
