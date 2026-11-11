scoreboard players operation #signed br.tmp = #inset br.tmp
execute store result storage oa:br_fx inset double 0.001 run scoreboard players get #signed br.tmp
scoreboard players operation #sample br.z = #pz br.z
scoreboard players remove #sample br.z 64000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~-64 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players remove #sample br.z 56000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~-56 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players remove #sample br.z 48000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~-48 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players remove #sample br.z 40000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~-40 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players remove #sample br.z 32000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~-32 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players remove #sample br.z 24000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~-24 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players remove #sample br.z 16000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~-16 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players remove #sample br.z 8000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~-8 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players add #sample br.z 0
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~0 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players add #sample br.z 8000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~8 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players add #sample br.z 16000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~16 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players add #sample br.z 24000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~24 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players add #sample br.z 32000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~32 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players add #sample br.z 40000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~40 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players add #sample br.z 48000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~48 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players add #sample br.z 56000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~56 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #sample br.z = #pz br.z
scoreboard players add #sample br.z 64000
$execute if score #sample br.z >= #minz br.z if score #sample br.z <= #maxz br.z positioned $(minx) $(y) $(z) positioned ~ ~ ~64 run function oa:br/zone/column_minx with storage oa:br_fx
scoreboard players operation #delta br.tmp = #cz br.z
scoreboard players operation #delta br.tmp -= #pz br.z
$execute if score #delta br.tmp matches -64000..64000 positioned $(minx) $(y) $(cz) run function oa:br/zone/column_minx with storage oa:br_fx
