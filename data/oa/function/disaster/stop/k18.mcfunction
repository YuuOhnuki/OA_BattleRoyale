# 生成：scripts/gen_disasters.py（直接編集しない）
# エンダードラゴンの終わり（ほかの災害の効果には触れない）
scoreboard players set #ds18 br.tmp 0
execute if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"エンダードラゴン"},{"text":" が収まった"}]
