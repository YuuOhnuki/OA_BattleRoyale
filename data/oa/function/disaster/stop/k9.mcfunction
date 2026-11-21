# 生成：scripts/gen_disasters.py（直接編集しない）
# 血の月・強制パーティーの終わり（ほかの災害の効果には触れない）
scoreboard players set #ds9 br.tmp 0
execute if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"血の月・強制パーティー","color":"dark_red"},{"text":" が収まった","color":"green"}]
execute if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"血の月・強制パーティー","color":"dark_red"},{"text":" が収まった","color":"green"}]
execute if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"✔ ","color":"green"},{"text":"血の月・強制パーティー","color":"dark_red"},{"text":" が収まった","color":"green"}]
