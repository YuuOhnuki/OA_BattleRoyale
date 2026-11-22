# 生成: scripts/build_map_float.py sky（直接編集しない）。今の組み合わせの地点名を storage oa:maps layout.sky に書く（地図・補給の場所名・プラグインが読む）
data modify storage oa:maps layout.sky set value []
data modify storage oa:maps layout.sky append value {x:0,z:0,name:"天空城"}
data modify storage oa:maps layout.sky append value {x:126,z:126,name:"南東の小島"}
data modify storage oa:maps layout.sky append value {x:-126,z:126,name:"南西の小島"}
data modify storage oa:maps layout.sky append value {x:-126,z:-126,name:"北西の小島"}
data modify storage oa:maps layout.sky append value {x:126,z:-126,name:"北東の小島"}
execute if score #sv0 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:95,z:-8,name:"神殿の島"}
execute if score #sv0 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:95,z:-8,name:"廃墟の島"}
execute if score #sv0 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:95,z:-8,name:"見張り塔の島"}
execute if score #sv1 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:67,z:72,name:"庭園の島"}
execute if score #sv1 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:67,z:72,name:"飛行船の発着場"}
execute if score #sv1 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:67,z:72,name:"集落の島"}
execute if score #sv2 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:-6,z:93,name:"屋敷の島"}
execute if score #sv2 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:-6,z:93,name:"市場の島"}
execute if score #sv2 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:-6,z:93,name:"飛行船の発着場"}
execute if score #sv3 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:-74,z:71,name:"集落の島"}
execute if score #sv3 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:-74,z:71,name:"屋敷の島"}
execute if score #sv3 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:-74,z:71,name:"森林の島"}
execute if score #sv4 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:-93,z:-8,name:"神殿の島"}
execute if score #sv4 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:-93,z:-8,name:"飛行船の発着場"}
execute if score #sv4 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:-93,z:-8,name:"庭園の島"}
execute if score #sv5 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:-73,z:-63,name:"神殿の島"}
execute if score #sv5 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:-73,z:-63,name:"市場の島"}
execute if score #sv5 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:-73,z:-63,name:"庭園の島"}
execute if score #sv6 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:7,z:-94,name:"森林の島"}
execute if score #sv6 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:7,z:-94,name:"庭園の島"}
execute if score #sv6 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:7,z:-94,name:"市場の島"}
execute if score #sv7 oa.map2 matches 0 run data modify storage oa:maps layout.sky append value {x:64,z:-70,name:"庭園の島"}
execute if score #sv7 oa.map2 matches 1 run data modify storage oa:maps layout.sky append value {x:64,z:-70,name:"廃墟の島"}
execute if score #sv7 oa.map2 matches 2 run data modify storage oa:maps layout.sky append value {x:64,z:-70,name:"市場の島"}
