scoreboard players add @s oa.hop 0
scoreboard players add @s oa.push 0
execute if score @s oa.hop matches 1.. run scoreboard players remove @s oa.hop 1
execute if score @s oa.hop matches 0 if entity @s[tag=oa.fish_hop] run function oa:status/end_hop
execute if score @s oa.push matches 1.. run scoreboard players remove @s oa.push 1
execute if score @s oa.hop matches 1.. at @s run function oa:status/hop_tick
execute if score @s oa.push matches 1.. run function oa:status/ensure
execute if entity @s[tag=oa.self_decoy] run function oa:status/ensure
execute if score @s oa.push matches 0 unless entity @s[tag=oa.self_decoy] run function oa:status/clear_carriers
