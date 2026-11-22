# 生成: scripts/build_map_float.py end（直接編集しない）。今の組み合わせの地点名を storage oa:maps layout.end に書く（地図・補給の場所名・プラグインが読む）
data modify storage oa:maps layout.end set value []
data modify storage oa:maps layout.end append value {x:0,z:0,name:"異界神殿"}
data modify storage oa:maps layout.end append value {x:126,z:126,name:"南東の浮岩"}
data modify storage oa:maps layout.end append value {x:-126,z:126,name:"南西の浮岩"}
data modify storage oa:maps layout.end append value {x:-126,z:-126,name:"北西の浮岩"}
data modify storage oa:maps layout.end append value {x:126,z:-126,name:"北東の浮岩"}
execute if score #sv0 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:102,z:8,name:"コーラスの林"}
execute if score #sv0 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:102,z:8,name:"白い尖塔"}
execute if score #sv0 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:102,z:8,name:"異界の塔"}
execute if score #sv1 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:70,z:72,name:"エンドストーンの荒野"}
execute if score #sv1 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:70,z:72,name:"ガラスのドーム"}
execute if score #sv1 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:70,z:72,name:"異界の塔"}
execute if score #sv2 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-4,z:100,name:"結晶の洞窟"}
execute if score #sv2 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-4,z:100,name:"廃墟の島"}
execute if score #sv2 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-4,z:100,name:"ガラスのドーム"}
execute if score #sv3 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-66,z:78,name:"エンドストーンの荒野"}
execute if score #sv3 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-66,z:78,name:"崩れたエンドシティ"}
execute if score #sv3 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-66,z:78,name:"コーラスの林"}
execute if score #sv4 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-94,z:-6,name:"エンドストーンの荒野"}
execute if score #sv4 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-94,z:-6,name:"白い尖塔"}
execute if score #sv4 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-94,z:-6,name:"コーラスの林"}
execute if score #sv5 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-67,z:-66,name:"結晶の洞窟"}
execute if score #sv5 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-67,z:-66,name:"コーラスの林"}
execute if score #sv5 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-67,z:-66,name:"黒曜石の森"}
execute if score #sv6 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:2,z:-95,name:"コーラスの林"}
execute if score #sv6 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:2,z:-95,name:"エンドストーンの荒野"}
execute if score #sv6 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:2,z:-95,name:"結晶の洞窟"}
execute if score #sv7 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:70,z:-64,name:"エンドストーンの荒野"}
execute if score #sv7 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:70,z:-64,name:"廃墟の島"}
execute if score #sv7 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:70,z:-64,name:"黒曜石の森"}
