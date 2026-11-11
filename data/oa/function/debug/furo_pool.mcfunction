execute if entity @s[tag=oa.db_mobs] run tag @e[tag=oa.debug_mob,distance=..64,nbt=!{Health:0.0f}] add oa.db_f_target
tag @a[tag=oa.debug,tag=!oa.practice,gamemode=!spectator,distance=..64] add oa.db_f_target
execute if entity @s[tag=oa.practice] run tag @s add oa.db_f_target
