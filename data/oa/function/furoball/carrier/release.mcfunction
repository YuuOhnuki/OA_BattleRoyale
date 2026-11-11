scoreboard players operation #f_car_owner oa.tmp = @s oa.fowner
execute on passengers run ride @s dismount
execute as @a if score @s oa.id = #f_car_owner oa.tmp run tag @s remove oa.furo_up
kill @s
