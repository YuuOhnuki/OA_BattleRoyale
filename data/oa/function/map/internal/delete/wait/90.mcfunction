scoreboard players set #ready oa.map2 1
execute unless loaded ~-152 ~0 ~136 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-152 ~0 ~152 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-136 ~0 ~136 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-136 ~0 ~152 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-121 ~0 ~136 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-121 ~0 ~152 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/delete/wait 2t replace
function oa:map/internal/delete/apply/90
