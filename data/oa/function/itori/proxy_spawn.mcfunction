summon minecraft:interaction ~ ~ ~ {Tags:["oa.itori_proxy","oa.itori_new"],width:0.9f,height:0.9f,response:0b}
scoreboard players operation @e[type=minecraft:interaction,tag=oa.itori_new,limit=1] oa.owner = @s oa.id
tag @e[tag=oa.itori_new] remove oa.itori_new
