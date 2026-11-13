# 開始TP直後の地中埋まりを補正する。チャンクの読み込み待ちに備えて、3tick後から10tickごとに数回確認する
execute unless score #state br.state matches 1 run return run tag @a remove br.tpfix
execute as @a[tag=br.tpfix] at @s run function oa:br/tp_fix
scoreboard players add #tpfix_t br.flag 1
execute if score #tpfix_t br.flag matches ..6 run return run schedule function oa:br/tp_fix_all 10t
tag @a remove br.tpfix
