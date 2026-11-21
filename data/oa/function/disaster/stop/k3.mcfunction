# 生成：scripts/gen_disasters.py（直接編集しない）
# 隕石群の終わり（ほかの災害の効果には触れない）
scoreboard players set #ds3 br.tmp 0
execute if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"隕石群","color":"red"},{"text":" が収まった","color":"green"}]
execute if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"火山弾","color":"red"},{"text":" が収まった","color":"green"}]
execute if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"落盤","color":"red"},{"text":" が収まった","color":"green"}]
