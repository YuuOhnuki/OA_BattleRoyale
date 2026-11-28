# 生成：scripts/gen_disasters.py（直接編集しない）
# 噴火の終わり（ほかの災害の効果には触れない）
scoreboard players set #ds14 br.tmp 0
execute if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"噴火"},{"text":" が収まった"}]
