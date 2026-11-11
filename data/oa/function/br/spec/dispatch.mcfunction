execute unless score #state br.state matches 1 run return run tellraw @s {text:"試合中の観戦のみ使えます。",color:"yellow"}
execute unless entity @s[tag=br.playing,tag=!br.alive] unless entity @s[tag=br.watch] run return run tellraw @s {text:"観戦は脱落後・観戦者のみ使えます。",color:"yellow"}
execute unless entity @s[gamemode=spectator] run return 0
execute if score @s oa.spec matches 1 run function oa:br/spec/next
execute if score @s oa.spec matches 2 run function oa:br/spec/prev
execute if score @s oa.spec matches 3 run spectate
execute if score @s oa.spec matches 3 run title @s actionbar {text:"自由視点",color:"gray"}
