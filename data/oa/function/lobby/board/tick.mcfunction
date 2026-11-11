execute unless data storage oa:lobby origin{ready:1b} run return 0
execute if data storage oa:lobby_job {working:1b} run return 0
execute unless data storage oa:lobby {board_built:1b,board_ver:105} run function oa:lobby/board/build with storage oa:lobby origin
scoreboard players add #bclock oa.tmp 1
execute if score #bclock oa.tmp matches 100.. run scoreboard players set #bclock oa.tmp 0
execute unless score #bclock oa.tmp matches 0 run return 0
execute unless entity @a[tag=br.lobby_now] run return 0
function oa:lobby/board/refresh with storage oa:lobby origin
