# 生成：scripts/gen_disasters.py（直接編集しない）
# 虚空の侵食の終わり（ほかの災害の効果には触れない）
scoreboard players set #ds17 br.tmp 0
execute if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"虚空の侵食"},{"text":" が収まった"}]
