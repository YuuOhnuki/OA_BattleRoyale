execute if score #active tdm.sys matches 1 run return 0
# 1.9.182: 軽量化。鉱石の点（約100〜180個）を4組（br.ostg 0〜3）に分け、5tickごとに1組ずつ調べる（どの点も1秒に1回）。
# 以前は5tickごとに全部を調べていて、その tick だけ重かった。組の番号がない点は、ここで振る
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 run scoreboard players add #ostg br.tmp 1
execute if score #ostg br.tmp matches 4.. run scoreboard players set #ostg br.tmp 0
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=br.ore] unless score @s br.ostg matches 0..3 run function oa:br/mining/assign_stagger
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=br.ore] unless score @s br.ostg matches 0..3 run function oa:br/mining/assign_stagger
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 2 in oa:br_cave as @e[distance=0..,type=minecraft:marker,tag=br.ore] unless score @s br.ostg matches 0..3 run function oa:br/mining/assign_stagger
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 3 in oa:br_sky as @e[distance=0..,type=minecraft:marker,tag=br.ore] unless score @s br.ostg matches 0..3 run function oa:br/mining/assign_stagger
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 4 in oa:br_end as @e[distance=0..,type=minecraft:marker,tag=br.ore] unless score @s br.ostg matches 0..3 run function oa:br/mining/assign_stagger
# 1.9.182: 生存者から8ブロック以内の鉱石の点は、これまでどおり5tickごとに調べる（掘ったご褒美は7ブロック以内の人に渡すので、1秒待つと受け取れないことがある。2回調べても、壊れたあとの点はすぐ終わる）
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 0 as @a[tag=br.alive] at @s if dimension oa:br as @e[type=minecraft:marker,tag=br.ore,distance=..8] at @s run function oa:br/mining/node
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 1 as @a[tag=br.alive] at @s if dimension oa:br_nether as @e[type=minecraft:marker,tag=br.ore,distance=..8] at @s run function oa:br/mining/node
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 2 as @a[tag=br.alive] at @s if dimension oa:br_cave as @e[type=minecraft:marker,tag=br.ore,distance=..8] at @s run function oa:br/mining/node
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 3 as @a[tag=br.alive] at @s if dimension oa:br_sky as @e[type=minecraft:marker,tag=br.ore,distance=..8] at @s run function oa:br/mining/node
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 4 as @a[tag=br.alive] at @s if dimension oa:br_end as @e[type=minecraft:marker,tag=br.ore,distance=..8] at @s run function oa:br/mining/node
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=br.ore] if score @s br.ostg = #ostg br.tmp at @s run function oa:br/mining/node
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=br.ore] if score @s br.ostg = #ostg br.tmp at @s run function oa:br/mining/node
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 2 in oa:br_cave as @e[distance=0..,type=minecraft:marker,tag=br.ore] if score @s br.ostg = #ostg br.tmp at @s run function oa:br/mining/node
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 3 in oa:br_sky as @e[distance=0..,type=minecraft:marker,tag=br.ore] if score @s br.ostg = #ostg br.tmp at @s run function oa:br/mining/node
execute if score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 4 in oa:br_end as @e[distance=0..,type=minecraft:marker,tag=br.ore] if score @s br.ostg = #ostg br.tmp at @s run function oa:br/mining/node
execute unless score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=br.ore,scores={br.regen=1..}] at @s run function oa:br/mining/reset_if_spent
execute unless score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=br.ore,scores={br.regen=1..}] at @s run function oa:br/mining/reset_if_spent
execute unless score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 2 in oa:br_cave as @e[distance=0..,type=minecraft:marker,tag=br.ore,scores={br.regen=1..}] at @s run function oa:br/mining/reset_if_spent
execute unless score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 3 in oa:br_sky as @e[distance=0..,type=minecraft:marker,tag=br.ore,scores={br.regen=1..}] at @s run function oa:br/mining/reset_if_spent
execute unless score #state br.state matches 1 if score #clock oa.beat matches 0 if score #map oa.mapid matches 4 in oa:br_end as @e[distance=0..,type=minecraft:marker,tag=br.ore,scores={br.regen=1..}] at @s run function oa:br/mining/reset_if_spent
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
execute if score #time br.time matches 3900 run function oa:br/supply/drop
execute if score #time br.time matches 4320 run function oa:br/supply/reveal
execute if score #time br.time matches 6300 run function oa:br/supply/drop
execute if score #time br.time matches 6720 run function oa:br/supply/reveal
execute if score #time br.time matches 8700 run function oa:br/supply/drop
execute if score #time br.time matches 9120 run function oa:br/supply/reveal
execute if score #time br.time matches 1200 run function oa:br/grace/end
execute if score #time br.time matches 1200 run tag @a[tag=br.playing] remove br.pvp_grace
execute if score #time br.time matches 1200 run tellraw @a[tag=br.playing] {text:"⚔ 保護期間終了",color:"red"}
execute if score #falling br.tmp matches 1 if score #map oa.mapid matches 0 in oa:br as @e[type=minecraft:block_display,tag=br.supply_crate] at @s run function oa:br/supply/fall
execute if score #falling br.tmp matches 1 if score #map oa.mapid matches 1 in oa:br_nether as @e[type=minecraft:block_display,tag=br.supply_crate] at @s run function oa:br/supply/fall
execute if score #falling br.tmp matches 1 if score #map oa.mapid matches 2 in oa:br_cave as @e[type=minecraft:block_display,tag=br.supply_crate] at @s run function oa:br/supply/fall
execute if score #falling br.tmp matches 1 if score #map oa.mapid matches 3 in oa:br_sky as @e[type=minecraft:block_display,tag=br.supply_crate] at @s run function oa:br/supply/fall
execute if score #falling br.tmp matches 1 if score #map oa.mapid matches 4 in oa:br_end as @e[type=minecraft:block_display,tag=br.supply_crate] at @s run function oa:br/supply/fall
