# 生成: scripts/build_map_float.py sky（直接編集しない）。今の組み合わせの地点名を storage oa:maps layout.sky に書く（地図・補給の場所名・プラグインが読む）
data modify storage oa:maps layout.sky set value []
data modify storage oa:maps layout.sky append value {x:0,z:0,name:"天空城"}
data modify storage oa:maps layout.sky append value {x:125,z:125,name:"北東の小島"}
data modify storage oa:maps layout.sky append value {x:-125,z:125,name:"北西の小島"}
data modify storage oa:maps layout.sky append value {x:-125,z:-125,name:"南西の小島"}
data modify storage oa:maps layout.sky append value {x:125,z:-125,name:"南東の小島"}
execute if score #sv0 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:93,z:-7,name:"崩れた岩の島"}
execute if score #sv0 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:93,z:-7,name:"見張り塔の島"}
execute if score #sv0 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:93,z:-7,name:"庭園の島"}
execute if score #sv1 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:65,z:71,name:"崩れた岩の島"}
execute if score #sv1 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:65,z:71,name:"集落の島"}
execute if score #sv1 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:65,z:71,name:"庭園の島"}
execute if score #sv2 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:-6,z:91,name:"庭園の島"}
execute if score #sv2 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:-6,z:91,name:"集落の島"}
execute if score #sv2 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:-6,z:91,name:"見張り塔の島"}
execute if score #sv3 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:-73,z:69,name:"廃墟の島"}
execute if score #sv3 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:-73,z:69,name:"集落の島"}
execute if score #sv3 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:-73,z:69,name:"見張り塔の島"}
execute if score #sv4 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:-91,z:-8,name:"廃墟の島"}
execute if score #sv4 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:-91,z:-8,name:"崩れた岩の島"}
execute if score #sv4 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:-91,z:-8,name:"神殿の島"}
execute if score #sv5 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:-72,z:-62,name:"神殿の島"}
execute if score #sv5 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:-72,z:-62,name:"見張り塔の島"}
execute if score #sv5 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:-72,z:-62,name:"集落の島"}
execute if score #sv6 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:7,z:-92,name:"見張り塔の島"}
execute if score #sv6 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:7,z:-92,name:"神殿の島"}
execute if score #sv6 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:7,z:-92,name:"集落の島"}
execute if score #sv7 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:63,z:-68,name:"庭園の島"}
execute if score #sv7 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:63,z:-68,name:"森林の島"}
execute if score #sv7 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:63,z:-68,name:"神殿の島"}
