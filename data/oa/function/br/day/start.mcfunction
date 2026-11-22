
execute if score #map oa.mapid matches 0 in oa:br store result storage oa:day backup.time int 1 run time query time
execute if score #map oa.mapid matches 1 in oa:br_nether store result storage oa:day backup.time int 1 run time query time
execute if score #map oa.mapid matches 2 in oa:br_cave store result storage oa:day backup.time int 1 run time query time
execute if score #map oa.mapid matches 3 in oa:br_sky store result storage oa:day backup.time int 1 run time query time
execute if score #map oa.mapid matches 4 in oa:br_end store result storage oa:day backup.time int 1 run time query time
execute if score #map oa.mapid matches 0 in oa:br run time pause
execute if score #map oa.mapid matches 1 in oa:br_nether run time pause
execute if score #map oa.mapid matches 2 in oa:br_cave run time pause
execute if score #map oa.mapid matches 3 in oa:br_sky run time pause
execute if score #map oa.mapid matches 4 in oa:br_end run time pause
execute if score #map oa.mapid matches 0 in oa:br run time set 6000t
execute if score #map oa.mapid matches 1 in oa:br_nether run time set 6000t
execute if score #map oa.mapid matches 2 in oa:br_cave run time set 6000t
execute if score #map oa.mapid matches 3 in oa:br_sky run time set 6000t
execute if score #map oa.mapid matches 4 in oa:br_end run time set 6000t
