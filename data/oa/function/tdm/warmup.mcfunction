scoreboard players remove #warmup tdm.sys 1
scoreboard players operation #seconds tdm.sys = #warmup tdm.sys
scoreboard players add #seconds tdm.sys 19
scoreboard players set #twenty tdm.sys 20
scoreboard players operation #seconds tdm.sys /= #twenty tdm.sys
execute if score #perf oa.tmp matches 0 run title @a[tag=tdm.player] title [{text:"開始まで ",color:"gold"},{score:{name:"#seconds",objective:"tdm.sys"}}]
execute if score #perf oa.tmp matches 0 as @a[tag=tdm.player] at @s run playsound minecraft:block.note_block.hat player @s ~ ~ ~ 0.5 1
execute unless score #warmup tdm.sys matches 0 run return 0
execute as @a[tag=tdm.player] run attribute @s minecraft:movement_speed modifier remove oa:tdm_start
effect clear @a[tag=tdm.player] minecraft:resistance
tag @a[tag=tdm.player] remove br.pvp_grace
scoreboard players set @a[tag=tdm.player] tdm.guard 0
title @a[tag=tdm.player] title {text:"START!",color:"green"}
