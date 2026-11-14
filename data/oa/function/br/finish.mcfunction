execute if score #state br.state matches 0 run return 0
execute if data storage oa:br center run function oa:br/cleanup_loose with storage oa:br center
scoreboard players set #state br.state 2
function oa:br/finale/stop
function oa:br/supply/clear
execute as @a[tag=br.playing,tag=!oa.practice] if score @s br.round = #round br.round run function oa:br/locator/restore
tag @a[tag=br.playing] remove br.winner
function oa:br/ui/stop
function oa:br/team/reset
execute if score #natural br.flag matches 0 run gamerule minecraft:natural_health_regeneration false
execute if score #natural br.flag matches 1 run gamerule minecraft:natural_health_regeneration true
tag @a[tag=br.playing] remove br.pvp_grace
function oa:br/border/idle
execute if score #respawn br.flag matches 0 run gamerule minecraft:immediate_respawn false
execute if score #respawn br.flag matches 1 run gamerule minecraft:immediate_respawn true
execute as @a[tag=oa.spec_init] run spectate
tag @a remove oa.spec_init
execute as @a[tag=br.playing,tag=!oa.practice] if score @s br.round = #round br.round at @s run function oa:br/finish_player
function oa:br/cleanup/finish
tellraw @a[tag=br.lobby] {text:"試合終了。ロビーへ戻りました。",color:"green"}
function oa:br/bars/hide
execute if data storage oa:lobby origin{ready:1b} as @a[tag=br.watch] run function oa:lobby/center with storage oa:lobby origin
gamerule minecraft:locator_bar false

function oa:br/day/restore
function oa:disaster/clear
function oa:br/weather/restore
scoreboard players set #bclock oa.tmp 4

execute if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:armor_stand,tag=jp_vehicle] at @s run function jumppad:land
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:armor_stand,tag=jp_vehicle] at @s run function jumppad:land

execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,type=minecraft:block_display,tag=oa.gacha_bomb,tag=!oa.db_projectile]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,type=minecraft:block_display,tag=oa.gacha_bomb,tag=!oa.db_projectile]
execute in minecraft:the_nether run kill @e[distance=0..,type=minecraft:block_display,tag=oa.gacha_bomb,tag=!oa.db_projectile]
execute in minecraft:the_end run kill @e[distance=0..,type=minecraft:block_display,tag=oa.gacha_bomb,tag=!oa.db_projectile]

data modify storage oa:gacha_hits hits set value {}

execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,type=minecraft:item_display,tag=oa.furoball,tag=!oa.db_projectile]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,type=minecraft:item_display,tag=oa.furoball,tag=!oa.db_projectile]

execute if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:armor_stand,tag=oa.furo_carrier,tag=!oa.db_projectile] run function oa:furoball/carrier/release
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:armor_stand,tag=oa.furo_carrier,tag=!oa.db_projectile] run function oa:furoball/carrier/release
execute in minecraft:the_nether as @e[distance=0..,type=minecraft:armor_stand,tag=oa.furo_carrier,tag=!oa.db_projectile] run function oa:furoball/carrier/release
execute in minecraft:the_end as @e[distance=0..,type=minecraft:armor_stand,tag=oa.furo_carrier,tag=!oa.db_projectile] run function oa:furoball/carrier/release



execute as @a[tag=br.lobby,tag=!br.playing] run function oa:lobby/guide/book
schedule function oa:lobby/events/finish_cached 60t replace

execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=oa.itori_proxy,tag=!oa.db_projectile]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=oa.itori_proxy,tag=!oa.db_projectile]
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=oa.itori_bolt,tag=!oa.db_projectile]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=oa.itori_bolt,tag=!oa.db_projectile]
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=oa.itori_sweep,tag=!oa.db_projectile]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=oa.itori_sweep,tag=!oa.db_projectile]

execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=oa.itori_fx,tag=!oa.db_projectile]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=oa.itori_fx,tag=!oa.db_projectile]
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=oa.itori_shield_mesh,tag=!oa.db_projectile]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=oa.itori_shield_mesh,tag=!oa.db_projectile]
execute in minecraft:the_nether run kill @e[distance=0..,tag=oa.itori_fx,tag=!oa.db_projectile]
execute in minecraft:the_nether run kill @e[distance=0..,tag=oa.itori_shield_mesh,tag=!oa.db_projectile]
execute in minecraft:the_end run kill @e[distance=0..,tag=oa.itori_fx,tag=!oa.db_projectile]
execute in minecraft:the_end run kill @e[distance=0..,tag=oa.itori_shield_mesh,tag=!oa.db_projectile]

# 1.9.157〜1.9.158 でチェストの名前に付けた残り時間を消す（読み込まれている会場のチェスト。残りは次の試合の br/loot/chest_initial で消す）
execute if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:marker,tag=br.chest,tag=!br.rich] at @s if block ~ ~ ~ minecraft:chest run data remove block ~ ~ ~ CustomName
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:marker,tag=br.chest,tag=!br.rich] at @s if block ~ ~ ~ minecraft:chest run data remove block ~ ~ ~ CustomName
