execute unless data storage oa:lobby_job {mode:"delete"} run function oa:lobby/build_new with storage oa:lobby_job new
execute unless data storage oa:lobby_job {mode:"delete"} run tag @a[tag=oa.lobby_builder] add br.host
execute unless data storage oa:lobby_job {mode:"delete"} run tag @a[tag=oa.lobby_builder] add br.admin
tag @a remove oa.lobby_builder
execute if data storage oa:lobby_job {mode:"delete"} run function oa:lobby/delete_player_state
data modify storage oa:lobby_job working set value 0b
tellraw @a[tag=br.admin] {text:"ロビーの削除／再建処理が完了しました。",color:"green"}
