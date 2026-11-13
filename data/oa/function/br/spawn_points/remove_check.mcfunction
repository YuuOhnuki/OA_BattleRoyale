$execute positioned $(x) $(y) $(z) unless entity @s[distance=..2] run return 0
$data remove storage oa:spawn_points points[$(index)]
scoreboard players set #point_removed br.flag 1
tellraw @s [{text:"【",color:"gray"},{nbt:"label",storage:"oa:spawn_points",color:"aqua"},{text:"】",color:"gray"},{text:"近くの登録地点を1個削除しました",color:"green"}]
