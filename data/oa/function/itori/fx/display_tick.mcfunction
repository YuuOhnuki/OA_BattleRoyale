execute unless score @s br.round = #round br.round run return run kill @s
scoreboard players remove @s oa.i_fxlife 1
execute if entity @s[tag=oa.i_frost_wave] if score @s oa.i_fxlife matches 5 run data merge entity @s {start_interpolation:0,interpolation_duration:5,transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[4f,1.2f,4f]}}
execute if score @s oa.i_fxlife matches ..0 run kill @s




execute if entity @s[tag=oa.i_orange_floor] if score @s oa.i_fxlife matches 13 run function oa:itori/fx/orange_up_13
execute if entity @s[tag=oa.i_orange_floor] if score @s oa.i_fxlife matches 10 run function oa:itori/fx/orange_up_10
execute if entity @s[tag=oa.i_orange_floor] if score @s oa.i_fxlife matches 7 run function oa:itori/fx/orange_up_7
execute if entity @s[tag=oa.i_orange_floor] if score @s oa.i_fxlife matches 4 run function oa:itori/fx/orange_up_4
