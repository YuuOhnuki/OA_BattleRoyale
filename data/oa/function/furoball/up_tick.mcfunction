execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=oa.debug_mob] unless entity @s[tag=br.alive,gamemode=!spectator,nbt=!{Health:0.0f}] run return run function oa:furoball/clear_up
execute unless entity @s[tag=oa.db_free_match] unless score #state br.state matches 1 run return run function oa:furoball/clear_up
scoreboard players add @s oa.fage 1
execute if entity @s[tag=oa.furo_ascent] if score @s oa.fage matches 2.. store result score #f_vy oa.tmp run data get entity @s Motion[1] 1000
execute if entity @s[tag=oa.furo_ascent] if score @s oa.fage matches 2.. if score #f_vy oa.tmp matches ..0 run function oa:furoball/end_ascent
# Do not remove protection while the player is using this item's own carrier.
execute on vehicle if entity @s[type=minecraft:armor_stand,tag=oa.furo_carrier] run return 0
execute if entity @s[nbt={OnGround:0b}] run scoreboard players set @s oa.fair 1
# The next tick after landing removes only this item's own fall modifier.
execute if score @s oa.fage matches 4.. if score @s oa.fair matches 1 if entity @s[nbt={OnGround:1b}] run return run function oa:furoball/clear_up
# A blocked launch that never left the floor must not retain immunity indefinitely.
execute if score @s oa.fage matches 20.. if score @s oa.fair matches 0 if entity @s[nbt={OnGround:1b}] run return run function oa:furoball/clear_up
execute if score @s oa.fage matches 4.. if block ~ ~ ~ minecraft:water run return run function oa:furoball/clear_up
execute if score @s oa.fage matches 4.. if block ~ ~ ~ minecraft:lava run return run function oa:furoball/clear_up
execute if score @s oa.fage matches 4.. if data entity @s RootVehicle run return run function oa:furoball/clear_up
