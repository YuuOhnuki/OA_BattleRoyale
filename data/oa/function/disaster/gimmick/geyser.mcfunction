scoreboard players remove @s br.dtmr 1
execute if score @s br.dtmr matches 4..13 unless score #map oa.mapid matches 1 run particle minecraft:cloud ~ ~0.1 ~ 0.15 0.05 0.15 0.005 2 normal @a[distance=..40]
execute if score @s br.dtmr matches 4..13 if score #map oa.mapid matches 1 run particle minecraft:smoke ~ ~0.1 ~ 0.15 0.05 0.15 0.005 3 normal @a[distance=..40]
execute if score @s br.dtmr matches 1..3 run function oa:disaster/gimmick/geyser_warn
execute if score @s br.dtmr matches ..0 run function oa:disaster/gimmick/geyser_erupt
