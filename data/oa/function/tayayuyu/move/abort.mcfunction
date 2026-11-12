execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,type=minecraft:marker,tag=oa.g_move_plan]
tellraw @a[tag=br.playing] {text:"移動対象または転送先を取得できなかったため、今回の移動は中止しました。",color:"yellow"}
