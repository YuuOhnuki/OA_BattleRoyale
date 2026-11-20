# 1.9.203: チームデスマッチ受付の開始（ホスト・管理者）。
execute unless entity @s[tag=br.admin] unless entity @s[tag=br.host] run return run tellraw @s {text:"開始はホスト・管理者が行えます。",color:"yellow"}
execute if score #game oa.game matches 0 run return run tellraw @s {text:"現在のモードはバトルロワイヤルです。先にチームデスマッチへ切り替えてください。",color:"yellow"}
function oa:br/start
