execute if data storage oa:lobby_events {working:1b} run return run tellraw @s {text:"ロビー表示更新の完了後に実行してください。",color:"yellow"}
execute unless entity @s[type=minecraft:player] run return 0
execute unless dimension minecraft:overworld run return run tellraw @s {text:"ロビーはオーバーワールドで作成してください",color:"red"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合・清掃の停止中に作成してください",color:"red"}
execute store result score #ly oa.tmp run data get entity @s Pos[1]
execute unless score #ly oa.tmp matches -61..275 run return run tellraw @s {text:"ロビー作成Yは-61〜275にしてください",color:"red"}
execute if data storage oa:lobby_job {working:1b} run return run tellraw @s {text:"ロビーの削除・再建を処理中です。",color:"yellow"}
execute if data storage oa_map2:job {working:1b} run return run tellraw @s {text:"マップ処理完了後にロビーを作成してください。",color:"yellow"}
data modify storage oa:lobby_job mode set value "create"
execute at @s align xyz summon minecraft:marker run function oa:lobby/capture_new
tag @a remove oa.lobby_builder
tag @s add oa.lobby_builder
function oa:lobby/job_begin
