scoreboard players add #proj_seq oa.proj 1
scoreboard players operation @s oa.proj = #proj_seq oa.proj
tag @s add oa.throw_observed
scoreboard players set #throw_owner oa.tmp 0
execute on origin if entity @s[type=minecraft:player,tag=br.alive] run scoreboard players operation #throw_owner oa.tmp = @s oa.id
execute on origin if entity @s[tag=oa.debug,tag=oa.db_free_match] run scoreboard players operation #throw_owner oa.tmp = @s oa.id
execute if score #throw_owner oa.tmp matches 0 run return 0
summon minecraft:marker ~ ~ ~ {Tags:["oa.throw_observer","oa.throw_new"]}
scoreboard players operation @e[tag=oa.throw_new,limit=1] oa.proj = @s oa.proj
scoreboard players operation @e[tag=oa.throw_new,limit=1] oa.powner = #throw_owner oa.tmp
execute if entity @s[type=minecraft:snowball] run tag @e[tag=oa.throw_new] add oa.observe_snow
tag @e[tag=oa.throw_new] remove oa.throw_new
