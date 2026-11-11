data remove entity @s interaction
scoreboard players set @s oa.exbtn 12
execute if score @s oa.gallery_id matches 1 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=east,powered=true]
execute if score @s oa.gallery_id matches 2 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=east,powered=true]
execute if score @s oa.gallery_id matches 3 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=east,powered=true]
execute if score @s oa.gallery_id matches 4 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=east,powered=true]
execute if score @s oa.gallery_id matches 5 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=west,powered=true]
execute if score @s oa.gallery_id matches 6 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=west,powered=true]
execute if score @s oa.gallery_id matches 7 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=west,powered=true]
execute if score @s oa.gallery_id matches 8 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=south,powered=true]
execute if score @s oa.gallery_id matches 9 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=south,powered=true]
execute if score @s oa.gallery_id matches 10 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=west,powered=true]
execute if score @s oa.gallery_id matches 11 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=south,powered=true]

execute if score @s oa.gallery_id matches 12 run setblock ~ ~ ~ minecraft:stone_button[face=wall,facing=north,powered=true]
