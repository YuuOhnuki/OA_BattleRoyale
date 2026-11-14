execute if entity @s[tag=oa.practice] run return 0
execute unless dimension minecraft:overworld run return 0
execute unless entity @s[tag=br.lobby_now,tag=!br.playing,tag=!oa.debug,gamemode=!spectator] run return run tellraw @s {text:"ロビーから練習場へ入ってください。",color:"yellow"}
execute unless score #state br.state matches 0 run return run tellraw @s {text:"試合待機中に練習場へ入れます。",color:"yellow"}
execute if score @s br.saved matches 1 run return run tellraw @s {text:"先に保存中の持ち物を復元してください。",color:"yellow"}
execute unless data storage oa:practice {layout:1998} run return run function oa:practice/prepare
execute unless score @s oa.id matches 1.. run function oa:internal/id
scoreboard players add @s br.pick 0
function oa:br/save_player
execute unless score @s br.saved matches 1 run return run tellraw @s {text:"持ち物の保存に失敗しました。",color:"red"}
tag @s add oa.practice
tag @s remove oa.practice_wait
# 1.9.143: 練習中も参加登録（br.lobby）とチーム選択（br.pick）は保持する
tag @s remove br.lobby_now
tag @s remove br.in_lobby
tag @s remove br.login_pending
function oa:br/clear_inventory
function oa:test/join
tag @s add oa.debug
tag @s add oa.db_free_match
tag @s add oa.db_free_grace
tag @s add oa.db_mobs
tag @s add oa.db_multi
tag @s add oa.db_keepwear
tag @s add oa.db_unbind
team join oa_practice @s
gamemode adventure @s
effect give @s minecraft:resistance infinite 4 true
effect give @s minecraft:saturation 2 3 true
function oa:itori/progress_save
function oa:itori/progress_reset
scoreboard players set @s oa.i_points 15
execute in oa:practice run tp @s 0.5 65 35.5 180 0
function oa:lobby/guide/book
function oa:practice/book
tellraw @s {text:"入口の操作盤で天候・時間・CTを変更。武器札を右クリックで試用。ロビーへ戻るには出口札か案内ブックを使用。",color:"aqua"}
tellraw @s {text:"練習用：「練習場メニュー」の本をクリックで、ダメージ計測・模擬戦・昼夜・天候・クールタイムを操作できます（従来の /trigger oa.dps ・ oa.spar も使えます）。奥（南側）に射程レーンと高さの的があります。",color:"aqua"}
