scoreboard players set #ready oa.map2 1
execute unless loaded ~8 ~0 ~104 run scoreboard players set #ready oa.map2 0
execute unless loaded ~8 ~0 ~120 run scoreboard players set #ready oa.map2 0
execute unless loaded ~8 ~0 ~135 run scoreboard players set #ready oa.map2 0
execute unless loaded ~24 ~0 ~104 run scoreboard players set #ready oa.map2 0
execute unless loaded ~24 ~0 ~120 run scoreboard players set #ready oa.map2 0
execute unless loaded ~24 ~0 ~135 run scoreboard players set #ready oa.map2 0
execute unless loaded ~39 ~0 ~104 run scoreboard players set #ready oa.map2 0
execute unless loaded ~39 ~0 ~120 run scoreboard players set #ready oa.map2 0
execute unless loaded ~39 ~0 ~135 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/job/wait 2t replace
function oa:map/internal/tiles/apply/85
