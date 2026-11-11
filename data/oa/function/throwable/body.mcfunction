execute store result score #body_x oa.tmp run data get entity @s Pos[0] 10000
execute store result score #body_y oa.tmp run data get entity @s Pos[1] 10000
execute store result score #body_z oa.tmp run data get entity @s Pos[2] 10000
scoreboard players operation #body_x oa.tmp -= #probe_x oa.tmp
scoreboard players operation #body_y oa.tmp -= #probe_y oa.tmp
scoreboard players operation #body_z oa.tmp -= #probe_z oa.tmp
execute store result score #body_scale oa.tmp run attribute @s minecraft:scale get 10000
scoreboard players set #three oa.tmp 3
scoreboard players set #ten oa.tmp 10
scoreboard players operation #body_width oa.tmp = #body_scale oa.tmp
scoreboard players operation #body_width oa.tmp *= #three oa.tmp
scoreboard players operation #body_width oa.tmp /= #ten oa.tmp
scoreboard players add #body_width oa.tmp 1250
scoreboard players set #body_min oa.tmp 0
scoreboard players operation #body_min oa.tmp -= #body_width oa.tmp
scoreboard players set #height_factor oa.tmp 18
execute if predicate oa:sneaking run scoreboard players set #height_factor oa.tmp 15
scoreboard players operation #height oa.tmp = #body_scale oa.tmp
scoreboard players operation #height oa.tmp *= #height_factor oa.tmp
scoreboard players operation #height oa.tmp /= #ten oa.tmp
scoreboard players add #height oa.tmp 1250
scoreboard players set #height_neg oa.tmp 0
scoreboard players operation #height_neg oa.tmp -= #height oa.tmp
execute if score #body_x oa.tmp > #body_width oa.tmp run return 0
execute if score #body_x oa.tmp < #body_min oa.tmp run return 0
execute if score #body_z oa.tmp > #body_width oa.tmp run return 0
execute if score #body_z oa.tmp < #body_min oa.tmp run return 0
execute if score #body_y oa.tmp > #height_neg oa.tmp if score #body_y oa.tmp matches ..1250 at @s run function oa:throwable/hit
