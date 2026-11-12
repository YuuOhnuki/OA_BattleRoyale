execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,type=minecraft:marker,tag=br.supply_fx]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,type=minecraft:marker,tag=br.supply_fx]
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,type=minecraft:marker,tag=br.supply_new]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,type=minecraft:marker,tag=br.supply_new]
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,type=minecraft:marker,tag=br.supply_wait]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,type=minecraft:marker,tag=br.supply_wait]
execute if score #map oa.mapid matches 0 in oa:br run kill @e[type=minecraft:block_display,tag=br.supply_crate]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[type=minecraft:block_display,tag=br.supply_crate]
scoreboard players set #falling br.tmp 0
