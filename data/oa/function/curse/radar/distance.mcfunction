scoreboard players set #r_far oa.tmp 0
scoreboard players set #r_sq oa.tmp 0
execute store result score #r_v oa.tmp run data get entity @s Pos[0]
execute store result score #r_d oa.tmp run data get entity @a[tag=oa.radar_target,limit=1] Pos[0]
scoreboard players operation #r_d oa.tmp -= #r_v oa.tmp
execute unless score #r_d oa.tmp matches -10000..10000 run scoreboard players set #r_far oa.tmp 1
execute if score #r_d oa.tmp matches -10000..10000 run scoreboard players operation #r_d oa.tmp *= #r_d oa.tmp
execute if score #r_far oa.tmp matches 0 run scoreboard players operation #r_sq oa.tmp += #r_d oa.tmp
execute store result score #r_v oa.tmp run data get entity @s Pos[1]
execute store result score #r_d oa.tmp run data get entity @a[tag=oa.radar_target,limit=1] Pos[1]
scoreboard players operation #r_d oa.tmp -= #r_v oa.tmp
execute unless score #r_d oa.tmp matches -10000..10000 run scoreboard players set #r_far oa.tmp 1
execute if score #r_d oa.tmp matches -10000..10000 run scoreboard players operation #r_d oa.tmp *= #r_d oa.tmp
execute if score #r_far oa.tmp matches 0 run scoreboard players operation #r_sq oa.tmp += #r_d oa.tmp
execute store result score #r_v oa.tmp run data get entity @s Pos[2]
execute store result score #r_d oa.tmp run data get entity @a[tag=oa.radar_target,limit=1] Pos[2]
scoreboard players operation #r_d oa.tmp -= #r_v oa.tmp
execute unless score #r_d oa.tmp matches -10000..10000 run scoreboard players set #r_far oa.tmp 1
execute if score #r_d oa.tmp matches -10000..10000 run scoreboard players operation #r_d oa.tmp *= #r_d oa.tmp
execute if score #r_far oa.tmp matches 0 run scoreboard players operation #r_sq oa.tmp += #r_d oa.tmp
scoreboard players set #r_lo oa.tmp 0
scoreboard players set #r_hi oa.tmp 32768
execute if score #r_far oa.tmp matches 0 run function oa:curse/radar/sqrt
execute store result storage oa:radar distance int 1 run scoreboard players get #r_lo oa.tmp
