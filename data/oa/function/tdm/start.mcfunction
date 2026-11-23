execute if score #busy oa.template matches 1 run return run tellraw @s {text:"マップの保存／復元が処理中です。完了までお待ちください。"}
execute unless score #state br.state matches 0 run return 0
execute if data storage oa_map2:job {working:1b} run return run tellraw @s {text:"マップ生成が終わるまで待ってください",color:"red"}
execute if score #busy br.clean matches 1 run return 0
execute if entity @a[tag=br.lobby,scores={br.saved=1},tag=!oa.practice] run return run tellraw @s {text:"持ち物の復元待ちの参加者がいます",color:"red"}
execute if entity @a[tag=br.lobby,tag=oa.dead] run return run tellraw @s {text:"全員が復活してから開始してください",color:"red"}
scoreboard players set #players tdm.sys 0
execute as @a[tag=br.lobby] run scoreboard players add #players tdm.sys 1
execute unless score #players tdm.sys matches 2..10 run return run tellraw @s {text:"TDMには2～10人必要です",color:"red"}
execute as @a[tag=br.lobby,tag=oa.practice] at @s run function oa:practice/leave
execute as @a[tag=br.lobby,tag=oa.debug] at @s run function oa:debug/stop
execute unless score #ready tdm.sys matches 197 run return run function oa:tdm/map/prepare
execute as @a[tag=br.lobby] unless score @s oa.id matches 1.. run function oa:internal/id
execute as @a[tag=br.lobby] at @s run function oa:br/save_player
execute if entity @a[tag=br.lobby,scores={br.saved=0}] run return run function oa:tdm/save_failed
scoreboard players add #round br.round 1
scoreboard players operation #old_mode tdm.sys = #mode br.mode
scoreboard players set #mode br.mode 1
scoreboard players set #state br.state 1
scoreboard players set #active tdm.sys 1
scoreboard players set #time tdm.sys 0
scoreboard players set #warmup tdm.sys 200
execute in oa:tdm run gamerule minecraft:locator_bar false
scoreboard players set #time br.time 0
scoreboard players set #red tdm.points 0
scoreboard players set #blue tdm.points 0
scoreboard players set #red_n tdm.sys 0
scoreboard players set #blue_n tdm.sys 0
# Honor preferences; assign unselected players to the smaller side.
execute as @a[tag=br.lobby,scores={tdm.team=1}] run scoreboard players add #red_n tdm.sys 1
execute as @a[tag=br.lobby,scores={tdm.team=2}] run scoreboard players add #blue_n tdm.sys 1
execute as @a[tag=br.lobby] unless score @s tdm.team matches 1..2 run function oa:tdm/assign
function oa:tdm/rebalance
team add oa_tdm_red
team add oa_tdm_blue
team modify oa_tdm_red color red
team modify oa_tdm_blue color blue
team modify oa_tdm_red friendlyFire false
team modify oa_tdm_blue friendlyFire false
team modify oa_tdm_red collisionRule never
team modify oa_tdm_blue collisionRule never
team modify oa_tdm_red nametagVisibility hideForOtherTeams
team modify oa_tdm_blue nametagVisibility hideForOtherTeams
function oa:br/ui/stop
function oa:br/bars/hide
execute as @a[tag=br.lobby] at @s run function oa:tdm/enter
execute in oa:tdm run function oa:tdm/loot/reset
scoreboard players set #yuua_issued br.tmp 0
scoreboard players set 残り秒 tdm.board 300
scoreboard players set 赤チーム tdm.board 0
scoreboard players set 青チーム tdm.board 0
title @a[tag=tdm.player] times 0 25 0
title @a[tag=tdm.player] title {text:"開始まで 10",color:"gold"}
scoreboard objectives setdisplay sidebar.team.red tdm.board
scoreboard objectives setdisplay sidebar.team.blue tdm.board
tellraw @a[tag=tdm.player] {text:"配置完了！10秒後にTDM開始。石の剣・弓・矢10本を支給しました"}
execute as @a[tag=tdm.player] run function oa:tdm/warmup_lock

scoreboard players set @a[tag=tdm.player] tdm.ui 1
