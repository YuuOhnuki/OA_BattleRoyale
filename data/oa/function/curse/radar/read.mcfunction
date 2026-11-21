execute store result storage oa:radar x int 1 run data get entity @s Pos[0]
execute store result storage oa:radar y int 1 run data get entity @s Pos[1]
execute store result storage oa:radar z int 1 run data get entity @s Pos[2]
data modify storage oa:radar dim_name set value "別ワールド"
execute if dimension minecraft:overworld run data modify storage oa:radar dim_name set value "地上"
execute if dimension minecraft:the_nether run data modify storage oa:radar dim_name set value "ネザー"
execute if dimension minecraft:the_end run data modify storage oa:radar dim_name set value "エンド"
execute if dimension oa:br run data modify storage oa:radar dim_name set value "BR会場"
execute if dimension oa:br_nether run data modify storage oa:radar dim_name set value "BR会場"
execute if dimension oa:br_cave run data modify storage oa:radar dim_name set value "BR会場"
execute if dimension oa:practice run data modify storage oa:radar dim_name set value "練習場"
