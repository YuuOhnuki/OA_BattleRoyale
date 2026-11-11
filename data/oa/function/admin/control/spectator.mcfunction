execute if score #state br.state matches 1 if entity @s[tag=br.alive] run function oa:br/surrender
tag @s add br.gm_override
execute if score #state br.state matches 0 run tag @s remove br.lobby
execute unless entity @s[tag=br.playing] run tag @s add br.watch
gamemode spectator @s
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:"：spectator に変更しました。",color:"green"}]
