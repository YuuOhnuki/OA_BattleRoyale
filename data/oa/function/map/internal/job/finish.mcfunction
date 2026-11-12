execute if score #mode oa.map2 matches 0 run return run function oa:map/internal/job/start_water
scoreboard players set #state oa.map2 3
data modify storage oa_map2:job working set value 0b
function oa:map/internal/center with storage oa_map2:args
execute if data storage oa_map2:args {dim:"oa:br_nether"} run function oa:maps/nether/post
tellraw @a [{text:"[OA Map 305] 完了！登録成功 チェスト ",color:"green"},{score:{name:"#chests",objective:"oa.map2"}},{text:"個 / 鉱石 "},{score:{name:"#ores",objective:"oa.map2"}},{text:"個。BR中心も設定しました。"}]
execute as @a at @s run playsound minecraft:ui.toast.challenge_complete master @s ~ ~ ~ 0.6 1
execute if data storage oa_map2:args dim run tellraw @a[tag=br.admin] {text:"管理ブックの「BR中心へ移動」または /function oa:map/teleport で会場へ入り、開始地点を登録してください。",color:"aqua"}
