$summon minecraft:marker $(x) $(y) $(z) {Tags:["br.spawn","br.new"]}
scoreboard players operation @e[tag=br.new,limit=1] oa.id = @s oa.id
tag @e[tag=br.new] remove br.new
