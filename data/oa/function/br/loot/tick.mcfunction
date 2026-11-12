execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=br.ore] at @s run function oa:br/mining/node
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=br.ore] at @s run function oa:br/mining/node
execute unless score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=br.ore,scores={br.regen=1..}] at @s run function oa:br/mining/reset_if_spent
execute unless score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=br.ore,scores={br.regen=1..}] at @s run function oa:br/mining/reset_if_spent
execute unless score #state br.state matches 1 run return 0
execute if score #perf oa.tmp matches 0 run function oa:perf/chests
execute if score #perf oa.tmp matches 10 run function oa:perf/chests
execute if score #time br.time matches 1200 run function oa:br/loot/ground_event
execute if score #time br.time matches 2400 run function oa:br/loot/ground_event
execute if score #time br.time matches 3600 run function oa:br/loot/ground_event
execute if score #time br.time matches 4800 run function oa:br/loot/ground_event
execute if score #time br.time matches 7200 run function oa:br/loot/refill_notice
execute if score #time br.time matches 6000 run function oa:br/loot/ground_event
execute if score #time br.time matches 7200 run function oa:br/loot/ground_event
execute if score #time br.time matches 8400 run function oa:br/loot/ground_event
execute if score #time br.time matches 9600 run function oa:br/loot/ground_event
execute if score #time br.time matches 10800 run function oa:br/loot/ground_event
execute if score #time br.time matches 2400 run function oa:br/supply/drop
execute if score #time br.time matches 2820 run function oa:br/supply/reveal
execute if score #time br.time matches 4800 run function oa:br/supply/drop
execute if score #time br.time matches 5220 run function oa:br/supply/reveal
execute if score #time br.time matches 7200 run function oa:br/supply/drop
execute if score #time br.time matches 7620 run function oa:br/supply/reveal
execute if score #time br.time matches 9600 run function oa:br/supply/drop
execute if score #time br.time matches 10020 run function oa:br/supply/reveal
execute if score #time br.time matches 1200 run function oa:br/grace/end
execute if score #time br.time matches 1200 run tag @a[tag=br.playing] remove br.pvp_grace
execute if score #time br.time matches 1200 run tellraw @a[tag=br.playing] {text:"保護時間終了！PvPが有効になりました",color:"red"}
execute as @a[tag=br.alive] at @s run function oa:br/mining/player
execute if score #falling br.tmp matches 1 if score #map oa.mapid matches 0 in oa:br as @e[type=minecraft:block_display,tag=br.supply_crate] at @s run function oa:br/supply/fall
execute if score #falling br.tmp matches 1 if score #map oa.mapid matches 1 in oa:br_nether as @e[type=minecraft:block_display,tag=br.supply_crate] at @s run function oa:br/supply/fall
