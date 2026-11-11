tag @s remove br.gm_override
function oa:overwork/cleanup
function oa:hotchikisu/cleanup
execute if entity @s[tag=br.native_grace] run function oa:br/grace/restore_team
tag @s remove br.pvp_grace
tag @s remove br.mining_allowed
execute unless entity @s[tag=br.alive] run return 0
tag @s remove br.alive
execute if score #state br.state matches 1 if score #firstdead br.tmp matches 0 run function oa:ach/first_out
tag @s remove br.spawn_protection
function oa:status/reset
function oa:internal/cleanup
execute if entity @s[tag=oa.external_blind] run effect clear @s minecraft:blindness
execute if entity @s[tag=oa.external_slow] run effect clear @s minecraft:slowness
execute if entity @s[tag=oa.external_speed] run effect clear @s minecraft:speed
tag @s remove oa.external_blind
tag @s remove oa.external_slow
tag @s remove oa.external_speed
effect clear @s minecraft:resistance
scoreboard players operation @s br.surv = #time br.time
scoreboard players set @s oa.death 0
gamemode spectator @s
execute if entity @s[nbt={Health:0.0f}] run return 0
function oa:internal/tp with storage oa:br center
tellraw @a[tag=br.playing] [{selector:"@s"},{text:" が脱落しました",color:"red"}]

function oa:tayayuyu/clear

function oa:furoball/clear_up

function oa:itori/effects_end
