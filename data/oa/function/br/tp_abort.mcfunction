tellraw @a[tag=br.admin] {text:"配置TPに失敗したため開始を中止し、所持品を復元します。",color:"red"}
function oa:br/finish
execute if score #map oa.mapid matches 0 in oa:br run kill @e[distance=0..,tag=br.spawn]
execute if score #map oa.mapid matches 1 in oa:br_nether run kill @e[distance=0..,tag=br.spawn]
execute if score #map oa.mapid matches 2 in oa:br_cave run kill @e[distance=0..,tag=br.spawn]
execute if score #map oa.mapid matches 3 in oa:br_sky run kill @e[distance=0..,tag=br.spawn]
execute if score #map oa.mapid matches 4 in oa:br_end run kill @e[distance=0..,tag=br.spawn]
