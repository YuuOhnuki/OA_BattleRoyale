execute unless score @s oa.mark matches 1.. run return 0
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:nero/load_owned with storage oa:args
execute unless data storage oa:position value.dim run return 0
execute if score #state br.state matches 1 run function oa:br/border/check_saved
execute if score #state br.state matches 1 if score #inside br.flag matches 0 run return run function oa:nero/border_reject
function oa:nero/teleport_out
# Prefer actual armor stand; checkpoint is fallback if it is in an unloaded chunk.
scoreboard players set #moved oa.tmp 0
function oa:nero/return_live with storage oa:args
execute if score #moved oa.tmp matches 0 run function oa:internal/tp with storage oa:position value
execute at @s run function oa:nero/teleport_in
scoreboard players set @s oa.mark 0
scoreboard players set @s oa.cd 200
function oa:nero/clear_mark with storage oa:args
