scoreboard players set #ready oa.map2 1
execute unless loaded ~40 ~0 ~104 run scoreboard players set #ready oa.map2 0
execute unless loaded ~40 ~0 ~120 run scoreboard players set #ready oa.map2 0
execute unless loaded ~40 ~0 ~135 run scoreboard players set #ready oa.map2 0
execute unless loaded ~56 ~0 ~104 run scoreboard players set #ready oa.map2 0
execute unless loaded ~56 ~0 ~120 run scoreboard players set #ready oa.map2 0
execute unless loaded ~56 ~0 ~135 run scoreboard players set #ready oa.map2 0
execute unless loaded ~71 ~0 ~104 run scoreboard players set #ready oa.map2 0
execute unless loaded ~71 ~0 ~120 run scoreboard players set #ready oa.map2 0
execute unless loaded ~71 ~0 ~135 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/job/wait 2t replace
function oa:map/internal/tiles/apply/86
