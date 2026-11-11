execute unless loaded ~ ~ ~ run return run kill @s
execute unless block ~ ~ ~ #oa:push_passable run return run kill @s
execute if score @s oa.i_range matches 40.. run return run kill @s
particle minecraft:dust{color:[0.65,0.12,0.95],scale:0.8} ~ ~ ~ 0.035 0.035 0.035 0 1 normal @a[distance=..24]
tag @e[tag=oa.i_bolt_target] remove oa.i_bolt_target
scoreboard players operation #team oa.team = @a[tag=oa.caster,limit=1] oa.team
execute positioned ~-0.125 ~-0.125 ~-0.125 as @a[tag=br.alive,tag=!oa.caster,tag=!br.pvp_grace,dx=0.25,dy=0.25,dz=0.25,gamemode=!spectator] unless score @s oa.team = #team oa.team run tag @s add oa.i_bolt_target
execute if score #team oa.team matches 0 positioned ~-0.125 ~-0.125 ~-0.125 as @a[tag=br.alive,tag=!oa.caster,tag=!br.pvp_grace,dx=0.25,dy=0.25,dz=0.25,gamemode=!spectator] run tag @s add oa.i_bolt_target
execute if entity @a[tag=oa.caster,tag=oa.db_free_match] positioned ~-0.125 ~-0.125 ~-0.125 as @e[tag=oa.debug_mob,dx=0.25,dy=0.25,dz=0.25] run tag @s add oa.i_bolt_target
execute if entity @e[tag=oa.i_bolt_target] run return run function oa:itori/bolt_hit
tp @s ^ ^ ^0.25
scoreboard players add @s oa.i_range 1
scoreboard players remove @s oa.i_sub 1
execute if score @s oa.i_sub matches 1.. at @s run function oa:itori/bolt_step
