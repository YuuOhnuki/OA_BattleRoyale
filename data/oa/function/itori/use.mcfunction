execute unless score @s oa.kind matches 10 run return 0
execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:10}}] run return 0
execute if entity @s[tag=oa.gacha_exposed] run return 0
execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=br.alive,gamemode=!spectator] run return 0
execute unless entity @s[tag=oa.db_free_match] unless score #state br.state matches 1 run return 0
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return run function oa:combat/protection_notice
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
execute if score @s oa.i_lock matches 1.. run return 0
execute if entity @s[tag=oa.itori_windup] run return 0
function oa:itori/progress
execute if score @s oa.i_next matches 1 run scoreboard players operation @s oa.i_cycle = @s oa.i_unlock
scoreboard players operation @s oa.i_pending = @s oa.i_next
execute unless score @s oa.i_pending matches 6 run return run function oa:itori/release
scoreboard players operation @s oa.i_castround = #round br.round
execute store result score @s oa.i_casttime run time query gametime
tag @s add oa.itori_windup
execute unless entity @s[nbt={active_effects:[{id:"minecraft:slowness"}]}] run tag @s add oa.itori_charge_slow
effect give @s minecraft:slowness 1 3 true
swing @s mainhand whack 15t
playsound minecraft:block.beacon.power_select player @a[distance=..28] ~ ~ ~ 0.6 0.7
playsound minecraft:block.amethyst_block.resonate player @a[distance=..28] ~ ~ ~ 0.7 0.7
execute store result storage oa:itori id int 1 run scoreboard players get @s oa.id
function oa:itori/windup_spawn with storage oa:itori
playsound minecraft:entity.warden.heartbeat player @a[distance=..28] ~ ~ ~ 1.0 0.8
