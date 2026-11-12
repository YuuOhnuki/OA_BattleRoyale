
execute if score #map oa.mapid matches 0 in oa:br store result storage oa:day backup.time int 1 run time query time
execute if score #map oa.mapid matches 1 in oa:br_nether store result storage oa:day backup.time int 1 run time query time
execute if score #map oa.mapid matches 0 in oa:br run time pause
execute if score #map oa.mapid matches 1 in oa:br_nether run time pause
execute if score #map oa.mapid matches 0 in oa:br run time set 6000t
execute if score #map oa.mapid matches 1 in oa:br_nether run time set 6000t
