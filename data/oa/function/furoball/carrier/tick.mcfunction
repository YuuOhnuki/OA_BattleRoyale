execute unless entity @s[tag=oa.db_projectile] unless score #state br.state matches 1 run return run function oa:furoball/carrier/release
execute unless score @s br.round = #round br.round run return run function oa:furoball/carrier/release
scoreboard players operation #f_car_owner oa.tmp = @s oa.fowner
scoreboard players set #f_has_rider oa.tmp 0
execute on passengers if entity @s[type=minecraft:player,gamemode=!spectator,nbt=!{Health:0.0f}] if score @s oa.id = #f_car_owner oa.tmp run scoreboard players set #f_has_rider oa.tmp 1
execute if score #f_has_rider oa.tmp matches 0 run return run function oa:furoball/carrier/release
scoreboard players add @s oa.fcage 1
execute if score @s oa.fcage matches 40.. run return run function oa:furoball/carrier/release
scoreboard players set #f_roof_clear oa.tmp 1
execute on passengers at @s run function oa:furoball/carrier/clearance
execute if score #f_roof_clear oa.tmp matches 0 run return run function oa:furoball/carrier/release
execute store result score #f_car_vy oa.tmp run data get entity @s Motion[1] 10000
execute if score @s oa.fcage matches 2.. if score #f_car_vy oa.tmp matches ..0 run return run function oa:furoball/carrier/release
execute if score @s oa.fcage matches 3.. if entity @s[nbt={OnGround:1b}] run function oa:furoball/carrier/release
