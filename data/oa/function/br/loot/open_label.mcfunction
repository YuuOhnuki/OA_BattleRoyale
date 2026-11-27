# 1.9.159: 開けたチェストの上の札に、再補充（tick 7200）までの残り時間を出す。br/second から毎秒（試合中）と、br/start から1回。
# 1.9.255: 1行目は中身が空のときだけ「空」（以前は「開封済み」）。札ごとに br/loot/open_label_one が中身を調べて、
#   storage oa:br open_label（空でない）／open_label_empty（空）のどちらかにする。再補充のあとは「空」だけ（空でなければ何も出さない）
execute if score #time br.time matches 7200.. run data modify storage oa:br open_label set value ""
execute if score #time br.time matches 7200.. run data modify storage oa:br open_label_empty set value {text:"空",color:"gray"}
execute if score #time br.time matches 7200.. run return run function oa:br/loot/open_label_all
scoreboard players set #ct_left br.tmp 7219
scoreboard players operation #ct_left br.tmp -= #time br.time
scoreboard players operation #ct_left br.tmp /= #20 br.tmp
scoreboard players set #ct60 br.tmp 60
scoreboard players operation #ct_s br.tmp = #ct_left br.tmp
scoreboard players operation #ct_s br.tmp %= #ct60 br.tmp
scoreboard players operation #ct_left br.tmp /= #ct60 br.tmp
execute store result storage oa:br ct.m int 1 run scoreboard players get #ct_left br.tmp
execute store result storage oa:br ct.s int 1 run scoreboard players get #ct_s br.tmp
data modify storage oa:br ct.p set value ""
execute if score #ct_s br.tmp matches ..9 run data modify storage oa:br ct.p set value "0"
function oa:br/loot/open_label_set with storage oa:br ct
function oa:br/loot/open_label_all
