scoreboard players add #delete_wait oa.map2 1
scoreboard players set #ready oa.map2 1
execute unless loaded ~72 ~0 ~72 run scoreboard players set #ready oa.map2 0
execute unless loaded ~72 ~0 ~88 run scoreboard players set #ready oa.map2 0
execute unless loaded ~72 ~0 ~103 run scoreboard players set #ready oa.map2 0
execute unless loaded ~88 ~0 ~72 run scoreboard players set #ready oa.map2 0
execute unless loaded ~88 ~0 ~88 run scoreboard players set #ready oa.map2 0
execute unless loaded ~88 ~0 ~103 run scoreboard players set #ready oa.map2 0
execute unless loaded ~103 ~0 ~72 run scoreboard players set #ready oa.map2 0
execute unless loaded ~103 ~0 ~88 run scoreboard players set #ready oa.map2 0
execute unless loaded ~103 ~0 ~103 run scoreboard players set #ready oa.map2 0
execute if score #ready oa.map2 matches 0 if score #delete_wait oa.map2 matches 300.. run return run function oa:map/internal/delete/failed
execute if score #ready oa.map2 matches 0 run return run schedule function oa:map/internal/delete/wait 2t replace
function oa:map/internal/delete/apply/77
