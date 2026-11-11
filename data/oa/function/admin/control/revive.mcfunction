execute if entity @s[tag=br.alive] run return run tellraw @a[tag=oa.roster_actor] {text:"対象はすでに生存参加中です。",color:"yellow"}
execute if score #state br.state matches 1 run return run function oa:admin/players/join
# Once victory is decided, return the physical player to the lobby without reopening the result.
tag @s add br.gm_override
tag @s remove br.watch
gamemode adventure @s
effect give @s minecraft:instant_health 1 10 true
execute if score #state br.state matches 0 run function oa:lobby/return
execute if score #state br.state matches 3 if data storage oa:lobby origin{ready:1b} run function oa:lobby/center with storage oa:lobby origin
tellraw @a[tag=oa.roster_actor] [{selector:"@s"},{text:" を待機状態へ戻しました。",color:"green"}]
