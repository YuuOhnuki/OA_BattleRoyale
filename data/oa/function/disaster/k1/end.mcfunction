# 酸性雨の終わり：天候の目標を災害の前に戻す（途中で天候抽選が変えていた場合はそのまま）
execute if score #weather_target br.tmp matches 1 run scoreboard players operation #weather_target br.tmp = #dis_wx_prev br.tmp
execute if score #map oa.mapid matches 0 in oa:br run function oa:br/weather/apply
execute if score #map oa.mapid matches 1 in oa:br_nether run function oa:br/weather/apply
