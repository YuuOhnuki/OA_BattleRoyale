tag @s add br.chest
tag @s add oa_map2.registered
scoreboard players set @s br.round -1
scoreboard players set @s br.cstage 0
execute if entity @s[tag=br.chest] if score @s br.round matches -1 if score @s br.cstage matches 0 run scoreboard players add #localc oa.map2 1
