# 生成：scripts/gen_disasters.py（直接編集しない）
# 塔の砲撃の終わり（ほかの災害の効果には触れない）
function oa:disaster/k12/end
scoreboard players set #ds12 br.tmp 0
execute if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"塔の砲撃","color":"dark_purple"},{"text":" が収まった","color":"green"}]
