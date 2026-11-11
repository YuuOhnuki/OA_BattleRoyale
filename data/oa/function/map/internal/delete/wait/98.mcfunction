scoreboard players set #ready oa.map2 1
execute unless loaded ~104 ~0 ~136 run scoreboard players set #ready oa.map2 0
execute unless loaded ~104 ~0 ~152 run scoreboard players set #ready oa.map2 0
execute unless loaded ~120 ~0 ~136 run scoreboard players set #ready oa.map2 0
execute unless loaded ~120 ~0 ~152 run scoreboard players set #ready oa.map2 0
execute unless loaded ~135 ~0 ~136 run scoreboard players set #ready oa.map2 0
execute unless loaded ~135 ~0 ~152 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/delete/wait 2t replace
function oa:map/internal/delete/apply/98
