# 生成: scripts/build_map_sky.py（直接編集しない）。会場の生成完了後に呼ばれる（中央の開始地点・地点名。そのあと、まわりの島を置く）
data modify storage oa:spawn_points dim set value "oa:br_sky"
data modify storage oa:spawn_points points set value [{x:20.5d,y:81.0d,z:8.5d},{x:8.5d,y:81.0d,z:20.5d},{x:-8.5d,y:81.0d,z:20.5d},{x:-20.5d,y:81.0d,z:8.5d},{x:-20.5d,y:81.0d,z:-8.5d},{x:-8.5d,y:81.0d,z:-20.5d},{x:8.5d,y:81.0d,z:-20.5d},{x:20.5d,y:81.0d,z:-8.5d},{x:-21.5d,y:81.0d,z:-47.5d},{x:45.5d,y:81.0d,z:19.5d},{x:50.5d,y:81.0d,z:-19.5d},{x:-20.5d,y:81.0d,z:-38.5d},{x:-10.5d,y:81.0d,z:50.5d},{x:54.5d,y:81.0d,z:14.5d},{x:10.5d,y:81.0d,z:49.5d},{x:-58.5d,y:81.0d,z:1.5d},{x:-43.5d,y:81.0d,z:8.5d},{x:-2.5d,y:81.0d,z:44.5d}]
function oa:maps/sky/layout
function oa:maps/sky/isles/begin
