# 生成: scripts/build_map_float.py end（直接編集しない）。今の組み合わせの地点名を storage oa:maps layout.end に書く（地図・補給の場所名・プラグインが読む）
data modify storage oa:maps layout.end set value []
data modify storage oa:maps layout.end append value {x:0,z:0,name:"異界神殿"}
data modify storage oa:maps layout.end append value {x:125,z:125,name:"北東の浮岩"}
data modify storage oa:maps layout.end append value {x:-125,z:125,name:"北西の浮岩"}
data modify storage oa:maps layout.end append value {x:-125,z:-125,name:"南西の浮岩"}
data modify storage oa:maps layout.end append value {x:125,z:-125,name:"南東の浮岩"}
execute if score #sv0 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:100,z:8,name:"黒曜石の森"}
execute if score #sv0 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:100,z:8,name:"廃墟の島"}
execute if score #sv0 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:100,z:8,name:"紫の草の島"}
execute if score #sv1 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:69,z:71,name:"黒曜石の森"}
execute if score #sv1 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:69,z:71,name:"エンドストーンの荒野"}
execute if score #sv1 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:69,z:71,name:"結晶の洞窟"}
execute if score #sv2 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-4,z:98,name:"廃墟の島"}
execute if score #sv2 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-4,z:98,name:"紫の草の島"}
execute if score #sv2 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-4,z:98,name:"エンドストーンの荒野"}
execute if score #sv3 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-64,z:76,name:"紫の草の島"}
execute if score #sv3 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-64,z:76,name:"廃墟の島"}
execute if score #sv3 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-64,z:76,name:"崩れたエンドシティ"}
execute if score #sv4 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-92,z:-5,name:"紫の草の島"}
execute if score #sv4 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-92,z:-5,name:"結晶の洞窟"}
execute if score #sv4 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-92,z:-5,name:"廃墟の島"}
execute if score #sv5 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-66,z:-65,name:"エンドストーンの荒野"}
execute if score #sv5 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-66,z:-65,name:"異界の塔"}
execute if score #sv5 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-66,z:-65,name:"廃墟の島"}
execute if score #sv6 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:2,z:-93,name:"廃墟の島"}
execute if score #sv6 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:2,z:-93,name:"紫の草の島"}
execute if score #sv6 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:2,z:-93,name:"異界の塔"}
execute if score #sv7 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:68,z:-63,name:"エンドストーンの荒野"}
execute if score #sv7 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:68,z:-63,name:"黒曜石の森"}
execute if score #sv7 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:68,z:-63,name:"崩れたエンドシティ"}
