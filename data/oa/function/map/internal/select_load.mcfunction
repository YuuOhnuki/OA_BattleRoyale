data modify storage oa:maps current set from storage oa:maps new.key
execute store result score #map oa.mapid run data get storage oa:maps new.id
data remove storage oa:br center
data remove storage oa:br border_restore
data remove storage oa:spawn_points points
data remove storage oa:spawn_points dim
data modify storage oa_map2:args tile set value 0
data modify storage oa_map2:args dim set from storage oa:maps new.dim
data modify storage oa_map2:args x set from storage oa:maps new.x
data modify storage oa_map2:args y set from storage oa:maps new.y
data modify storage oa_map2:args z set from storage oa:maps new.z
data modify storage oa_map2:args tiles set from storage oa:maps new.tiles
data remove storage oa_map2:args center_y
scoreboard players set #state oa.map2 0
data modify storage oa:maps ctx.key set from storage oa:maps new.key
function oa:map/internal/load_saved with storage oa:maps ctx
function oa:br/border/auto
tellraw @a[tag=br.admin] [{text:"試合用マップを切り替えました：",color:"green"},{nbt:"new.name",storage:"oa:maps"},{text:"（生成済みでなければ /function oa:map/create）",color:"gray"}]
execute if data storage oa:lobby origin{ready:1b} run function oa:lobby/map_panel_update_at with storage oa:lobby origin
