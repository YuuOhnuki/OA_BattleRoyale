scoreboard players set #was br.clean 0
scoreboard players set #added br.clean 0
$execute if score #map oa.mapid matches 0 in oa:br store success score #was br.clean run forceload query $(x) $(z)
$execute if score #map oa.mapid matches 1 in oa:br_nether store success score #was br.clean run forceload query $(x) $(z)
$execute if score #was br.clean matches 0 if score #map oa.mapid matches 0 in oa:br store success score #added br.clean run forceload add $(x) $(z)
$execute if score #was br.clean matches 0 if score #map oa.mapid matches 1 in oa:br_nether store success score #added br.clean run forceload add $(x) $(z)
execute if score #added br.clean matches 1 run data modify storage oa:cleanup forced append from storage oa:cleanup pair
execute if score #was br.clean matches 0 if score #added br.clean matches 0 run scoreboard players set #abort br.clean 1
