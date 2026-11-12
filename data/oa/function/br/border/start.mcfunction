execute if score #map oa.mapid matches 0 in oa:br store result storage oa:br border_restore.size int 1 run worldborder get
execute if score #map oa.mapid matches 1 in oa:br_nether store result storage oa:br border_restore.size int 1 run worldborder get
execute if score #map oa.mapid matches 0 in oa:br run function oa:br/border/center with storage oa:br center
execute if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/border/center with storage oa:br center
execute if score #map oa.mapid matches 0 in oa:br run worldborder set 300
execute if score #map oa.mapid matches 1 in oa:br_nether run worldborder set 300
execute if score #map oa.mapid matches 0 in oa:br run worldborder damage amount 0
execute if score #map oa.mapid matches 1 in oa:br_nether run worldborder damage amount 0
scoreboard players set #sec br.sec 0
function oa:br/zone/update
scoreboard players operation #alive br.live = #players br.tmp
