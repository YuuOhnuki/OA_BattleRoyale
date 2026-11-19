summon minecraft:tnt ~ ~ ~ {fuse:400s,explosion_power:0.0f,Tags:["oa.g_tnt","oa.g_tnt_new"]}
scoreboard players set @e[type=minecraft:tnt,tag=oa.g_tnt_new,distance=..1] oa.gbomb 80
scoreboard players operation @e[type=minecraft:tnt,tag=oa.g_tnt_new,distance=..1] oa.gby = #g_tnt_by oa.tmp
scoreboard players operation @e[type=minecraft:tnt,tag=oa.g_tnt_new,distance=..1] br.round = #round br.round
tag @e[type=minecraft:tnt,tag=oa.g_tnt_new,distance=..1] remove oa.g_tnt_new
