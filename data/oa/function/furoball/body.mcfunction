execute if entity @s[tag=oa.debug_mob] run scoreboard players set @s oa.team 0
data modify storage oa:perf pos set from entity @s Pos
execute store result score #f_body_x oa.tmp run data get storage oa:perf pos[0] 10000
execute store result score #f_body_y oa.tmp run data get storage oa:perf pos[1] 10000
execute store result score #f_body_z oa.tmp run data get storage oa:perf pos[2] 10000
scoreboard players operation #f_body_x oa.tmp -= #f_probe_x oa.tmp
scoreboard players operation #f_body_y oa.tmp -= #f_probe_y oa.tmp
scoreboard players operation #f_body_z oa.tmp -= #f_probe_z oa.tmp
execute store result score #f_body_scale oa.tmp run attribute @s minecraft:scale get 10000
scoreboard players set #f_three oa.tmp 3
scoreboard players set #f_ten oa.tmp 10
scoreboard players operation #f_body_width oa.tmp = #f_body_scale oa.tmp
scoreboard players operation #f_body_width oa.tmp *= #f_three oa.tmp
scoreboard players operation #f_body_width oa.tmp /= #f_ten oa.tmp
scoreboard players add #f_body_width oa.tmp 5000
scoreboard players set #f_body_min oa.tmp 0
scoreboard players operation #f_body_min oa.tmp -= #f_body_width oa.tmp
scoreboard players set #f_height_factor oa.tmp 18
execute if predicate oa:sneaking run scoreboard players set #f_height_factor oa.tmp 15
scoreboard players operation #f_height oa.tmp = #f_body_scale oa.tmp
scoreboard players operation #f_height oa.tmp *= #f_height_factor oa.tmp
scoreboard players operation #f_height oa.tmp /= #f_ten oa.tmp
scoreboard players add #f_height oa.tmp 5000
scoreboard players set #f_height_neg oa.tmp 0
scoreboard players operation #f_height_neg oa.tmp -= #f_height oa.tmp
execute if score #f_body_x oa.tmp > #f_body_width oa.tmp run return 0
execute if score #f_body_x oa.tmp < #f_body_min oa.tmp run return 0
execute if score #f_body_z oa.tmp > #f_body_width oa.tmp run return 0
execute if score #f_body_z oa.tmp < #f_body_min oa.tmp run return 0
execute if score #f_body_y oa.tmp > #f_height_neg oa.tmp if score #f_body_y oa.tmp matches ..5000 run scoreboard players set #f_hit oa.tmp 1
