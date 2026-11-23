# 生成: scripts/build_map_float.py end（直接編集しない）。今の組み合わせの地点名を storage oa:maps layout.end に書く（地図・補給の場所名・プラグインが読む）
data modify storage oa:maps layout.end set value []
data modify storage oa:maps layout.end append value {x:0,z:0,name:"竜の祭壇"}
data modify storage oa:maps layout.end append value {x:104,z:104,name:"南東の浮岩"}
data modify storage oa:maps layout.end append value {x:-104,z:104,name:"南西の浮岩"}
data modify storage oa:maps layout.end append value {x:-104,z:-104,name:"北西の浮岩"}
data modify storage oa:maps layout.end append value {x:104,z:-104,name:"北東の浮岩"}
execute if score #sv0 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:84,z:7,name:"真珠の遺跡"}
execute if score #sv0 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:84,z:7,name:"崩れたエンドシティ"}
execute if score #sv0 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:84,z:7,name:"空間の裂け目"}
execute if score #sv1 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:58,z:59,name:"黒曜石の森"}
execute if score #sv1 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:58,z:59,name:"ガラスのドーム"}
execute if score #sv1 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:58,z:59,name:"白い尖塔"}
execute if score #sv2 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-3,z:82,name:"浮遊遺跡"}
execute if score #sv2 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-3,z:82,name:"地底回廊"}
execute if score #sv2 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-3,z:82,name:"真珠の遺跡"}
execute if score #sv3 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-54,z:64,name:"古代聖堂"}
execute if score #sv3 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-54,z:64,name:"コーラスの林"}
execute if score #sv3 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-54,z:64,name:"黒曜石の森"}
execute if score #sv4 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-76,z:-4,name:"塔街"}
execute if score #sv4 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-76,z:-4,name:"エンドの塔"}
execute if score #sv4 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-76,z:-4,name:"浮遊遺跡"}
execute if score #sv5 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:-54,z:-54,name:"記憶の書庫"}
execute if score #sv5 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:-54,z:-54,name:"結晶の洞窟"}
execute if score #sv5 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:-54,z:-54,name:"古代聖堂"}
execute if score #sv6 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:2,z:-77,name:"荒野"}
execute if score #sv6 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:2,z:-77,name:"結晶庭園"}
execute if score #sv6 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:2,z:-77,name:"塔街"}
execute if score #sv7 oa.map2 matches 0 run data modify storage oa:maps layout.end append value {x:57,z:-52,name:"崩れたエンドシティ"}
execute if score #sv7 oa.map2 matches 1 run data modify storage oa:maps layout.end append value {x:57,z:-52,name:"空間の裂け目"}
execute if score #sv7 oa.map2 matches 2 run data modify storage oa:maps layout.end append value {x:57,z:-52,name:"記憶の書庫"}
data modify storage oa:maps spikes.end set value [{x:32,y:101,z:13},{x:15,y:113,z:35},{x:-13,y:107,z:32},{x:-35,y:117,z:15},{x:-32,y:103,z:-13},{x:-15,y:111,z:-35},{x:13,y:105,z:-32},{x:35,y:115,z:-15},{x:73,y:102,z:54},{x:-64,y:102,z:57},{x:-56,y:105,z:77},{x:-90,y:105,z:-5},{x:2,y:104,z:-91}]
