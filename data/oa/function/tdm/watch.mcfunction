execute if entity @s[tag=tdm.player] run function oa:tdm/withdraw
tag @s add br.watch
tag @s remove br.lobby
gamemode spectator @s
execute in oa:tdm run tp @s 0.5 68 0.5
