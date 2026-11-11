scoreboard players set #state br.state 3
scoreboard players set #celebration br.time 0
execute as @a[tag=br.playing] at @s run function oa:status/reset
execute as @a[tag=br.playing] at @s run function oa:internal/cleanup
gamemode spectator @a[tag=br.playing]
execute as @a[tag=br.playing] at @s run playsound minecraft:ui.toast.challenge_complete player @s ~ ~ ~ 1 1
execute as @a[tag=br.winner,tag=br.playing] at @s run function oa:br/celebration/spark
function oa:br/bars/hide
