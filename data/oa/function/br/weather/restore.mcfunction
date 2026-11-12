scoreboard players reset #weather_target br.tmp
execute unless data storage oa:weather backup run return 0
execute if data storage oa:weather backup{kind:0} if score #map oa.mapid matches 0 in oa:br run weather clear 180s
execute if data storage oa:weather backup{kind:0} if score #map oa.mapid matches 1 in oa:br_nether run weather clear 180s
execute if data storage oa:weather backup{kind:1} if score #map oa.mapid matches 0 in oa:br run weather rain 180s
execute if data storage oa:weather backup{kind:1} if score #map oa.mapid matches 1 in oa:br_nether run weather rain 180s
execute if data storage oa:weather backup{kind:2} if score #map oa.mapid matches 0 in oa:br run weather thunder 180s
execute if data storage oa:weather backup{kind:2} if score #map oa.mapid matches 1 in oa:br_nether run weather thunder 180s
data remove storage oa:weather backup
