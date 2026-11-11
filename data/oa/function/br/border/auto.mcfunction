execute unless data storage oa:br center{dim:"oa:br"} run return 0
execute unless data storage oa:br center run return 0
execute unless data storage oa:br border_restore.damage run data modify storage oa:br border_restore.damage set value 0.2d
data modify storage oa:br border_restore.x set from storage oa:br center.x
data modify storage oa:br border_restore.z set from storage oa:br center.z
execute in oa:br run function oa:br/border/center with storage oa:br center
