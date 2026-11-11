tag @s add br.gm_override
execute if entity @s[tag=br.watch] run team leave @s
tag @s remove br.watch
gamemode adventure @s
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:"：adventure に変更しました。",color:"green"}]
