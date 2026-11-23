schedule clear oa:map/internal/delete/wait
schedule clear oa:map/internal/delete/dispatch
execute if data storage oa_map2:job {holding:1b} run function oa:map/internal/job/dispatch_release with storage oa_map2:args
data modify storage oa_map2:job working set value 0b
data modify storage oa_map2:job deleting set value 0b
scoreboard players set #state oa.map2 2
scoreboard players set #map_failed oa.map2 1
data modify storage oa:maps ctx.key set from storage oa:maps current
function oa:map/internal/save_cur with storage oa:maps ctx
tellraw @a[tag=br.admin] [{text:"マップ削除を停止しました：チャンク読込が30秒以内に完了しませんでした。区画 ",color:"red"},{score:{name:"#tile",objective:"oa.map2"}},{text:"。ログを確認し、削除を再実行してください。",color:"yellow"}]
