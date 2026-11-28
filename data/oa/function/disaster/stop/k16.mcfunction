# 生成：scripts/gen_disasters.py（直接編集しない）
# 橋の崩落の終わり（ほかの災害の効果には触れない）
scoreboard players set #ds16 br.tmp 0
execute if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"橋の崩落"},{"text":" が収まった"}]
