execute unless score #active tdm.sys matches 1 run return 0
scoreboard players set #active tdm.sys 0
scoreboard players set #state br.state 2
execute as @a[tag=tdm.player] at @s run function oa:tdm/withdraw
execute in oa:tdm run kill @e[tag=tdm.pickup]
execute in oa:tdm run kill @e[type=minecraft:item]
execute in oa:tdm run kill @e[tag=oa.projectile]
execute in oa:tdm run kill @e[tag=oa.itori_proxy]
execute in oa:tdm run kill @e[tag=oa.itori_bolt]
execute in oa:tdm run kill @e[tag=oa.nero_vis]
scoreboard objectives setdisplay sidebar.team.red
scoreboard objectives setdisplay sidebar.team.blue
scoreboard players operation #mode br.mode = #old_mode tdm.sys
scoreboard players set #state br.state 0
execute if data storage oa:lobby origin{ready:1b} as @a[tag=br.watch] run function oa:lobby/center with storage oa:lobby origin
execute as @a[tag=br.lobby] run function oa:br/team/sync
tellraw @a[tag=br.lobby] {text:"TDM終了。ロビーに戻りました。",color:"green"}
