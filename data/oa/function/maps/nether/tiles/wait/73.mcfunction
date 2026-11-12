scoreboard players set #ready oa.map2 1
execute unless loaded ~-56 ~0 ~72 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-56 ~0 ~88 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-56 ~0 ~103 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-40 ~0 ~72 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-40 ~0 ~88 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-40 ~0 ~103 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-25 ~0 ~72 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-25 ~0 ~88 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-25 ~0 ~103 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/job/wait 2t replace
function oa:maps/nether/tiles/apply/73
