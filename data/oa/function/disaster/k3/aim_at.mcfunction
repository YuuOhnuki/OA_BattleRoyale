$summon minecraft:marker ~$(dx) ~ ~$(dz) {Tags:["br.dis","br.dis_mark","br.dis_new"]}
scoreboard players set @e[type=minecraft:marker,tag=br.dis_new,distance=..20,limit=1] br.dtmr 4
tag @e[type=minecraft:marker,tag=br.dis_new,distance=..20] remove br.dis_new
