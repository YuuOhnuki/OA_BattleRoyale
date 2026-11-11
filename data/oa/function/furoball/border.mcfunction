execute unless score #f_has_border oa.tmp matches 1 run return 0
scoreboard players set #f_neg oa.tmp -1
execute store result score #f_bx oa.tmp run data get entity @s Pos[0] 1000
execute store result score #f_bz oa.tmp run data get entity @s Pos[2] 1000
scoreboard players operation #f_bx oa.tmp -= #cx br.x
scoreboard players operation #f_bz oa.tmp -= #cz br.z
execute if score #f_bx oa.tmp matches ..-1 run scoreboard players operation #f_bx oa.tmp *= #f_neg oa.tmp
execute if score #f_bz oa.tmp matches ..-1 run scoreboard players operation #f_bz oa.tmp *= #f_neg oa.tmp
execute if score #f_bx oa.tmp >= #f_border_half oa.tmp run scoreboard players set #f_hit oa.tmp 1
execute if score #f_bz oa.tmp >= #f_border_half oa.tmp run scoreboard players set #f_hit oa.tmp 1
