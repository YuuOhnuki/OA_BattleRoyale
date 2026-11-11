scoreboard players set #ready oa.map2 1
execute unless loaded ~-152 ~0 ~-24 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-152 ~0 ~-8 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-152 ~0 ~7 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-136 ~0 ~-24 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-136 ~0 ~-8 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-136 ~0 ~7 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-121 ~0 ~-24 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-121 ~0 ~-8 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-121 ~0 ~7 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/job/wait 2t replace
function oa:map/internal/tiles/apply/40
