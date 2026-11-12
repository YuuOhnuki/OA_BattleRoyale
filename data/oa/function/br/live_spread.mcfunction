scoreboard players set #spawn_live br.flag 0
$execute if score #mode br.mode matches 0 if score #map oa.mapid matches 0 in oa:br store success score #spawn_live br.flag run spreadplayers $(x) $(z) 24 130 false @a[tag=br.playing,tag=br.alive]
$execute if score #mode br.mode matches 0 if score #map oa.mapid matches 1 in oa:br_nether store success score #spawn_live br.flag run spreadplayers $(x) $(z) 24 130 false @a[tag=br.playing,tag=br.alive]
$execute if score #mode br.mode matches 1 if score #map oa.mapid matches 0 in oa:br store success score #spawn_live br.flag run spreadplayers $(x) $(z) 24 130 true @a[tag=br.playing,tag=br.alive]
$execute if score #mode br.mode matches 1 if score #map oa.mapid matches 1 in oa:br_nether store success score #spawn_live br.flag run spreadplayers $(x) $(z) 24 130 true @a[tag=br.playing,tag=br.alive]
execute if score #spawn_live br.flag matches 1 run scoreboard players set @a[tag=br.playing] br.tp_ok 1
