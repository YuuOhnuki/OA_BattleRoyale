execute unless entity @s[tag=br.admin] run return 0
execute if score #state br.state matches 1.. run return run tellraw @s {text:"試合中は開始地点を編集できません",color:"red"}
execute unless dimension oa:br unless dimension oa:br_nether run return run tellraw @s {text:"開始地点はBR専用ディメンションで登録してください",color:"red"}
execute unless data storage oa:spawn_points dim run function oa:br/spawn_points/init_dimension
execute unless data storage oa:spawn_points points run data modify storage oa:spawn_points points set value []
execute store result score #point_count br.tmp run data get storage oa:spawn_points points
execute if score #point_count br.tmp matches 64.. run return run tellraw @s {text:"開始地点は最大64個です",color:"red"}
execute at @s align xyz positioned ~0.5 ~ ~0.5 run function oa:br/spawn_points/add_here
