execute if data storage oa_map2:job {working:1b} run return run tellraw @s {text:"マップ生成・削除の処理を先に完了してください。",color:"yellow"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合停止中に実行してください。",color:"red"}
execute unless score #state oa.map2 matches 0 run return run tellraw @s {text:"選択中のマップは生成済みです。再生成する場合は管理ブックから削除してください。",color:"yellow"}
function oa:map/internal/defs
data modify storage oa:maps ctx set value {}
data modify storage oa:maps ctx.key set from storage oa:maps current
function oa:map/internal/args_from_def with storage oa:maps ctx
scoreboard players set #br_dim oa.map2 0
function oa:map/internal/probe_dim with storage oa_map2:args
execute if score #br_dim oa.map2 matches 0 run return run tellraw @s {text:"このマップ用のディメンションを読み込むため、サーバーを再起動してください。",color:"red"}
scoreboard players set #mode oa.map2 0
data modify storage oa_map2:job holding set value 0b
function oa:map/internal/job/begin
