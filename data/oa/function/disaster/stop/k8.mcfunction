# 生成：scripts/gen_disasters.py（直接編集しない）
# ニワトリ大量発生の終わり（ほかの災害の効果には触れない）
function oa:disaster/k8/end
scoreboard players set #ds8 br.tmp 0
execute if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"ニワトリ大量発生","color":"yellow"},{"text":" が収まった","color":"green"}]
execute if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"ニワトリ大量発生","color":"yellow"},{"text":" が収まった","color":"green"}]
execute if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"ニワトリ大量発生","color":"yellow"},{"text":" が収まった","color":"green"}]
