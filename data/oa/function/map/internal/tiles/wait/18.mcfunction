scoreboard players set #ready oa.map2 1
execute unless loaded ~104 ~0 ~-120 run scoreboard players set #ready oa.map2 0
execute unless loaded ~104 ~0 ~-104 run scoreboard players set #ready oa.map2 0
execute unless loaded ~104 ~0 ~-89 run scoreboard players set #ready oa.map2 0
execute unless loaded ~120 ~0 ~-120 run scoreboard players set #ready oa.map2 0
execute unless loaded ~120 ~0 ~-104 run scoreboard players set #ready oa.map2 0
execute unless loaded ~120 ~0 ~-89 run scoreboard players set #ready oa.map2 0
execute unless loaded ~135 ~0 ~-120 run scoreboard players set #ready oa.map2 0
execute unless loaded ~135 ~0 ~-104 run scoreboard players set #ready oa.map2 0
execute unless loaded ~135 ~0 ~-89 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/job/wait 2t replace
function oa:map/internal/tiles/apply/18
