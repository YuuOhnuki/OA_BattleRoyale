scoreboard players set #spawn_ok br.flag 1
scoreboard players set #spawn_needed br.tmp 0
execute if score #mode br.mode matches 0 as @a[tag=br.lobby] run scoreboard players add #spawn_needed br.tmp 1
execute if score #mode br.mode matches 1 if entity @a[tag=br.lobby,scores={br.pick=1}] run scoreboard players add #spawn_needed br.tmp 1
execute if score #mode br.mode matches 1 if entity @a[tag=br.lobby,scores={br.pick=2}] run scoreboard players add #spawn_needed br.tmp 1
execute if score #mode br.mode matches 1 if entity @a[tag=br.lobby,scores={br.pick=3}] run scoreboard players add #spawn_needed br.tmp 1
execute if score #mode br.mode matches 1 if entity @a[tag=br.lobby,scores={br.pick=4}] run scoreboard players add #spawn_needed br.tmp 1
execute if score #mode br.mode matches 1 if entity @a[tag=br.lobby,scores={br.pick=5}] run scoreboard players add #spawn_needed br.tmp 1
execute if score #mode br.mode matches 1 if entity @a[tag=br.lobby,scores={br.pick=6}] run scoreboard players add #spawn_needed br.tmp 1
execute if score #mode br.mode matches 1 if entity @a[tag=br.lobby,scores={br.pick=7}] run scoreboard players add #spawn_needed br.tmp 1
execute if score #mode br.mode matches 1 if entity @a[tag=br.lobby,scores={br.pick=8}] run scoreboard players add #spawn_needed br.tmp 1
execute if score #mode br.mode matches 1 if entity @a[tag=br.lobby,scores={br.pick=9}] run scoreboard players add #spawn_needed br.tmp 1
execute if score #mode br.mode matches 1 if entity @a[tag=br.lobby,scores={br.pick=10}] run scoreboard players add #spawn_needed br.tmp 1
execute unless data storage oa:spawn_points {dim:"oa:br"} run function oa:br/spawn_points/init_dimension
scoreboard players set #point_count br.tmp 0
execute store result score #point_count br.tmp run data get storage oa:spawn_points points
execute if score #point_count br.tmp < #spawn_needed br.tmp run return run scoreboard players set #spawn_ok br.flag 0
data modify storage oa:spawn_pool points set from storage oa:spawn_points points
data modify storage oa:spawn_plan teams set value {}
