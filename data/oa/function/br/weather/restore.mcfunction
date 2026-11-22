scoreboard players reset #weather_target br.tmp
execute unless data storage oa:weather backup run return 0
execute if data storage oa:weather backup{kind:0} if score #map oa.mapid matches 0 in oa:br run weather clear 180s
execute if data storage oa:weather backup{kind:0} if score #map oa.mapid matches 1 in oa:br_nether run weather clear 180s
execute if data storage oa:weather backup{kind:0} if score #map oa.mapid matches 2 in oa:br_cave run weather clear 180s
execute if data storage oa:weather backup{kind:0} if score #map oa.mapid matches 3 in oa:br_sky run weather clear 180s
execute if data storage oa:weather backup{kind:0} if score #map oa.mapid matches 4 in oa:br_end run weather clear 180s
execute if data storage oa:weather backup{kind:1} if score #map oa.mapid matches 0 in oa:br run weather rain 180s
execute if data storage oa:weather backup{kind:1} if score #map oa.mapid matches 1 in oa:br_nether run weather rain 180s
execute if data storage oa:weather backup{kind:1} if score #map oa.mapid matches 2 in oa:br_cave run weather rain 180s
execute if data storage oa:weather backup{kind:1} if score #map oa.mapid matches 3 in oa:br_sky run weather rain 180s
execute if data storage oa:weather backup{kind:1} if score #map oa.mapid matches 4 in oa:br_end run weather rain 180s
execute if data storage oa:weather backup{kind:2} if score #map oa.mapid matches 0 in oa:br run weather thunder 180s
execute if data storage oa:weather backup{kind:2} if score #map oa.mapid matches 1 in oa:br_nether run weather thunder 180s
execute if data storage oa:weather backup{kind:2} if score #map oa.mapid matches 2 in oa:br_cave run weather thunder 180s
execute if data storage oa:weather backup{kind:2} if score #map oa.mapid matches 3 in oa:br_sky run weather thunder 180s
execute if data storage oa:weather backup{kind:2} if score #map oa.mapid matches 4 in oa:br_end run weather thunder 180s
data remove storage oa:weather backup
