tag @s add br.ore
tag @s add oa_map2.registered
scoreboard players set @s br.ore 4
scoreboard players set @s br.regen 0
scoreboard players set @s br.round -1
execute if entity @s[tag=br.ore] if score @s br.ore matches 4 if score @s br.regen matches 0 run scoreboard players add #localo oa.map2 1
