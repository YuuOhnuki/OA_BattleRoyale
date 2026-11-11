execute store result score #f_border_half oa.tmp run worldborder get
scoreboard players set #f_500 oa.tmp 500
scoreboard players set #f_has_border oa.tmp 0
execute if dimension oa:practice run return 0
execute if score #f_border_half oa.tmp matches ..4000000 run scoreboard players set #f_has_border oa.tmp 1
execute if score #f_has_border oa.tmp matches 1 run scoreboard players operation #f_border_half oa.tmp *= #f_500 oa.tmp
