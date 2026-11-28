# 生成：scripts/gen_disasters.py（直接編集しない）
# スカルクの目覚めの終わり（ほかの災害の効果には触れない）
scoreboard players set #ds15 br.tmp 0
execute if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"スカルクの目覚め"},{"text":" が収まった"}]
