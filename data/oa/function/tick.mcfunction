execute if score #perf oa.tmp matches 19 run tag @a[tag=br.lobby_now] add oa.inv_dirty
scoreboard players add #perf oa.tmp 1
execute if score #perf oa.tmp matches 20.. run scoreboard players set #perf oa.tmp 0
execute if score #perf oa.tmp matches 0 as @a[tag=!oa.player,tag=!oa.debug] run function oa:debug/restore_foreign
execute as @a[tag=oa.debug,tag=!oa.practice] at @s run function oa:debug/tick
execute as @a[tag=oa.practice] at @s run function oa:practice/tick
execute if entity @a[tag=oa.practice] in oa:practice as @e[type=minecraft:marker,tag=oa.button_practice,distance=0..] at @s run function oa:practice/button_tick
tag @a remove oa.curse_guard
execute as @a if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/prepare
function oa:normal/bat_clock
scoreboard players add #clock oa.beat 1
execute in minecraft:overworld run function oa:world_tick
execute in minecraft:the_nether run function oa:world_tick
execute in minecraft:the_end run function oa:world_tick
execute if score #state br.state matches 1..3 if score #map oa.mapid matches 0 in oa:br run function oa:world_tick
execute if score #state br.state matches 1..3 if score #map oa.mapid matches 1 in oa:br_nether run function oa:world_tick
execute if entity @a[tag=oa.practice] in oa:practice run function oa:world_tick
execute as @a[tag=oa.player] at @s run function oa:player_tick
execute if score #clock oa.beat matches 5.. run scoreboard players set #clock oa.beat 0

function oa:br/tick

function oa:br/loot/tick

function oa:hotchikisu/tick
execute as @a[tag=oa.player,gamemode=!spectator] at @s run function oa:overwork/tick

execute if score #perf oa.tmp matches 0 run function oa:br/locator/tick

execute as @a[tag=oa.player,scores={oa.kpush=1..}] at @s run function oa:knockback/tick

execute as @a[tag=oa.hop_lift,gamemode=spectator] run function oa:status/end_hop

function oa:public/tick
scoreboard players add #total oa.gtime 1

function oa:lobby/tick

execute if score #quiet_depth oa.tmp matches 1.. run function oa:yuua/silence_recover

execute if score #clock oa.beat matches 0 run function oa:br/bars/tick

execute as @a[tag=oa.player] at @s run function oa:hotchikisu/status_dispatch

execute if score #clock oa.beat matches 0 as @a run function oa:normal/visual_tick

execute if score #perf oa.tmp matches 0 run function oa:br/border/idle_tick
execute as @a unless score @s br.login_epoch = #epoch br.login_epoch at @s run function oa:lobby/on_login
execute as @a unless score @s br.login_seen = @s br.login_leave at @s run function oa:lobby/on_login
execute if data storage oa:lobby origin{ready:1b} as @a[tag=br.login_pending] at @s run function oa:lobby/login_warp

execute as @a[scores={oa.tpush=1..}] at @s run function oa:throwable/push/tick

execute as @a[tag=oa.gacha_affected] at @s run function oa:tayayuyu/tick

execute as @a[tag=oa.furo_fall] at @s run function oa:furoball/up_tick

execute if score #clock oa.beat matches 0 as @a[gamemode=!spectator,nbt=!{Health:0.0f}] at @s unless entity @s[tag=br.lobby_now,tag=!oa.debug] run function oa:visual/held_particles

execute as @a[tag=oa.taya_fall] at @s run function oa:tayayuyu/fall_tick

execute as @a[tag=oa.itori_effect] at @s run function oa:itori/effect_tick

execute as @a[tag=oa.itori_windup] at @s run function oa:itori/windup_tick

execute as @a[scores={oa.i_flins=1..}] at @s run function oa:itori/flins_tick
execute as @a[scores={oa.i_dive=1..}] at @s run function oa:itori/dive_tick
execute as @a[scores={oa.i_burn=1..}] at @s run function oa:itori/burn_tick

execute if score #perf oa.tmp matches 0 if score #state br.state matches 0 if score #state oa.map2 matches 3 run function oa:map/internal/repair_floating_chest with storage oa_map2:args

execute if score #perf oa.tmp matches 0 in oa:practice as @e[type=minecraft:zombie,tag=oa.practice_dummy,tag=!oa.practice_quiet,distance=0..] run function oa:practice/dummy_unname
