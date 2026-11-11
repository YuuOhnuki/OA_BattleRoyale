execute as @a[tag=oa.debug,tag=!oa.practice] at @s run function oa:debug/stop
execute if score #state br.state matches 1.. run return 0
scoreboard players set #skip_clean br.clean 0
execute if score #clean_ready br.clean matches 1 run scoreboard players set #skip_clean br.clean 1
scoreboard players set #clean_ready br.clean 0
execute if data storage oa_map2:job {working:1b} run return run tellraw @s {text:"マップ生成・登録が未完了です。完了してから試合を開始してください",color:"red"}
execute unless data storage oa:br center{dim:"oa:br"} run return run tellraw @s {text:"先に /function oa:map/create で専用ディメンションにBRマップを生成してください。",color:"red"}
function oa:br/border/auto
execute if entity @a[tag=br.lobby,scores={br.saved=1}] run return run tellraw @s {text:"復元待ちの参加者がいます",color:"red"}
execute if entity @a[tag=br.lobby,nbt={Health:0.0f}] run return run tellraw @s {text:"死亡中の参加者がいます。復活してから開始してください",color:"red"}
scoreboard players set #players br.tmp 0
execute as @a[tag=br.lobby] run scoreboard players add #players br.tmp 1
execute unless score #players br.tmp matches 1..10 run return run tellraw @s {text:"参加者は1～10人必要です",color:"red"}
execute if score #mode br.mode matches 1 unless entity @a[tag=br.lobby,scores={br.pick=1..10}] run return 0
execute if score #mode br.mode matches 1 if entity @a[tag=br.lobby,scores={br.pick=0}] run return run tellraw @s {text:"全員が羊毛でチームを選択してください",color:"red"}
scoreboard players set #teams br.tmp 0
scoreboard players set #bad br.flag 0
scoreboard players set #count br.tmp 0
execute as @a[tag=br.lobby,scores={br.pick=1}] run scoreboard players add #count br.tmp 1
execute if score #count br.tmp matches 1.. run scoreboard players add #teams br.tmp 1
execute if score #count br.tmp matches 4.. run scoreboard players set #bad br.flag 1
scoreboard players set #count br.tmp 0
execute as @a[tag=br.lobby,scores={br.pick=2}] run scoreboard players add #count br.tmp 1
execute if score #count br.tmp matches 1.. run scoreboard players add #teams br.tmp 1
execute if score #count br.tmp matches 4.. run scoreboard players set #bad br.flag 1
scoreboard players set #count br.tmp 0
execute as @a[tag=br.lobby,scores={br.pick=3}] run scoreboard players add #count br.tmp 1
execute if score #count br.tmp matches 1.. run scoreboard players add #teams br.tmp 1
execute if score #count br.tmp matches 4.. run scoreboard players set #bad br.flag 1
scoreboard players set #count br.tmp 0
execute as @a[tag=br.lobby,scores={br.pick=4}] run scoreboard players add #count br.tmp 1
execute if score #count br.tmp matches 1.. run scoreboard players add #teams br.tmp 1
execute if score #count br.tmp matches 4.. run scoreboard players set #bad br.flag 1
scoreboard players set #count br.tmp 0
execute as @a[tag=br.lobby,scores={br.pick=5}] run scoreboard players add #count br.tmp 1
execute if score #count br.tmp matches 1.. run scoreboard players add #teams br.tmp 1
execute if score #count br.tmp matches 4.. run scoreboard players set #bad br.flag 1
scoreboard players set #count br.tmp 0
execute as @a[tag=br.lobby,scores={br.pick=6}] run scoreboard players add #count br.tmp 1
execute if score #count br.tmp matches 1.. run scoreboard players add #teams br.tmp 1
execute if score #count br.tmp matches 4.. run scoreboard players set #bad br.flag 1
scoreboard players set #count br.tmp 0
execute as @a[tag=br.lobby,scores={br.pick=7}] run scoreboard players add #count br.tmp 1
execute if score #count br.tmp matches 1.. run scoreboard players add #teams br.tmp 1
execute if score #count br.tmp matches 4.. run scoreboard players set #bad br.flag 1
scoreboard players set #count br.tmp 0
execute as @a[tag=br.lobby,scores={br.pick=8}] run scoreboard players add #count br.tmp 1
execute if score #count br.tmp matches 1.. run scoreboard players add #teams br.tmp 1
execute if score #count br.tmp matches 4.. run scoreboard players set #bad br.flag 1
scoreboard players set #count br.tmp 0
execute as @a[tag=br.lobby,scores={br.pick=9}] run scoreboard players add #count br.tmp 1
execute if score #count br.tmp matches 1.. run scoreboard players add #teams br.tmp 1
execute if score #count br.tmp matches 4.. run scoreboard players set #bad br.flag 1
scoreboard players set #count br.tmp 0
execute as @a[tag=br.lobby,scores={br.pick=10}] run scoreboard players add #count br.tmp 1
execute if score #count br.tmp matches 1.. run scoreboard players add #teams br.tmp 1
execute if score #count br.tmp matches 4.. run scoreboard players set #bad br.flag 1
execute if score #mode br.mode matches 1 if score #bad br.flag matches 1 run return run tellraw @s {text:"1チームは最大3人です",color:"red"}
execute if score #mode br.mode matches 1 unless score #teams br.tmp matches 2.. run return run tellraw @s {text:"チーム戦には2チーム以上必要です",color:"red"}
execute unless score #skip_clean br.clean matches 1 run return run function oa:br/cleanup/start
execute as @a[tag=br.lobby] unless score @s oa.id matches 1.. run function oa:internal/id
execute as @a[tag=br.lobby] at @s run function oa:br/save_player
execute if entity @a[tag=br.lobby,scores={br.saved=0}] run return run function oa:br/save_failed
execute in oa:br run kill @e[distance=0..,type=minecraft:marker,tag=br.spawn]
execute in oa:br run function oa:br/preflight with storage oa:br center
execute unless score #spawn_ok br.flag matches 1 run return run function oa:br/spawn_plan_abort
execute in oa:br as @a[tag=br.lobby] run function oa:br/cache_player
execute unless score #spawn_ok br.flag matches 1 run return run function oa:br/spawn_plan_abort
scoreboard players add #round br.round 1
scoreboard players set #state br.state 1
data modify storage oa:gacha_hits hits set value {}
function oa:br/day/start
function oa:br/weather/start
scoreboard players set #yuua_issued br.tmp 0
function oa:br/locator/start
function oa:br/world/setup_normal
execute if data storage oa:br center run function oa:br/cleanup_loose with storage oa:br center
scoreboard players set #time br.time 0
execute store result score #adv_msg br.flag run gamerule minecraft:show_advancement_messages
gamerule minecraft:show_advancement_messages false
execute store result score #natural br.flag run gamerule minecraft:natural_health_regeneration
gamerule minecraft:natural_health_regeneration true
scoreboard players set #notice br.tmp -1
function oa:br/border/start
scoreboard players set #pulse br.tmp 0
execute store result score #respawn br.flag run gamerule minecraft:immediate_respawn
gamerule minecraft:immediate_respawn true
team add oa_br1
team modify oa_br1 friendlyFire false
team add oa_br2
team modify oa_br2 friendlyFire false
team add oa_br3
team modify oa_br3 friendlyFire false
team add oa_br4
team modify oa_br4 friendlyFire false
team add oa_br5
team modify oa_br5 friendlyFire false
team add oa_br6
team modify oa_br6 friendlyFire false
team add oa_br7
team modify oa_br7 friendlyFire false
team add oa_br8
team modify oa_br8 friendlyFire false
team add oa_br9
team modify oa_br9 friendlyFire false
team add oa_br10
team modify oa_br10 friendlyFire false
execute as @a[tag=br.lobby] at @s run function oa:br/enter
execute as @a[tag=br.playing,tag=br.alive] run function oa:br/spawn_commit
scoreboard players set #spawn_live br.flag 1
execute if entity @a[tag=br.playing,tag=br.alive,scores={br.tp_ok=0}] run scoreboard players set #spawn_live br.flag 0
execute unless score #spawn_live br.flag matches 1 run return run function oa:br/tp_abort
execute in oa:br run kill @e[distance=0..,tag=br.spawn]
function oa:br/ui/start
scoreboard players set @a[tag=br.playing] br.open 0
execute as @a[tag=br.playing] run function oa:br/result/reset
scoreboard players set #pid br.tmp 0
execute as @a[tag=br.playing] run function oa:ach/assign_pid
function oa:br/intro
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.ender_dragon.growl player @s ~ ~ ~ 1 1

team modify oa_br1 nametagVisibility hideForOtherTeams
team modify oa_br2 nametagVisibility hideForOtherTeams
team modify oa_br3 nametagVisibility hideForOtherTeams
team modify oa_br4 nametagVisibility hideForOtherTeams
team modify oa_br5 nametagVisibility hideForOtherTeams
team modify oa_br6 nametagVisibility hideForOtherTeams
team modify oa_br7 nametagVisibility hideForOtherTeams
team modify oa_br8 nametagVisibility hideForOtherTeams
team modify oa_br9 nametagVisibility hideForOtherTeams
team modify oa_br10 nametagVisibility hideForOtherTeams

execute as @a[tag=br.watch] run gamemode spectator @s
execute as @a[tag=br.watch] run function oa:internal/tp with storage oa:br center
team modify oa_br1 color light_purple
team modify oa_br2 color aqua
team modify oa_br3 color red
team modify oa_br4 color blue
team modify oa_br5 color green
team modify oa_br6 color yellow
team modify oa_br7 color dark_purple
team modify oa_br8 color gold
team modify oa_br9 color white
team modify oa_br10 color dark_gray
