scoreboard players remove @s oa.bleed 1
scoreboard players operation #blood_mod oa.tmp = @s oa.bleed
scoreboard players set #blood20 oa.tmp 20
scoreboard players operation #blood_mod oa.tmp %= #blood20 oa.tmp
execute if score @s oa.bleed matches 0..20 if score #blood_mod oa.tmp matches 0 run function oa:hotchikisu/bleed_tick
