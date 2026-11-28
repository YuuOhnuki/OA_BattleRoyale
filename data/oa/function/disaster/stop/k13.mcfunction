# 生成：scripts/gen_disasters.py（直接編集しない）
# 巨大隕石の終わり（ほかの災害の効果には触れない）
scoreboard players set #ds13 br.tmp 0
execute if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"巨大隕石"},{"text":" が収まった"}]
