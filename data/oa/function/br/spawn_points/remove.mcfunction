execute unless entity @s[tag=br.admin] run return 0
execute if score #state br.state matches 1.. run return run tellraw @s {text:"試合中は開始地点を編集できません",color:"red"}
execute unless dimension oa:br run return 0
data modify storage oa:spawn_points scan set from storage oa:spawn_points points
scoreboard players set #point_index br.tmp 0
scoreboard players set #point_removed br.flag 0
execute if data storage oa:spawn_points scan[0] run function oa:br/spawn_points/remove_scan
execute unless score #point_removed br.flag matches 1 run tellraw @s {text:"2m以内に登録地点がありません",color:"yellow"}
