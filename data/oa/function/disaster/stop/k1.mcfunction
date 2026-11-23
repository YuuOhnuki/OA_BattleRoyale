# 生成：scripts/gen_disasters.py（直接編集しない）
# 酸性雨の終わり（ほかの災害の効果には触れない）
function oa:disaster/k1/end
scoreboard players set #ds1 br.tmp 0
execute if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"酸性雨"},{"text":" が収まった"}]
