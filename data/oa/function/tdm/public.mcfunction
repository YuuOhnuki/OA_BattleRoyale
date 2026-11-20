execute as @a[scores={oa.game=1..2}] at @s run function oa:tdm/select_mode
execute as @a[scores={oa.tdm=1..}] at @s run function oa:tdm/select_loadout
scoreboard players set @a oa.game 0
scoreboard players set @a oa.tdm 0
scoreboard players enable @a oa.game
scoreboard players enable @a oa.tdm
execute if score #state br.state matches 0 unless data storage oa:lobby_job {working:1b} if data storage oa:lobby origin{ready:1b} unless data storage oa:lobby {tdm_station:1b} run function oa:tdm/lobby_build with storage oa:lobby origin
execute in minecraft:overworld as @e[type=minecraft:marker,tag=tdm.button] at @s run function oa:tdm/button
