$execute if data storage oa:spawn_points points[{x:$(x)d,y:$(y)d,z:$(z)d}] run return run tellraw @s {text:"この地点は登録済みです",color:"yellow"}
data modify storage oa:spawn_points points append from storage oa:spawn_points new
tellraw @s {text:"現在地を開始地点に登録しました",color:"green"}
function oa:br/spawn_points/list
