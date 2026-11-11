execute unless data storage oa:lobby_events {skins:1b} unless data storage oa:lobby_events {remove_stats:1b} run return 0
execute unless data storage oa:lobby origin{ready:1b} run return 0
execute if data storage oa:lobby_events {working:1b} run return 0
execute if data storage oa:lobby_job {working:1b} run return run tellraw @a[tag=br.admin] {text:"ロビー再建中のため更新を保留しました。完了後に手動更新してください。",color:"yellow"}
data modify storage oa:lobby_events working set value 1b
data modify storage oa:lobby_events origin set from storage oa:lobby origin
scoreboard players set #event_wait oa.tmp 0
function oa:lobby/events/preload_dispatch with storage oa:lobby_events origin
