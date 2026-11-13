# 災害の合図（発生の5秒前）。濃霧（地上）／灰嵐（ネザー）
execute unless score #map oa.mapid matches 1 run function oa:disaster/k6/start_fog
execute if score #map oa.mapid matches 1 run function oa:disaster/k6/start_ash
