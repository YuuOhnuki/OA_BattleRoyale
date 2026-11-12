# ネザー会場の空中補給の場所名（中心からの相対座標 #rx,#rz は呼び出し元で計算済み）
data modify storage oa:supply region set value "玄武岩の柱"
execute if score #rx br.tmp matches 1.. if score #rz br.tmp matches 1.. run data modify storage oa:supply region set value "ソウルサンドの谷"
execute if score #rx br.tmp matches ..0 if score #rz br.tmp matches 1.. run data modify storage oa:supply region set value "真紅の森"
execute if score #rx br.tmp matches ..0 if score #rz br.tmp matches ..0 run data modify storage oa:supply region set value "歪んだ森"
execute if score #rx br.tmp matches -25..25 if score #rz br.tmp matches -25..25 run data modify storage oa:supply region set value "中央の宝物庫"
