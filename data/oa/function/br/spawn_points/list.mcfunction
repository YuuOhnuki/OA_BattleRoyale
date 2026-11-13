execute unless entity @s[tag=br.admin] run return 0
function oa:br/spawn_points/label
execute unless data storage oa:spawn_points dim run function oa:br/spawn_points/init_dimension
execute unless data storage oa:spawn_points points[0] run return run tellraw @s [{text:"【",color:"gray"},{nbt:"label",storage:"oa:spawn_points",color:"aqua"},{text:"】",color:"gray"},{text:"開始地点は未登録です。管理ブックの「開始地点を追加」で、会場の中に立って登録してください",color:"yellow"}]
execute store result score #point_count br.tmp run data get storage oa:spawn_points points
tellraw @s [{text:"【",color:"gray"},{nbt:"label",storage:"oa:spawn_points",color:"aqua"},{text:"】",color:"gray"},{text:"登録済みの開始地点 ",color:"gold"},{score:{name:"#point_count",objective:"br.tmp"},color:"white"},{text:" 個（x / y / z）： ",color:"gold"},{nbt:"points",storage:"oa:spawn_points",interpret:false}]
