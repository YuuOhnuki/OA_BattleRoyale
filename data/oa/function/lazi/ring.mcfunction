summon minecraft:marker ~ ~ ~ {Tags:["oa.note_wave","oa.wave_new"]}
scoreboard players set @e[tag=oa.wave_new] oa.wait 0
scoreboard players operation @e[tag=oa.wave_new,limit=1] oa.id = @s oa.id
tag @e[tag=oa.wave_new] remove oa.wave_new
