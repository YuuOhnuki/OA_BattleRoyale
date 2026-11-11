execute unless entity @s[tag=br.admin] run return run tellraw @s {text:"先にOPで /function oa:admin を実行してください。",color:"red"}
function oa:admin/control/actor
$data modify storage oa:manage request set value {action:"$(action)"}
scoreboard players set #control_action oa.tmp 0
execute if data storage oa:manage request{action:"survival"} run scoreboard players set #control_action oa.tmp 1
execute if data storage oa:manage request{action:"adventure"} run scoreboard players set #control_action oa.tmp 2
execute if data storage oa:manage request{action:"creative"} run scoreboard players set #control_action oa.tmp 3
execute if data storage oa:manage request{action:"spectator"} run scoreboard players set #control_action oa.tmp 4
execute if data storage oa:manage request{action:"revive"} run scoreboard players set #control_action oa.tmp 5
execute if score #control_action oa.tmp matches 0 run return run tellraw @s {text:"action は survival / adventure / creative / spectator / revive を指定してください。",color:"yellow"}
scoreboard players set #control_found oa.tmp 0
$execute as @a[name="$(player)"] at @s run function oa:admin/control/queue
execute if score #control_found oa.tmp matches 0 run tellraw @s {text:"対象のオンラインプレイヤーが見つかりません。",color:"yellow"}
