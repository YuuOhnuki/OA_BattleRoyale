# 生成: scripts/build_map_sky.py（直接編集しない）。会場の生成完了後に呼ばれる（中央の開始地点・地点名。そのあと、まわりの島を置く）
data modify storage oa:spawn_points dim set value "oa:br_sky"
data modify storage oa:spawn_points points set value [{x:20.5d,y:81.0d,z:8.5d},{x:8.5d,y:81.0d,z:20.5d},{x:-8.5d,y:81.0d,z:20.5d},{x:-20.5d,y:81.0d,z:8.5d},{x:-20.5d,y:81.0d,z:-8.5d},{x:-8.5d,y:81.0d,z:-20.5d},{x:8.5d,y:81.0d,z:-20.5d},{x:20.5d,y:81.0d,z:-8.5d},{x:49.5d,y:81.0d,z:17.5d},{x:-21.5d,y:81.0d,z:-47.5d},{x:-40.5d,y:81.0d,z:28.5d},{x:5.5d,y:81.0d,z:55.5d},{x:50.5d,y:81.0d,z:-19.5d},{x:40.5d,y:81.0d,z:21.5d},{x:-20.5d,y:81.0d,z:-38.5d},{x:-10.5d,y:81.0d,z:50.5d},{x:-5.5d,y:81.0d,z:-57.5d},{x:55.5d,y:81.0d,z:14.5d}]
function oa:maps/sky/layout
function oa:maps/sky/isles/begin
