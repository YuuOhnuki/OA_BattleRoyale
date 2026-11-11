execute unless data storage oa:world_backup {saved:1b} run function oa:br/world/save
execute unless data storage oa:world_backup spawn_mobs store result storage oa:world_backup spawn_mobs int 1 run gamerule minecraft:spawn_mobs
execute unless data storage oa:world_backup spawn_wandering_traders store result storage oa:world_backup spawn_wandering_traders int 1 run gamerule minecraft:spawn_wandering_traders
difficulty normal
gamerule minecraft:spawn_wandering_traders false
gamerule minecraft:spawn_mobs false
execute if data storage oa:br center run function oa:br/world/clear_mobs with storage oa:br center
gamerule minecraft:spawn_monsters false
gamerule minecraft:spawn_patrols false
gamerule minecraft:spawn_phantoms false
gamerule minecraft:spawn_wardens false
gamerule minecraft:raids false
gamerule minecraft:spawner_blocks_work false
tellraw @a[tag=br.admin] {text:"[OA] 難易度ノーマル。全モブの自然スポーン・巡回・ファントム・ウォーデン・襲撃・スポナーを停止しました。",color:"green"}
