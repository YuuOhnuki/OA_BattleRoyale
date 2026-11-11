execute unless score @s oa.pending matches 1..5 run return 0
execute unless score @s oa.left = @s oa.qleft run return run scoreboard players set @s oa.pending 0
execute if entity @s[nbt={Health:0.0f}] run return 0
execute if score #state br.state matches 2 run return 0
execute if score #state br.state matches 0 if score @s br.saved matches 1 run return 0
scoreboard players operation #control_do oa.tmp = @s oa.pending
scoreboard players set @s oa.pending 0
tag @a remove oa.roster_actor
scoreboard players operation #control_by oa.tmp = @s oa.qby
execute as @a if score @s oa.id = #control_by oa.tmp run tag @s add oa.roster_actor
execute if score #control_do oa.tmp matches 1 run function oa:admin/control/survival
execute if score #control_do oa.tmp matches 2 run function oa:admin/control/adventure
execute if score #control_do oa.tmp matches 3 run function oa:admin/control/creative
execute if score #control_do oa.tmp matches 4 run function oa:admin/control/spectator
execute if score #control_do oa.tmp matches 5 run function oa:admin/control/revive
tag @a remove oa.roster_actor
