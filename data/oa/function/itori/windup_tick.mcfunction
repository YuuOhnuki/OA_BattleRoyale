execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:10}}] run return run function oa:itori/windup_cancel
execute unless score @s oa.i_castround = #round br.round run return run function oa:itori/windup_cancel
execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=br.alive,gamemode=!spectator] run return run function oa:itori/windup_cancel
execute unless entity @s[tag=oa.db_free_match] unless score #state br.state matches 1 run return run function oa:itori/windup_cancel
execute if entity @s[tag=oa.gacha_exposed] run return run function oa:itori/windup_cancel
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return run function oa:itori/windup_cancel
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return run function oa:itori/windup_cancel
execute store result score #i_elapsed oa.tmp run time query gametime
scoreboard players operation #i_elapsed oa.tmp -= @s oa.i_casttime
execute if score #i_elapsed oa.tmp matches 11.. run return run function oa:itori/release
execute store result storage oa:itori id int 1 run scoreboard players get @s oa.id
function oa:itori/windup_follow with storage oa:itori
execute if score #i_elapsed oa.tmp matches 0 run function oa:itori/fx/windup_ring
execute if score #i_elapsed oa.tmp matches 4 run function oa:itori/fx/windup_ring
execute if score #i_elapsed oa.tmp matches 7 run function oa:itori/fx/windup_ring
execute if score #i_elapsed oa.tmp matches 10 run function oa:itori/fx/windup_ring
execute if score #i_elapsed oa.tmp matches 4 run playsound minecraft:block.amethyst_block.chime player @a[distance=..28] ~ ~ ~ 0.7 1.0
execute if score #i_elapsed oa.tmp matches 7 run playsound minecraft:block.amethyst_block.chime player @a[distance=..28] ~ ~ ~ 0.8 1.35
execute if score #i_elapsed oa.tmp matches 10 run playsound minecraft:block.amethyst_block.chime player @a[distance=..28] ~ ~ ~ 0.9 1.7
