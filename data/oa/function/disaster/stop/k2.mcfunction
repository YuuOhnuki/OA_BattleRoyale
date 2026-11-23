# 生成：scripts/gen_disasters.py（直接編集しない）
# 寒波の終わり（ほかの災害の効果には触れない）
scoreboard players set #ds2 br.tmp 0
execute if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"寒波"},{"text":" が収まった"}]
