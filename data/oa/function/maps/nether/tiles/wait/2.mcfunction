scoreboard players set #ready oa.map2 1
execute unless loaded ~-88 ~0 ~-152 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-88 ~0 ~-136 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-88 ~0 ~-121 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-72 ~0 ~-152 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-72 ~0 ~-136 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-72 ~0 ~-121 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-57 ~0 ~-152 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-57 ~0 ~-136 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-57 ~0 ~-121 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/job/wait 2t replace
function oa:maps/nether/tiles/apply/2
