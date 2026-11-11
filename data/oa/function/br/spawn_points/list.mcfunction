execute unless entity @s[tag=br.admin] run return 0
execute unless data storage oa:spawn_points {dim:"oa:br"} run function oa:br/spawn_points/init_dimension
execute unless data storage oa:spawn_points points[0] run return run tellraw @s {text:"開始地点は未登録です。/function oa:br/spawn_points/add で現在地を登録してください",color:"yellow"}
tellraw @s [{text:"登録済みの開始地点（x / y / z）： ",color:"gold"},{nbt:"points",storage:"oa:spawn_points",interpret:false}]
