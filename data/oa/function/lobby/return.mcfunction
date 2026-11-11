execute if entity @s[tag=oa.practice] run return run function oa:practice/leave
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合中は参加へ戻れません。",color:"yellow"}
execute if entity @s[gamemode=spectator] run gamemode adventure @s
function oa:br/join
execute if data storage oa:lobby origin{ready:1b} run function oa:lobby/center with storage oa:lobby origin
