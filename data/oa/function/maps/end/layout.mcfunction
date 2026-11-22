# 生成: scripts/build_map_float.py end（直接編集しない）。今の組み合わせの地点名を storage oa:maps layout.end に書く（地図・補給の場所名・プラグインが読む）
data modify storage oa:maps layout.end set value []
data modify storage oa:maps layout.end append value {x:0,z:0,name:"竜の祭壇"}
data modify storage oa:maps layout.end append value {x:104,z:104,name:"南東の浮岩"}
data modify storage oa:maps layout.end append value {x:-104,z:104,name:"南西の浮岩"}
data modify storage oa:maps layout.end append value {x:-104,z:-104,name:"北西の浮岩"}
data modify storage oa:maps layout.end append value {x:104,z:-104,name:"北東の浮岩"}
execute if score #sv0 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:84,z:7,name:"異界の塔街"}
execute if score #sv1 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:58,z:59,name:"コーラスの林"}
execute if score #sv2 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-3,z:82,name:"崩れたエンドシティ"}
execute if score #sv3 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-54,z:64,name:"異界の塔街"}
execute if score #sv4 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-76,z:-4,name:"結晶の洞窟"}
execute if score #sv5 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-54,z:-54,name:"コーラスの林"}
execute if score #sv6 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:2,z:-77,name:"異界の塔街"}
execute if score #sv7 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:57,z:-52,name:"黒曜石の森"}
data modify storage oa:maps spikes.end set value [{x:32,y:101,z:13},{x:15,y:113,z:35},{x:-13,y:107,z:32},{x:-35,y:117,z:15},{x:-32,y:103,z:-13},{x:-15,y:111,z:-35},{x:13,y:105,z:-32},{x:35,y:115,z:-15},{x:98,y:103,z:8},{x:69,y:101,z:54},{x:-63,y:101,z:75},{x:-51,y:108,z:-39},{x:2,y:106,z:-91},{x:59,y:108,z:-65}]
