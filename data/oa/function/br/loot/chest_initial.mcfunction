function oa:br/loot/reset_open
execute if score #time br.time matches 7200.. run return run function oa:br/loot/chest_initial_late
function oa:br/loot/drop_chest
execute if score #chest_ok br.flag matches 0 run return 0
loot replace block ~ ~ ~ container.0 27 loot oa:br/chest_basic
scoreboard players operation @s br.round = #round br.round
scoreboard players set @s br.cstage 0
function oa:br/loot/chest_rare
execute unless items block ~ ~ ~ container.* * run item replace block ~ ~ ~ container.0 with minecraft:bread 1
