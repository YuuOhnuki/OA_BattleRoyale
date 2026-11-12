execute unless data storage oa:br center.dim run return 0
execute unless data storage oa:br center run return 0
execute unless data storage oa:br border_restore.damage run data modify storage oa:br border_restore.damage set value 0.2d
data modify storage oa:br border_restore.x set from storage oa:br center.x
data modify storage oa:br border_restore.z set from storage oa:br center.z
execute if score #map oa.mapid matches 0 in oa:br run function oa:br/border/center with storage oa:br center
execute if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/border/center with storage oa:br center
