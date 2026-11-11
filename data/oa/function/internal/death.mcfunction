function oa:tayayuyu/clear
function oa:overwork/cleanup
function oa:hotchikisu/cleanup
execute if entity @s[tag=br.playing] run return run function oa:br/eliminate
execute if entity @s[tag=oa.external_blind] run effect clear @s minecraft:blindness
tag @s remove oa.external_blind
function oa:nero/decoy_release
function oa:status/reset
function oa:internal/cleanup
execute if entity @s[tag=oa.external_slow] run effect clear @s minecraft:slowness
execute if entity @s[tag=oa.external_speed] run effect clear @s minecraft:speed
tag @s remove oa.external_slow
tag @s remove oa.external_speed
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.kind 0
scoreboard players set @s oa.death 0
gamemode spectator @s
advancement revoke @s only oa:yuua/struck
tag @s remove oa.hat_victim
tag @s remove oa.routed_damage

function oa:furoball/clear_up

function oa:tayayuyu/fall_clear

function oa:itori/effects_end
