execute if score #state br.state matches 1 if entity @s[tag=br.alive] run function oa:br/surrender
tag @s add br.gm_override
execute if entity @s[tag=br.watch] run team leave @s
tag @s remove br.watch
gamemode creative @s
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:"：creative に変更しました。",color:"green"}]
