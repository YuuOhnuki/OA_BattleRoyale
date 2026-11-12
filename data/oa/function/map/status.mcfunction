data modify storage oa:maps ctx.key set from storage oa:maps current
function oa:map/internal/status_name with storage oa:maps ctx
execute if score #state oa.map2 matches 0 run tellraw @s {"text": "マップ：未生成", "color": "gray"}
execute if score #state oa.map2 matches 1 run tellraw @s {"text": "マップ：処理中", "color": "yellow"}
execute if score #state oa.map2 matches 2 run tellraw @s {"text": "マップ：停止中", "color": "gold"}
execute if score #state oa.map2 matches 3 run tellraw @s {"text": "マップ：完成", "color": "green"}
tellraw @s [{text:"処理区画：",color:"aqua"},{score:{name:"#tile",objective:"oa.map2"}},{text:"/100 ／ 登録チェスト："},{score:{name:"#chests",objective:"oa.map2"}},{text:" ／ 鉱石："},{score:{name:"#ores",objective:"oa.map2"}}]
