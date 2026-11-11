# Two-tick native upward acceleration pulse, then ordinary gravity.
# No position teleport, no inventory carrier, no changes to the player's look.
execute if entity @s[gamemode=spectator] run return run function oa:status/end_hop
execute if entity @s[nbt={Health:0.0f}] run return run function oa:status/end_hop
execute if entity @s[tag=oa.hop_lift] run return run function oa:status/hop_pulse_tick
execute if data entity @s RootVehicle run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
execute if entity @s[tag=br.pvp_grace] run return 0
scoreboard players add @s oa.hoparc 0
execute if score @s oa.hoparc matches 1.. run return run scoreboard players remove @s oa.hoparc 1
execute unless entity @s[nbt={OnGround:1b}] run return 0
execute if data entity @s active_effects[{id:"minecraft:levitation"}] run return 0
execute unless block ~ ~1 ~ #minecraft:air run return 0
execute unless block ~ ~2 ~ #minecraft:air run return 0
execute if block ~ ~ ~ minecraft:water run return 0
execute if block ~ ~ ~ minecraft:lava run return 0
function oa:status/hop_launch
