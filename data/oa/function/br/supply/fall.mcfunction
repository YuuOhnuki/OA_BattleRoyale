tp @s ~ ~-0.5 ~
particle minecraft:end_rod ~ ~0.8 ~ 0.4 0.4 0.4 0.02 3 force @a[tag=br.playing,distance=..200]
particle minecraft:campfire_signal_smoke ~ ~1.5 ~ 0.1 0.1 0.1 0.01 1 force @a[tag=br.playing,distance=..200]
scoreboard players add @s[tag=br.supply_main] br.sup 1
execute if entity @s[tag=br.supply_main,scores={br.sup=180..}] run function oa:br/supply/land
