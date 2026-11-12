execute unless data storage oa:lobby origin{ready:1b} run return 0
tag @a remove br.lobby_now
function oa:lobby/select_area with storage oa:lobby origin
execute if score #state br.state matches 0 as @a[tag=br.lobby_now,tag=!br.watch,tag=!br.in_lobby,tag=!br.playing] at @s run function oa:br/join
tag @a[tag=br.lobby_now] add br.in_lobby
tag @a[tag=!br.lobby_now] remove br.in_lobby
scoreboard players set @a[tag=!br.lobby_now] br.lcnt 0
execute if score #state br.state matches 0 as @a[tag=br.lobby_now,tag=br.lobby,tag=br.host] at @s run function oa:lobby/host_tick
execute if score #state br.state matches 0 as @a[tag=br.lobby_now,tag=!br.watch] at @s if block ~ ~-0.1 ~ minecraft:gray_wool run function oa:lobby/watch
execute as @a[tag=br.lobby_now] at @s run function oa:lobby/comfort
execute as @a[tag=oa.lobby_safe,tag=!br.lobby_now] run attribute @s minecraft:fall_damage_multiplier modifier remove oa:lobby_fall
tag @a[tag=oa.lobby_safe,tag=!br.lobby_now] remove oa.lobby_safe

execute if score #perf oa.tmp matches 0 run function oa:lobby/protect_exhibits


tag @a[tag=br.pad_latched,tag=!br.lobby_now] remove br.pad_latched
execute as @a[tag=br.pad_latched] at @s unless block ~ ~-0.1 ~ minecraft:emerald_block unless block ~ ~-0.1 ~ minecraft:diamond_block run tag @s remove br.pad_latched


function oa:practice/lobby_gate_tick with storage oa:lobby origin
execute as @e[type=minecraft:marker,tag=oa.button_lobby,tag=!oa.practice_entry] at @s run function oa:lobby/gallery/button_tick
execute as @e[type=minecraft:marker,tag=oa.button_mapsel] at @s run function oa:lobby/mapsel/button_tick
scoreboard players remove @a[scores={oa.exread=1..}] oa.exread 1

execute if score #perf oa.tmp matches 0 unless data storage oa:lobby_job {working:1b} run function oa:lobby/map_labels with storage oa:lobby origin
execute if score #perf oa.tmp matches 0 run function oa:lobby/board/tick

execute if score #perf oa.tmp matches 0 if score #state br.state matches 0 unless data storage oa:lobby_job {working:1b} unless data storage oa:lobby origin{gallery:1981} run function oa:lobby/gallery/ensure with storage oa:lobby origin
scoreboard players add #amb oa.tmp 1
execute if score #amb oa.tmp matches 10.. run scoreboard players set #amb oa.tmp 0
execute if score #perf oa.tmp matches 0 if score #amb oa.tmp matches 0 if entity @a[tag=br.lobby_now,limit=1] run function oa:lobby/ambience with storage oa:lobby origin
