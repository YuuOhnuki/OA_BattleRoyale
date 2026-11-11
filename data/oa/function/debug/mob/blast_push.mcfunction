tag @s add oa.db_blast_victim
execute at @e[type=minecraft:item_display,tag=oa.f_current,limit=1] run summon minecraft:marker ~ ~ ~ {Tags:["oa.db_blast_dir"]}
execute as @e[type=minecraft:marker,tag=oa.db_blast_dir,limit=1] at @s run tp @s ~ ~ ~ facing entity @e[tag=oa.db_blast_victim,limit=1] feet
execute at @e[type=minecraft:marker,tag=oa.db_blast_dir,limit=1] rotated as @e[type=minecraft:marker,tag=oa.db_blast_dir,limit=1] rotated ~ 0 positioned ^ ^ ^1.2 run summon minecraft:marker ~ ~ ~ {Tags:["oa.db_blast_vector"]}
execute store result score #db_vec_x oa.tmp run data get entity @e[tag=oa.db_blast_vector,limit=1] Pos[0] 10000
execute store result score #db_vec_z oa.tmp run data get entity @e[tag=oa.db_blast_vector,limit=1] Pos[2] 10000
execute store result score #db_base_x oa.tmp run data get entity @e[tag=oa.db_blast_dir,limit=1] Pos[0] 10000
execute store result score #db_base_z oa.tmp run data get entity @e[tag=oa.db_blast_dir,limit=1] Pos[2] 10000
scoreboard players operation #db_vec_x oa.tmp -= #db_base_x oa.tmp
scoreboard players operation #db_vec_z oa.tmp -= #db_base_z oa.tmp
execute store result entity @s Motion[0] double 0.0001 run scoreboard players get #db_vec_x oa.tmp
execute store result entity @s Motion[2] double 0.0001 run scoreboard players get #db_vec_z oa.tmp
data modify entity @s Motion[1] set value 0.45d
kill @e[tag=oa.db_blast_dir]
kill @e[tag=oa.db_blast_vector]
tag @s remove oa.db_blast_victim
