data modify storage oa:maps current set from storage oa:maps new.key
execute store result score #map oa.mapid run data get storage oa:maps new.id
data remove storage oa:br center
data remove storage oa:br border_restore
data remove storage oa:spawn_points points
data remove storage oa:spawn_points dim
data remove storage oa_map2:args
data modify storage oa_map2:args set value {tile:0}
data modify storage oa_map2:args merge from storage oa:maps new
data remove storage oa_map2:args center_y
scoreboard players set #state oa.map2 0
data modify storage oa:maps ctx.key set from storage oa:maps new.key
function oa:map/internal/load_saved with storage oa:maps ctx
function oa:br/border/auto
tellraw @a[tag=br.admin] [{text:"試合用マップを切り替えました：",color:"green"},{nbt:"new.name",storage:"oa:maps"},{text:"（生成済みでなければ /function oa:map/create）",color:"gray"}]
