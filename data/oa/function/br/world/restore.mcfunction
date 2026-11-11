execute unless data storage oa:world_backup {saved:1b} run return run tellraw @s {text:"保存済み設定がありません",color:"red"}
execute if data storage oa:world_backup {difficulty:0} run difficulty peaceful
execute if data storage oa:world_backup {difficulty:1} run difficulty easy
execute if data storage oa:world_backup {difficulty:2} run difficulty normal
execute if data storage oa:world_backup {difficulty:3} run difficulty hard
execute if data storage oa:world_backup {spawn_monsters:0} run gamerule minecraft:spawn_monsters false
execute if data storage oa:world_backup {spawn_monsters:1} run gamerule minecraft:spawn_monsters true
execute if data storage oa:world_backup {spawn_patrols:0} run gamerule minecraft:spawn_patrols false
execute if data storage oa:world_backup {spawn_patrols:1} run gamerule minecraft:spawn_patrols true
execute if data storage oa:world_backup {spawn_phantoms:0} run gamerule minecraft:spawn_phantoms false
execute if data storage oa:world_backup {spawn_phantoms:1} run gamerule minecraft:spawn_phantoms true
execute if data storage oa:world_backup {spawn_wardens:0} run gamerule minecraft:spawn_wardens false
execute if data storage oa:world_backup {spawn_wardens:1} run gamerule minecraft:spawn_wardens true
execute if data storage oa:world_backup {raids:0} run gamerule minecraft:raids false
execute if data storage oa:world_backup {raids:1} run gamerule minecraft:raids true
execute if data storage oa:world_backup {spawner_blocks_work:0} run gamerule minecraft:spawner_blocks_work false
execute if data storage oa:world_backup {spawner_blocks_work:1} run gamerule minecraft:spawner_blocks_work true
execute if data storage oa:world_backup {spawn_mobs:0} run gamerule minecraft:spawn_mobs false
execute if data storage oa:world_backup {spawn_mobs:1} run gamerule minecraft:spawn_mobs true
data remove storage oa:world_backup spawn_mobs
execute if data storage oa:world_backup {spawn_wandering_traders:0} run gamerule minecraft:spawn_wandering_traders false
execute if data storage oa:world_backup {spawn_wandering_traders:1} run gamerule minecraft:spawn_wandering_traders true
data remove storage oa:world_backup spawn_wandering_traders
data remove storage oa:world_backup saved
tellraw @a[tag=br.admin] {text:"[OA] 難易度・スポーン設定を適用前に戻しました",color:"yellow"}
