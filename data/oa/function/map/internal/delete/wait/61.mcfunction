scoreboard players set #ready oa.map2 1
execute unless loaded ~-120 ~0 ~40 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-120 ~0 ~56 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-120 ~0 ~71 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-104 ~0 ~40 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-104 ~0 ~56 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-104 ~0 ~71 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-89 ~0 ~40 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-89 ~0 ~56 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-89 ~0 ~71 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/delete/wait 2t replace
function oa:map/internal/delete/apply/61
