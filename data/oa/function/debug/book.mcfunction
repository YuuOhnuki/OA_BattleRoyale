execute unless entity @s[tag=br.admin,tag=oa.debug] run return run tellraw @s {text:"管理ブックからデバッグを開始してください。",color:"yellow"}
clear @s *[minecraft:custom_data~{oa_debug_book:1b}]
data modify storage oa:debug_book cd set value "なし"
execute if score @s oa.db_cd matches 1 run data modify storage oa:debug_book cd set value "あり"
data modify storage oa:debug_book unique set value "なし"
execute if score @s oa.db_unique matches 1 run data modify storage oa:debug_book unique set value "あり"
data modify storage oa:debug_book match set value "なし"
execute if score @s oa.db_match matches 1 run data modify storage oa:debug_book match set value "あり"
data modify storage oa:debug_book grace set value "なし"
execute if score @s oa.db_grace matches 1 run data modify storage oa:debug_book grace set value "あり"
data modify storage oa:debug_book team set value "なし"
execute if score @s oa.db_team matches 1 run data modify storage oa:debug_book team set value "あり"
data modify storage oa:debug_book consume set value "なし"
execute if score @s oa.db_consume matches 1 run data modify storage oa:debug_book consume set value "あり"
data modify storage oa:debug_book wear set value "なし"
execute if score @s oa.db_wear matches 1 run data modify storage oa:debug_book wear set value "あり"
data modify storage oa:debug_book bind set value "なし"
execute if score @s oa.db_bind matches 1 run data modify storage oa:debug_book bind set value "あり"
data modify storage oa:debug_book mobs set value "なし"
execute if score @s oa.db_mobs matches 1 run data modify storage oa:debug_book mobs set value "あり"
data modify storage oa:debug_book heal set value "なし"
execute if score @s oa.db_heal matches 1 run data modify storage oa:debug_book heal set value "あり"
function oa:debug/book_give with storage oa:debug_book
tellraw @s {text:"デバッグブックを更新しました。開き直すと現在の設定が表示されます。",color:"aqua"}
