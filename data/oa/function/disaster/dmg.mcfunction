# 1.9.212：災害の継続ダメージの入口（プレイヤーとして実行。引数 amount・type）。
# 2種類以上が同時に起きている間は、1人あたり1秒の合計を cfg.dot_cap（初期4）までに抑える（隕石の着弾は対象外）
$scoreboard players set #dd br.tmp $(amount)
execute if score #dis_active br.tmp matches 2.. run function oa:disaster/dmg_cap
execute if score #dd br.tmp matches ..0 run return 0
scoreboard players operation @s br.ddmg += #dd br.tmp
execute store result storage oa:disaster hit.amount int 1 run scoreboard players get #dd br.tmp
$data modify storage oa:disaster hit.type set value "$(type)"
function oa:disaster/dmg_apply with storage oa:disaster hit
