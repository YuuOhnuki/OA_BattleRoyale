# 1.9.203: バトルロワイヤル受付の開始（ホスト・管理者）。形式は #pref br.mode。
execute unless entity @s[tag=br.admin] unless entity @s[tag=br.host] run return run tellraw @s {text:"開始はホスト・管理者が行えます。",color:"yellow"}
execute if score #game oa.game matches 1 run return run tellraw @s {text:"現在のモードはチームデスマッチです。先にバトルロワイヤルへ切り替えてください。",color:"yellow"}
execute if score #pref br.mode matches 1 run return run function oa:br/start_team
function oa:br/start_solo
