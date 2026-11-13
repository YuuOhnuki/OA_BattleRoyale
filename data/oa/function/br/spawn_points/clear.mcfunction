execute unless entity @s[tag=br.admin] run return 0
execute if score #state br.state matches 1.. run return run tellraw @s {text:"試合中は開始地点を編集できません",color:"red"}
function oa:br/spawn_points/label
execute unless data storage oa:spawn_points dim run function oa:br/spawn_points/init_dimension
data modify storage oa:spawn_points points set value []
tellraw @s [{text:"【",color:"gray"},{nbt:"label",storage:"oa:spawn_points",color:"aqua"},{text:"】",color:"gray"},{text:"開始地点をすべて削除しました",color:"yellow"}]
