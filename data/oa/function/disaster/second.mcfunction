# 1秒ごと（br/second から、試合中のみ）。1.9.212：災害は種類ごとに残り秒 #dsN を持ち、複数が同時に進む（通常の抽選・災害コンボで共通）
execute unless score #state br.state matches 1 run return 0
# 予告から発生までの待ち（通常の抽選・災害コンボ）
execute if score #dis_warn br.tmp matches 1.. run function oa:disaster/warn
execute if score #dc_warn br.tmp matches 1.. run function oa:disaster/combo/warn
# 起きている災害をそれぞれ1秒進める
function oa:disaster/count
execute if score #dis_active br.tmp matches 1.. run function oa:disaster/run_all
function oa:disaster/fall_tick
function oa:disaster/bar
# すべて収まった
execute if score #dis_was br.tmp matches 1.. if score #dis_active br.tmp matches 0 run function oa:disaster/end
scoreboard players operation #dis_was br.tmp = #dis_active br.tmp
# 新しい抽選：起きている・予告中・無効（#dis_off=1）なら始めない。保護期間のあと〜終盤の少し前まで
execute if score #dis_active br.tmp matches 1.. run return 0
execute if score #dis_warn br.tmp matches 1.. run return 0
execute if score #dc_warn br.tmp matches 1.. run return 0
execute if score #dis_off br.tmp matches 1 run return 0
execute unless score #time br.time matches 1200..10200 run return 0
scoreboard players remove #dis_cd br.tmp 1
execute if score #dis_cd br.tmp matches 1.. run return 0
scoreboard players set #dis_cd br.tmp 0
function oa:disaster/busy
execute if score #dis_busy br.tmp matches 1 run return 0
function oa:disaster/begin
