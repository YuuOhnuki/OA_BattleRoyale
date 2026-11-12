tag @s remove br.gm_override
function oa:overwork/cleanup
function oa:hotchikisu/cleanup
scoreboard players operation @s br.round = #round br.round
tag @s add br.playing
tag @s add br.alive
execute if entity @s[tag=oa.ambush_active] run function oa:yuttari/return
execute if entity @s[tag=oa.external_blind] run effect clear @s minecraft:blindness
execute if entity @s[tag=oa.external_speed] run effect clear @s minecraft:speed
execute if entity @s[tag=oa.external_slow] run effect clear @s minecraft:slowness
execute if entity @s[tag=br.spawn_protection] run effect clear @s minecraft:resistance
tag @s remove oa.external_blind
tag @s remove oa.external_speed
tag @s remove oa.external_slow
function oa:status/reset
function oa:internal/cleanup
function oa:br/clear_inventory
execute unless entity @s[tag=oa.player] run function oa:test/join
scoreboard players set @s oa.cd 0
scoreboard players set @s oa.death 0
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.kind -1
scoreboard players set @s oa.have 0
scoreboard players set @s oa.team 0
execute if score #mode br.mode matches 1 run scoreboard players operation @s oa.team = @s br.flag
team leave @s
execute if score #mode br.mode matches 1 if score @s oa.team matches 1 run team join oa_br1 @s
execute if score #mode br.mode matches 1 if score @s oa.team matches 2 run team join oa_br2 @s
execute if score #mode br.mode matches 1 if score @s oa.team matches 3 run team join oa_br3 @s
execute if score #mode br.mode matches 1 if score @s oa.team matches 4 run team join oa_br4 @s
execute if score #mode br.mode matches 1 if score @s oa.team matches 5 run team join oa_br5 @s
execute if score #mode br.mode matches 1 if score @s oa.team matches 6 run team join oa_br6 @s
execute if score #mode br.mode matches 1 if score @s oa.team matches 7 run team join oa_br7 @s
execute if score #mode br.mode matches 1 if score @s oa.team matches 8 run team join oa_br8 @s
execute if score #mode br.mode matches 1 if score @s oa.team matches 9 run team join oa_br9 @s
execute if score #mode br.mode matches 1 if score @s oa.team matches 10 run team join oa_br10 @s
gamemode adventure @s
effect give @s minecraft:instant_health 1 10 true
effect give @s minecraft:saturation 1 10 true
experience set @s 0 levels
experience set @s 0 points
scoreboard players operation @s br.left = @s oa.left
scoreboard players set @s br.tp_ok 0
execute store result storage oa:br_args id int 1 run scoreboard players get @s oa.id

effect give @s minecraft:resistance 61 4 true
tag @s add br.spawn_protection
tag @s add br.pvp_grace
give @s minecraft:iron_pickaxe[minecraft:custom_name={text:"資源採掘用ツルハシ",color:"aqua",italic:false},minecraft:custom_data={br_pick:1b},minecraft:unbreakable={},minecraft:can_break={blocks:"minecraft:barrier"}]
scoreboard players set @s br.mcoal 0
scoreboard players set @s br.mdcoal 0
scoreboard players set @s br.mred 0
scoreboard players set @s br.mqz 0
scoreboard players set @s br.mng 0
scoreboard players set @s br.mdred 0


tag @s remove br.login_pending
scoreboard players operation @s br.login_epoch = #epoch br.login_epoch
scoreboard players add @s br.login_leave 0
scoreboard players operation @s br.login_seen = @s br.login_leave

function oa:tayayuyu/clear

function oa:furoball/clear_up

execute unless score @s oa.i_round = #round br.round run function oa:itori/progress_reset
function oa:itori/effects_end
