attribute @s minecraft:attack_damage modifier remove oa:xilonen_damage
function oa:itori/windup_cancel
scoreboard players operation @s oa.i_round = #round br.round
scoreboard players set @s oa.i_uses 0
scoreboard players set @s oa.i_unlock 1
scoreboard players set @s oa.i_next 1
scoreboard players set @s oa.i_cycle 1
scoreboard players set @s oa.i_lock 0
scoreboard players set @s oa.i_charge 0
scoreboard players set @s oa.i_ver 1932
scoreboard players set @s oa.i_held 0
scoreboard players set @s oa.i_flins 0
scoreboard players set @s oa.i_dive 0
scoreboard players set @s oa.i_burn 0
scoreboard players set @s oa.i_ore 0
scoreboard players set @s oa.i_chest 0
scoreboard players set @s oa.i_points 0
