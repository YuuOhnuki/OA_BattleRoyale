# 生成: scripts/build_map_sky.py（直接編集しない）
execute store result score #ps oa.map2 run random value 0..9
execute if score #ps oa.map2 matches 0 unless score #sk0 oa.map2 matches -1 run return run function oa:maps/sky/isles/pick_site
execute if score #ps oa.map2 matches 1 unless score #sk1 oa.map2 matches -1 run return run function oa:maps/sky/isles/pick_site
execute if score #ps oa.map2 matches 2 unless score #sk2 oa.map2 matches -1 run return run function oa:maps/sky/isles/pick_site
execute if score #ps oa.map2 matches 3 unless score #sk3 oa.map2 matches -1 run return run function oa:maps/sky/isles/pick_site
execute if score #ps oa.map2 matches 4 unless score #sk4 oa.map2 matches -1 run return run function oa:maps/sky/isles/pick_site
execute if score #ps oa.map2 matches 5 unless score #sk5 oa.map2 matches -1 run return run function oa:maps/sky/isles/pick_site
execute if score #ps oa.map2 matches 6 unless score #sk6 oa.map2 matches -1 run return run function oa:maps/sky/isles/pick_site
execute if score #ps oa.map2 matches 7 unless score #sk7 oa.map2 matches -1 run return run function oa:maps/sky/isles/pick_site
execute if score #ps oa.map2 matches 8 unless score #sk8 oa.map2 matches -1 run return run function oa:maps/sky/isles/pick_site
execute if score #ps oa.map2 matches 9 unless score #sk9 oa.map2 matches -1 run return run function oa:maps/sky/isles/pick_site
