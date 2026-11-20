gamemode adventure @s
tag @s add br.alive
execute if score @s tdm.team matches 1 run team join oa_tdm_red @s
execute if score @s tdm.team matches 2 run team join oa_tdm_blue @s
scoreboard players operation @s oa.team = @s tdm.team
scoreboard players set @s tdm.wait 0
scoreboard players set @s tdm.armor 0
function oa:tdm/armor/chain
function oa:tdm/equip
item replace entity @s hotbar.1 with minecraft:stone_sword[minecraft:unbreakable={}]
item replace entity @s hotbar.2 with minecraft:bow[minecraft:unbreakable={}]
item replace entity @s hotbar.8 with minecraft:arrow 10
scoreboard players set @s tdm.ui 0
effect give @s minecraft:instant_health 1 20 true
effect give @s minecraft:saturation 1 20 true
scoreboard players set @s tdm.guard 40
tag @s add br.pvp_grace
effect give @s minecraft:resistance 2 4 true
scoreboard players set @s tdm.food 0
execute at @s run function oa:tdm/fx/respawn
