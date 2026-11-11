execute unless entity @s[type=minecraft:player] run return 0
execute unless dimension oa:br run return run tellraw @s {text:"中心はBR専用ディメンションで登録してください",color:"red"}
execute if score #state br.state matches 1.. run return 0
execute store result score #center_x br.tmp run data get entity @s Pos[0]
execute store result score #center_z br.tmp run data get entity @s Pos[2]
execute unless score #center_x br.tmp matches -2000000..2000000 run return run tellraw @s {text:"中心座標は±200万ブロック以内で登録してください",color:"red"}
execute unless score #center_z br.tmp matches -2000000..2000000 run return run tellraw @s {text:"中心座標は±200万ブロック以内で登録してください",color:"red"}
data modify storage oa:br center set value {dim:"oa:br"}
data modify storage oa:br center.x set from entity @s Pos[0]
data modify storage oa:br center.y set from entity @s Pos[1]
data modify storage oa:br center.z set from entity @s Pos[2]
data modify storage oa:br center.yaw set from entity @s Rotation[0]
data modify storage oa:br center.pitch set from entity @s Rotation[1]
execute store result score #cx br.x run data get entity @s Pos[0] 1000
execute store result score #cz br.z run data get entity @s Pos[2] 1000
tellraw @s {text:"現在地をBRマップの中心・観戦地点として登録しました",color:"green"}

function oa:br/border/auto
