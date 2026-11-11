execute store result storage oa:world_backup difficulty int 1 run difficulty
execute store result storage oa:world_backup spawn_monsters int 1 run gamerule minecraft:spawn_monsters
execute store result storage oa:world_backup spawn_patrols int 1 run gamerule minecraft:spawn_patrols
execute store result storage oa:world_backup spawn_phantoms int 1 run gamerule minecraft:spawn_phantoms
execute store result storage oa:world_backup spawn_wardens int 1 run gamerule minecraft:spawn_wardens
execute store result storage oa:world_backup raids int 1 run gamerule minecraft:raids
execute store result storage oa:world_backup spawner_blocks_work int 1 run gamerule minecraft:spawner_blocks_work
data modify storage oa:world_backup saved set value 1b
