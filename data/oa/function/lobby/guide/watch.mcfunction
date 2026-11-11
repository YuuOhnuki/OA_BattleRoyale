execute if score #state br.state matches 1 if entity @s[tag=br.alive] run return run function oa:br/surrender
execute if score #state br.state matches 0 run return run function oa:lobby/watch
execute if entity @s[tag=br.playing] run return 0
tag @s add br.watch
tag @s remove br.lobby
gamemode spectator @s
execute if data storage oa:br center run function oa:internal/tp with storage oa:br center

tellraw @s {text:"[参加者へ戻る]",color:"green",click_event:{action:"run_command",command:"/trigger oa.lobby set 6"}}
