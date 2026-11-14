# 1.9.159: 開けたチェストの上の「開封済み」の札に、再補充（tick 7200）までの残り時間を出す（1.9.157〜1.9.158 はチェストの名前に出していた）。
# br/second から毎秒（試合中）と、br/start から1回。特別チェストの札（br.open_rich）は再補充がないので「開封済み」のまま。
execute if score #time br.time matches 7200.. run data modify storage oa:br open_label set value {text:"開封済み",color:"gray"}
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
