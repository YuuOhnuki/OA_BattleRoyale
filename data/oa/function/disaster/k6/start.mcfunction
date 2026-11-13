scoreboard players set #dis_left br.tmp 30
execute unless score #map oa.mapid matches 1 run function oa:disaster/k6/start_fog
execute if score #map oa.mapid matches 1 run function oa:disaster/k6/start_ash
