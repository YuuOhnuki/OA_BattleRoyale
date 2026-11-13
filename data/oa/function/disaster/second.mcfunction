# 1秒ごと（br/second から、試合中のみ）。ギミックの動作・配置と、災害の抽選・進行。
execute unless score #state br.state matches 1 run return 0
function oa:disaster/gimmick/second
execute if score #dis_off br.tmp matches 1 run return 0
execute if score #dis_kind br.tmp matches 1.. run return run function oa:disaster/active
# 保護期間のあと〜終盤の少し前まで。終盤の演出と重ならないようにする
execute unless score #time br.time matches 1200..10200 run return 0
scoreboard players remove #dis_cd br.tmp 1
execute if score #dis_cd br.tmp matches ..0 run function oa:disaster/begin
