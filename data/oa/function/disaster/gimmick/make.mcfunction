scoreboard players add #gm_cnt br.tmp 1
summon minecraft:marker ~ ~ ~ {Tags:["br.dis","br.gimmick","br.gm_made"]}
scoreboard players operation #gm_m br.tmp = #gm_cnt br.tmp
scoreboard players operation #gm_m br.tmp %= #3 br.tmp
execute if score #gm_m br.tmp matches 0 run scoreboard players set @e[type=minecraft:marker,tag=br.gm_made,distance=..1,limit=1] br.gkind 2
execute unless score #gm_m br.tmp matches 0 run scoreboard players set @e[type=minecraft:marker,tag=br.gm_made,distance=..1,limit=1] br.gkind 1
execute store result score @e[type=minecraft:marker,tag=br.gm_made,distance=..1,limit=1] br.dtmr run random value 3..14
tag @e[type=minecraft:marker,tag=br.gm_made,distance=..1] remove br.gm_made
execute if score #gm_cnt br.tmp matches 6 run function oa:disaster/gimmick/announce
