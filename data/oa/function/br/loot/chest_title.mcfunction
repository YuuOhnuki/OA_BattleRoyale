# 1.9.157: 通常チェストの名前（開いたときの画面の題名）に、再補充（tick 7200）までの残り時間を出す。
# br/second から毎秒（試合中）と、br/start から1回。名前を付けるのは br/loot/chest_tick（1秒に1回、特別チェスト以外）
execute if score #time br.time matches 7200.. run return run data modify storage oa:br chest_title set value {text:"チェスト（再補充済み）"}
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
function oa:br/loot/chest_title_set with storage oa:br ct
