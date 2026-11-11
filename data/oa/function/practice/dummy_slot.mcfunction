scoreboard players operation #practice_owner oa.tmp = @s oa.owner
scoreboard players set #practice_found oa.tmp 0
execute as @e[type=minecraft:zombie,tag=oa.practice_dummy,distance=..18,nbt=!{Health:0.0f}] if score @s oa.id = #practice_owner oa.tmp run scoreboard players set #practice_found oa.tmp 1
execute if score #practice_found oa.tmp matches 1 run scoreboard players reset @s oa.practice_resp
execute if score #practice_found oa.tmp matches 1 run return 0
execute unless score @s oa.practice_resp matches 0.. at @s summon minecraft:marker run function oa:practice/dummy_death
execute store result score #practice_now oa.tmp run time query gametime
execute unless score @s oa.practice_resp matches 0.. run scoreboard players operation @s oa.practice_resp = #practice_now oa.tmp
execute if score @s oa.practice_resp > #practice_now oa.tmp run scoreboard players operation @s oa.practice_resp = #practice_now oa.tmp
scoreboard players operation #practice_age oa.tmp = #practice_now oa.tmp
scoreboard players operation #practice_age oa.tmp -= @s oa.practice_resp
execute if score #practice_age oa.tmp matches 200.. run function oa:practice/dummy_spawn
