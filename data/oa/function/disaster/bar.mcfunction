# 生成：scripts/gen_disasters.py（直接編集しない）
# 災害のボスバー（oa:disaster）。起きている災害の名前・危険度・残り秒をまとめて出す
execute if score #dis_active br.tmp matches 0 run return run bossbar set oa:disaster visible false
data modify storage oa:disaster bar set value []
execute if score #ds1 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"酸性雨 ★★★★☆ ","color":"green"}
execute if score #ds1 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds1","objective":"br.tmp"},"color":"white"}
execute if score #ds1 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds2 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"寒波 ★★★★☆ ","color":"aqua"}
execute if score #ds2 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds2","objective":"br.tmp"},"color":"white"}
execute if score #ds2 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"隕石群 ★★★★★ ","color":"red"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds3","objective":"br.tmp"},"color":"white"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"火山弾 ★★★★★ ","color":"red"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"score":{"name":"#ds3","objective":"br.tmp"},"color":"white"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"落盤 ★★★★★ ","color":"red"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"score":{"name":"#ds3","objective":"br.tmp"},"color":"white"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"隕石群 ★★★★★ ","color":"red"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"score":{"name":"#ds3","objective":"br.tmp"},"color":"white"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"隕石群 ★★★★★ ","color":"red"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"score":{"name":"#ds3","objective":"br.tmp"},"color":"white"}
execute if score #ds3 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"毒霧 ★★★★☆ ","color":"dark_green"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds4","objective":"br.tmp"},"color":"white"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"毒の瘴気 ★★★★☆ ","color":"dark_green"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"score":{"name":"#ds4","objective":"br.tmp"},"color":"white"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"毒霧 ★★★★☆ ","color":"dark_green"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"score":{"name":"#ds4","objective":"br.tmp"},"color":"white"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"毒霧 ★★★★☆ ","color":"dark_green"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"score":{"name":"#ds4","objective":"br.tmp"},"color":"white"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"毒霧 ★★★★☆ ","color":"dark_green"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"score":{"name":"#ds4","objective":"br.tmp"},"color":"white"}
execute if score #ds4 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"地震 ★★★☆☆ ","color":"gold"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds5","objective":"br.tmp"},"color":"white"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"地震 ★★★☆☆ ","color":"gold"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"score":{"name":"#ds5","objective":"br.tmp"},"color":"white"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"地震 ★★★☆☆ ","color":"gold"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"score":{"name":"#ds5","objective":"br.tmp"},"color":"white"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"地震 ★★★☆☆ ","color":"gold"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"score":{"name":"#ds5","objective":"br.tmp"},"color":"white"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"地震 ★★★☆☆ ","color":"gold"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"score":{"name":"#ds5","objective":"br.tmp"},"color":"white"}
execute if score #ds5 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"濃霧 ★★☆☆☆ ","color":"gray"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds6","objective":"br.tmp"},"color":"white"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"灰嵐 ★★☆☆☆ ","color":"gray"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"score":{"name":"#ds6","objective":"br.tmp"},"color":"white"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"濃霧 ★★☆☆☆ ","color":"gray"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"score":{"name":"#ds6","objective":"br.tmp"},"color":"white"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"濃霧 ★★☆☆☆ ","color":"gray"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"score":{"name":"#ds6","objective":"br.tmp"},"color":"white"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"濃霧 ★★☆☆☆ ","color":"gray"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"score":{"name":"#ds6","objective":"br.tmp"},"color":"white"}
execute if score #ds6 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"重力異常 ★★☆☆☆ ","color":"light_purple"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds7","objective":"br.tmp"},"color":"white"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"重力異常 ★★☆☆☆ ","color":"light_purple"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"score":{"name":"#ds7","objective":"br.tmp"},"color":"white"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"重力異常 ★★☆☆☆ ","color":"light_purple"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"score":{"name":"#ds7","objective":"br.tmp"},"color":"white"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"重力異常 ★★☆☆☆ ","color":"light_purple"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"score":{"name":"#ds7","objective":"br.tmp"},"color":"white"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"重力異常 ★★☆☆☆ ","color":"light_purple"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"score":{"name":"#ds7","objective":"br.tmp"},"color":"white"}
execute if score #ds7 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"ニワトリ大量発生 ★☆☆☆☆ ","color":"yellow"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds8","objective":"br.tmp"},"color":"white"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"ニワトリ大量発生 ★☆☆☆☆ ","color":"yellow"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"score":{"name":"#ds8","objective":"br.tmp"},"color":"white"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"ニワトリ大量発生 ★☆☆☆☆ ","color":"yellow"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"score":{"name":"#ds8","objective":"br.tmp"},"color":"white"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"ニワトリ大量発生 ★☆☆☆☆ ","color":"yellow"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"score":{"name":"#ds8","objective":"br.tmp"},"color":"white"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"ニワトリ大量発生 ★☆☆☆☆ ","color":"yellow"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"score":{"name":"#ds8","objective":"br.tmp"},"color":"white"}
execute if score #ds8 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"血の月 ★★☆☆☆ ","color":"dark_red"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds9","objective":"br.tmp"},"color":"white"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"血の月 ★★☆☆☆ ","color":"dark_red"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"score":{"name":"#ds9","objective":"br.tmp"},"color":"white"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"血の月 ★★☆☆☆ ","color":"dark_red"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"score":{"name":"#ds9","objective":"br.tmp"},"color":"white"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"血の月 ★★☆☆☆ ","color":"dark_red"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"score":{"name":"#ds9","objective":"br.tmp"},"color":"white"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"血の月 ★★☆☆☆ ","color":"dark_red"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"score":{"name":"#ds9","objective":"br.tmp"},"color":"white"}
execute if score #ds9 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds10 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"竜巻 ★★★★☆ ","color":"white"}
execute if score #ds10 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds10","objective":"br.tmp"},"color":"white"}
execute if score #ds10 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds10 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"竜巻 ★★★★☆ ","color":"white"}
execute if score #ds10 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"score":{"name":"#ds10","objective":"br.tmp"},"color":"white"}
execute if score #ds10 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"ブタの大行進 ★★★☆☆ ","color":"light_purple"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds11","objective":"br.tmp"},"color":"white"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"ブタの大行進 ★★★☆☆ ","color":"light_purple"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"score":{"name":"#ds11","objective":"br.tmp"},"color":"white"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"ブタの大行進 ★★★☆☆ ","color":"light_purple"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"score":{"name":"#ds11","objective":"br.tmp"},"color":"white"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"ブタの大行進 ★★★☆☆ ","color":"light_purple"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"score":{"name":"#ds11","objective":"br.tmp"},"color":"white"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"ブタの大行進 ★★★☆☆ ","color":"light_purple"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"score":{"name":"#ds11","objective":"br.tmp"},"color":"white"}
execute if score #ds11 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds12 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"塔の砲撃 ★★★★☆ ","color":"dark_purple"}
execute if score #ds12 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"score":{"name":"#ds12","objective":"br.tmp"},"color":"white"}
execute if score #ds12 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds13 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"巨大隕石 ★★★★★ ","color":"red"}
execute if score #ds13 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"score":{"name":"#ds13","objective":"br.tmp"},"color":"white"}
execute if score #ds13 br.tmp matches 1.. if score #map oa.mapid matches 0 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds14 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"噴火 ★★★★☆ ","color":"gold"}
execute if score #ds14 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"score":{"name":"#ds14","objective":"br.tmp"},"color":"white"}
execute if score #ds14 br.tmp matches 1.. if score #map oa.mapid matches 1 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds15 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"スカルクの目覚め ★★★☆☆ ","color":"dark_aqua"}
execute if score #ds15 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"score":{"name":"#ds15","objective":"br.tmp"},"color":"white"}
execute if score #ds15 br.tmp matches 1.. if score #map oa.mapid matches 2 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds16 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"島の崩落 ★★★★☆ ","color":"aqua"}
execute if score #ds16 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"score":{"name":"#ds16","objective":"br.tmp"},"color":"white"}
execute if score #ds16 br.tmp matches 1.. if score #map oa.mapid matches 3 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds17 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"虚空の侵食 ★★★★☆ ","color":"dark_purple"}
execute if score #ds17 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"score":{"name":"#ds17","objective":"br.tmp"},"color":"white"}
execute if score #ds17 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #ds18 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"エンダードラゴン ★★★☆☆ ","color":"light_purple"}
execute if score #ds18 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"score":{"name":"#ds18","objective":"br.tmp"},"color":"white"}
execute if score #ds18 br.tmp matches 1.. if score #map oa.mapid matches 4 run data modify storage oa:disaster bar append value {"text":"秒　","color":"white"}
execute if score #dis_active br.tmp matches ..3 run bossbar set oa:disaster name [{"text":"⚠ ","color":"red","bold":true},{"nbt":"bar[]","storage":"oa:disaster","interpret":true,"separator":""}]
execute if score #dis_active br.tmp matches 4.. run bossbar set oa:disaster name [{"text":"⚠ 災害が同時に ","color":"red","bold":true},{"score":{"name":"#dis_active","objective":"br.tmp"},"color":"white","bold":true},{"text":" 種類","color":"red","bold":true}]
scoreboard players set #bar_max br.tmp 1
scoreboard players set #bar_v br.tmp 0
execute if score #ds1 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax1 br.tmp
execute if score #ds1 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds1 br.tmp
execute if score #ds2 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax2 br.tmp
execute if score #ds2 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds2 br.tmp
execute if score #ds3 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax3 br.tmp
execute if score #ds3 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds3 br.tmp
execute if score #ds4 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax4 br.tmp
execute if score #ds4 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds4 br.tmp
execute if score #ds5 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax5 br.tmp
execute if score #ds5 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds5 br.tmp
execute if score #ds6 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax6 br.tmp
execute if score #ds6 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds6 br.tmp
execute if score #ds7 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax7 br.tmp
execute if score #ds7 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds7 br.tmp
execute if score #ds8 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax8 br.tmp
execute if score #ds8 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds8 br.tmp
execute if score #ds9 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax9 br.tmp
execute if score #ds9 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds9 br.tmp
execute if score #ds10 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax10 br.tmp
execute if score #ds10 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds10 br.tmp
execute if score #ds11 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax11 br.tmp
execute if score #ds11 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds11 br.tmp
execute if score #ds12 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax12 br.tmp
execute if score #ds12 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds12 br.tmp
execute if score #ds13 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax13 br.tmp
execute if score #ds13 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds13 br.tmp
execute if score #ds14 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax14 br.tmp
execute if score #ds14 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds14 br.tmp
execute if score #ds15 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax15 br.tmp
execute if score #ds15 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds15 br.tmp
execute if score #ds16 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax16 br.tmp
execute if score #ds16 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds16 br.tmp
execute if score #ds17 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax17 br.tmp
execute if score #ds17 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds17 br.tmp
execute if score #ds18 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_max br.tmp = #dmax18 br.tmp
execute if score #ds18 br.tmp > #bar_v br.tmp run scoreboard players operation #bar_v br.tmp = #ds18 br.tmp
execute store result bossbar oa:disaster max run scoreboard players get #bar_max br.tmp
execute store result bossbar oa:disaster value run scoreboard players get #bar_v br.tmp
bossbar set oa:disaster players @a[tag=br.playing]
bossbar set oa:disaster visible true
