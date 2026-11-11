function oa:br/loot/reset_open
function oa:br/loot/drop_chest
execute if score #chest_ok br.flag matches 0 run return 0
loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_upgraded
scoreboard players operation @s br.round = #round br.round
scoreboard players set @s br.cstage 1
function oa:br/loot/chest_rare
execute unless items block ~ ~ ~ container.* * run item replace block ~ ~ ~ container.0 with minecraft:bread 1
