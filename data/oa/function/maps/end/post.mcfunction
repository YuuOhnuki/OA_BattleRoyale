# 生成: scripts/build_map_float.py end（直接編集しない）。会場の生成完了後に呼ばれる（開始地点の登録・地点名）
data modify storage oa:spawn_points dim set value "oa:br_end"
data modify storage oa:spawn_points points set value [{x:35.5d,y:82.0d,z:9.5d},{x:25.5d,y:81.0d,z:25.5d},{x:9.5d,y:81.0d,z:35.5d},{x:-9.5d,y:83.0d,z:35.5d},{x:-25.5d,y:81.0d,z:25.5d},{x:-35.5d,y:86.0d,z:9.5d},{x:-35.5d,y:81.0d,z:-9.5d},{x:-25.5d,y:81.0d,z:-25.5d},{x:-9.5d,y:84.0d,z:-35.5d},{x:9.5d,y:82.0d,z:-35.5d},{x:25.5d,y:81.0d,z:-25.5d},{x:35.5d,y:81.0d,z:-9.5d},{x:107.5d,y:81.0d,z:111.5d},{x:97.5d,y:81.0d,z:102.5d},{x:-101.5d,y:81.0d,z:111.5d},{x:-111.5d,y:81.0d,z:102.5d},{x:-101.5d,y:81.0d,z:-97.5d},{x:-111.5d,y:81.0d,z:-106.5d},{x:107.5d,y:81.0d,z:-97.5d},{x:97.5d,y:81.0d,z:-106.5d}]
execute if score #sv0 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:91.5d,y:81.0d,z:7.5d}
execute if score #sv0 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:88.5d,y:81.0d,z:-1.5d}
execute if score #sv0 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:84.5d,y:81.0d,z:7.5d}
execute if score #sv0 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:88.5d,y:81.0d,z:13.5d}
execute if score #sv0 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:77.5d,y:81.0d,z:7.5d}
execute if score #sv1 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:52.5d,y:81.0d,z:55.5d}
execute if score #sv1 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:52.5d,y:81.0d,z:64.5d}
execute if score #sv1 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:59.5d,y:81.0d,z:64.5d}
execute if score #sv1 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:60.5d,y:81.0d,z:52.5d}
execute if score #sv1 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:65.5d,y:81.0d,z:57.5d}
execute if score #sv2 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-16.5d,y:81.0d,z:91.5d}
execute if score #sv2 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:0.5d,y:81.0d,z:76.5d}
execute if score #sv2 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-7.5d,y:83.0d,z:99.5d}
execute if score #sv2 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:0.5d,y:81.0d,z:89.5d}
execute if score #sv2 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-8.5d,y:81.0d,z:72.5d}
execute if score #sv3 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-52.5d,y:81.0d,z:62.5d}
execute if score #sv3 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-60.5d,y:81.0d,z:65.5d}
execute if score #sv3 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-55.5d,y:82.0d,z:79.5d}
execute if score #sv3 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-56.5d,y:81.0d,z:57.5d}
execute if score #sv3 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-42.5d,y:81.0d,z:62.5d}
execute if score #sv4 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-71.5d,y:81.0d,z:-8.5d}
execute if score #sv4 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-75.5d,y:81.0d,z:-3.5d}
execute if score #sv4 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-76.5d,y:81.0d,z:-13.5d}
execute if score #sv4 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-71.5d,y:81.0d,z:3.5d}
execute if score #sv4 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-62.5d,y:81.0d,z:-9.5d}
execute if score #sv5 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-53.5d,y:81.0d,z:-47.5d}
execute if score #sv5 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-68.5d,y:81.0d,z:-59.5d}
execute if score #sv5 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-52.5d,y:81.0d,z:-59.5d}
execute if score #sv5 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-59.5d,y:81.0d,z:-52.5d}
execute if score #sv5 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-48.5d,y:81.0d,z:-53.5d}
execute if score #sv6 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:0.5d,y:81.0d,z:-87.5d}
execute if score #sv6 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:10.5d,y:81.0d,z:-79.5d}
execute if score #sv6 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:2.5d,y:81.0d,z:-68.5d}
execute if score #sv6 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:16.5d,y:81.0d,z:-83.5d}
execute if score #sv6 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:-4.5d,y:81.0d,z:-78.5d}
execute if score #sv7 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:53.5d,y:81.0d,z:-58.5d}
execute if score #sv7 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:58.5d,y:81.0d,z:-45.5d}
execute if score #sv7 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:43.5d,y:81.0d,z:-50.5d}
execute if score #sv7 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:51.5d,y:81.0d,z:-52.5d}
execute if score #sv7 oa.map2 matches 0 run data modify storage oa:spawn_points points append value {x:63.5d,y:81.0d,z:-56.5d}
function oa:maps/end/layout
execute store result score #sp_n oa.tmp run data get storage oa:spawn_points points
tellraw @a[tag=br.admin] [{text:"異界の会場の開始地点を",color:"green"},{score:{name:"#sp_n",objective:"oa.tmp"},color:"green"},{text:"か所登録しました。",color:"green"}]
