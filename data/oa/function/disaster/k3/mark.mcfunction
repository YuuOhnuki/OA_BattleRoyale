scoreboard players remove @s br.dtmr 1
execute if score @s br.dtmr matches 1..3 run particle minecraft:dust{color:[1.0,0.15,0.1],scale:2.0} ~ ~0.2 ~ 1.6 0.1 1.6 0 30 force @a[distance=..64]
execute if score @s br.dtmr matches 1 unless score #map oa.mapid matches 2 run particle minecraft:flame ~ ~3 ~ 0.3 3 0.3 0.01 30 force @a[distance=..64]
execute if score @s br.dtmr matches 1..2 if score #map oa.mapid matches 2 run particle minecraft:falling_dust{block_state:"minecraft:stone"} ~ ~4 ~ 1.2 0.5 1.2 0 25 force @a[distance=..64]
execute if score @s br.dtmr matches 1 run playsound minecraft:entity.firework_rocket.launch hostile @a[distance=..40] ~ ~ ~ 1 0.6
execute if score @s br.dtmr matches ..0 run function oa:disaster/k3/impact
