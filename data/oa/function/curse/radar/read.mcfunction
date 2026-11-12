execute store result storage oa:radar x int 1 run data get entity @s Pos[0]
execute store result storage oa:radar y int 1 run data get entity @s Pos[1]
execute store result storage oa:radar z int 1 run data get entity @s Pos[2]
data modify storage oa:radar dim set from entity @s Dimension
data modify storage oa:radar compare set from entity @s Dimension
execute store success score #r_other oa.tmp run data modify storage oa:radar compare set from storage oa:radar viewer_dim
data modify storage oa:radar dim_name set value "別ワールド"
execute if dimension minecraft:overworld run data modify storage oa:radar dim_name set value "地上"
execute if dimension minecraft:the_nether run data modify storage oa:radar dim_name set value "ネザー"
execute if dimension minecraft:the_end run data modify storage oa:radar dim_name set value "エンド"
execute store result score #rx oa.tmp run data get entity @s Pos[0]
execute store result score #rz oa.tmp run data get entity @s Pos[2]
scoreboard players operation #rx oa.tmp -= #vx oa.tmp
scoreboard players operation #rz oa.tmp -= #vz oa.tmp
data modify storage oa:radar east set value "東"
data modify storage oa:radar south set value "南"
execute if score #rx oa.tmp matches ..-1 run data modify storage oa:radar east set value "西"
execute if score #rz oa.tmp matches ..-1 run data modify storage oa:radar south set value "北"
scoreboard players set #minus oa.tmp -1
execute if score #rx oa.tmp matches ..-1 run scoreboard players operation #rx oa.tmp *= #minus oa.tmp
execute if score #rz oa.tmp matches ..-1 run scoreboard players operation #rz oa.tmp *= #minus oa.tmp
execute store result storage oa:radar rx int 1 run scoreboard players get #rx oa.tmp
execute store result storage oa:radar rz int 1 run scoreboard players get #rz oa.tmp
execute if dimension oa:br run data modify storage oa:radar dim_name set value "BR会場"
execute if dimension oa:br_nether run data modify storage oa:radar dim_name set value "BR会場"
execute if dimension oa:practice run data modify storage oa:radar dim_name set value "練習場"
