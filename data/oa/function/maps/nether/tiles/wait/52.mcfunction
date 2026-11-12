scoreboard players set #ready oa.map2 1
execute unless loaded ~-88 ~0 ~8 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-88 ~0 ~24 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-88 ~0 ~39 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-72 ~0 ~8 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-72 ~0 ~24 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-72 ~0 ~39 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-57 ~0 ~8 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-57 ~0 ~24 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-57 ~0 ~39 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/job/wait 2t replace
function oa:maps/nether/tiles/apply/52
