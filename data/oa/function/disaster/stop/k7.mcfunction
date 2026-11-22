# 生成：scripts/gen_disasters.py（直接編集しない）
# 重力異常の終わり（ほかの災害の効果には触れない）
function oa:disaster/k7/end
scoreboard players set #ds7 br.tmp 0
execute if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"重力異常","color":"light_purple"},{"text":" が収まった","color":"green"}]
execute if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"重力異常","color":"light_purple"},{"text":" が収まった","color":"green"}]
execute if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"重力異常","color":"light_purple"},{"text":" が収まった","color":"green"}]
execute if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"重力異常","color":"light_purple"},{"text":" が収まった","color":"green"}]
execute if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"重力異常","color":"light_purple"},{"text":" が収まった","color":"green"}]
