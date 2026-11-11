scoreboard players set #ready oa.map2 1
execute unless loaded ~-24 ~0 ~8 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-24 ~0 ~24 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-24 ~0 ~39 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-8 ~0 ~8 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-8 ~0 ~24 run scoreboard players set #ready oa.map2 0
execute unless loaded ~-8 ~0 ~39 run scoreboard players set #ready oa.map2 0
execute unless loaded ~7 ~0 ~8 run scoreboard players set #ready oa.map2 0
execute unless loaded ~7 ~0 ~24 run scoreboard players set #ready oa.map2 0
execute unless loaded ~7 ~0 ~39 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/delete/wait 2t replace
function oa:map/internal/delete/apply/54
