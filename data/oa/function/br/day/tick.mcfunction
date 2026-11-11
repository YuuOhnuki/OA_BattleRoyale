scoreboard players operation #sun oa.tmp = #time br.time
scoreboard players set #four oa.tmp 4
scoreboard players operation #sun oa.tmp *= #four oa.tmp
scoreboard players add #sun oa.tmp 6000
execute store result storage oa:day args.time int 1 run scoreboard players get #sun oa.tmp
execute in oa:br run function oa:br/day/set with storage oa:day args
