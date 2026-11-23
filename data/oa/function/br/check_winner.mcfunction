scoreboard players set #alive br.live 0
execute as @a[tag=br.alive,tag=!oa.dead] run scoreboard players add #alive br.live 1
execute if score #players br.tmp matches 1 run return 0
execute if score #alive br.live matches 0 run return run function oa:br/draw
execute if score #mode br.mode matches 0 if score #alive br.live matches 1 run return run function oa:br/win_solo
scoreboard players set #live_teams br.live 0
execute if entity @a[tag=br.alive,scores={oa.team=1},tag=!oa.dead] run scoreboard players add #live_teams br.live 1
execute if entity @a[tag=br.alive,scores={oa.team=2},tag=!oa.dead] run scoreboard players add #live_teams br.live 1
execute if entity @a[tag=br.alive,scores={oa.team=3},tag=!oa.dead] run scoreboard players add #live_teams br.live 1
execute if entity @a[tag=br.alive,scores={oa.team=4},tag=!oa.dead] run scoreboard players add #live_teams br.live 1
execute if entity @a[tag=br.alive,scores={oa.team=5},tag=!oa.dead] run scoreboard players add #live_teams br.live 1
execute if entity @a[tag=br.alive,scores={oa.team=6},tag=!oa.dead] run scoreboard players add #live_teams br.live 1
execute if entity @a[tag=br.alive,scores={oa.team=7},tag=!oa.dead] run scoreboard players add #live_teams br.live 1
execute if entity @a[tag=br.alive,scores={oa.team=8},tag=!oa.dead] run scoreboard players add #live_teams br.live 1
execute if entity @a[tag=br.alive,scores={oa.team=9},tag=!oa.dead] run scoreboard players add #live_teams br.live 1
execute if entity @a[tag=br.alive,scores={oa.team=10},tag=!oa.dead] run scoreboard players add #live_teams br.live 1
execute if score #mode br.mode matches 1 if score #live_teams br.live matches 1 run function oa:br/win_team
