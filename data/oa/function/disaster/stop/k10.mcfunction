# 生成：scripts/gen_disasters.py（直接編集しない）
# 竜巻の終わり（ほかの災害の効果には触れない）
function oa:disaster/k10/end
scoreboard players set #ds10 br.tmp 0
execute if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"竜巻","color":"white"},{"text":" が収まった","color":"green"}]
execute if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"竜巻","color":"white"},{"text":" が収まった","color":"green"}]
