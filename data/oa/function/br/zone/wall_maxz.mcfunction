scoreboard players operation #signed br.tmp = #inset br.tmp
scoreboard players operation #signed br.tmp *= #minus1 br.tmp
execute store result storage oa:br_fx inset double 0.001 run scoreboard players get #signed br.tmp
scoreboard players operation #sample br.x = #px br.x
scoreboard players remove #sample br.x 64000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~-64 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players remove #sample br.x 56000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~-56 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players remove #sample br.x 48000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~-48 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players remove #sample br.x 40000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~-40 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players remove #sample br.x 32000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~-32 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players remove #sample br.x 24000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~-24 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players remove #sample br.x 16000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~-16 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players remove #sample br.x 8000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~-8 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players add #sample br.x 0
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~0 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players add #sample br.x 8000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~8 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players add #sample br.x 16000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~16 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players add #sample br.x 24000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~24 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players add #sample br.x 32000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~32 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players add #sample br.x 40000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~40 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players add #sample br.x 48000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~48 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players add #sample br.x 56000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~56 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #sample br.x = #px br.x
scoreboard players add #sample br.x 64000
$execute if score #sample br.x >= #minx br.x if score #sample br.x <= #maxx br.x positioned $(x) $(y) $(maxz) positioned ~64 ~ ~ run function oa:br/zone/column_maxz with storage oa:br_fx
scoreboard players operation #delta br.tmp = #cx br.x
scoreboard players operation #delta br.tmp -= #px br.x
$execute if score #delta br.tmp matches -64000..64000 positioned $(cx) $(y) $(maxz) run function oa:br/zone/column_maxz with storage oa:br_fx
