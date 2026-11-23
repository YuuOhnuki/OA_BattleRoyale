scoreboard players add #map_revision oa.map2 1
scoreboard players set #image_sky oa.tmp 0
scoreboard players set #image_end oa.tmp 0
scoreboard players set #map_failed oa.map2 0
scoreboard players set #state oa.map2 1
scoreboard players set #tile oa.map2 0
scoreboard players set #chests oa.map2 0
scoreboard players set #ores oa.map2 0
data modify storage oa_map2:args tile set value 0
data modify storage oa_map2:job working set value 1b
data modify storage oa_map2:job name set value "会場"
function oa:map/internal/job/progress_name with storage oa:maps
scoreboard players set #prog_last oa.map2 -1
scoreboard players set #isle_done oa.map2 0
tellraw @a [{text:"[会場の生成] ",color:"gold"},{nbt:"name",storage:"oa_map2:job",interpret:true,color:"yellow"},{text:" を作り始めました。全100区画（10区画ごとに進み具合を出します）。完了まで試合は始められません",color:"gold"}]
# 1.9.230：天空島・エンドは、外周の島（スロット）の中身を抽選する（作成・再生成のときだけ）
execute if data storage oa_map2:args {dim:"oa:br_sky"} run function oa:maps/sky/roll
execute if data storage oa_map2:args {dim:"oa:br_end"} run function oa:maps/end/roll
function oa:map/internal/job/next
