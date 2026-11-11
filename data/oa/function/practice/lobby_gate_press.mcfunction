execute unless block ~ ~ ~ minecraft:stone_button[powered=true] run return run scoreboard players set #practice_gate oa.tmp 0
execute if score #practice_gate oa.tmp matches 1 run return 0
execute unless entity @p[tag=br.lobby_now,tag=!br.playing,tag=!oa.debug,gamemode=!spectator,distance=..6] run return 0
scoreboard players set #practice_gate oa.tmp 1
execute as @p[tag=br.lobby_now,tag=!br.playing,tag=!oa.debug,gamemode=!spectator,distance=..6] at @s run function oa:practice/enter
