# 旧削除は島の上部を消していないため、更新後の継続時に一度だけ全区画をやり直す。
schedule clear oa:map/internal/delete/wait
schedule clear oa:map/internal/delete/dispatch
execute if data storage oa_map2:job {holding:1b} run function oa:map/internal/job/dispatch_release with storage oa_map2:args
data modify storage oa_map2:job holding set value 0b
data modify storage oa_map2:job delete_version set value 240
data modify storage oa_map2:args tile set value 0
scoreboard players set #tile oa.map2 0
scoreboard players set #delete_wait oa.map2 0
tellraw @a[tag=br.admin] {text:"旧版から継続したマップ削除を区画0から再開します。",color:"yellow"}
