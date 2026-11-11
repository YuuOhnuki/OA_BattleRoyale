summon minecraft:marker ~ ~ ~ {Tags:["oa.i_dive_apex","oa.i_new"]}
scoreboard players operation @e[tag=oa.i_new,limit=1] oa.owner = @s oa.id
tag @e[tag=oa.i_new] remove oa.i_new
