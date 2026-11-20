attribute @s minecraft:movement_speed modifier remove oa:tdm_start
function oa:br/clear_match_effects
function oa:overwork/cleanup
function oa:hotchikisu/cleanup
function oa:status/reset
function oa:internal/cleanup
function oa:itori/effects_end
function oa:itori/windup_cancel
effect clear @s
scoreboard players set @s tdm.food 0
scoreboard players set @s tdm.heal 0
tag @s remove tdm.swap_latched
scoreboard players set @s oa.death 0
scoreboard players set @s oa.cd 0
scoreboard players set @s oa.i_lock 0
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.kind -1
scoreboard players set @s oa.have 0
tag @s remove br.spawn_protection
tag @s remove br.pvp_grace
