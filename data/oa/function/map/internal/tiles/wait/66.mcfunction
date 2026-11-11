scoreboard players set #ready oa.map2 1
execute unless loaded ~40 ~0 ~40 run scoreboard players set #ready oa.map2 0
execute unless loaded ~40 ~0 ~56 run scoreboard players set #ready oa.map2 0
execute unless loaded ~40 ~0 ~71 run scoreboard players set #ready oa.map2 0
execute unless loaded ~56 ~0 ~40 run scoreboard players set #ready oa.map2 0
execute unless loaded ~56 ~0 ~56 run scoreboard players set #ready oa.map2 0
execute unless loaded ~56 ~0 ~71 run scoreboard players set #ready oa.map2 0
execute unless loaded ~71 ~0 ~40 run scoreboard players set #ready oa.map2 0
execute unless loaded ~71 ~0 ~56 run scoreboard players set #ready oa.map2 0
execute unless loaded ~71 ~0 ~71 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/job/wait 2t replace
function oa:map/internal/tiles/apply/66
