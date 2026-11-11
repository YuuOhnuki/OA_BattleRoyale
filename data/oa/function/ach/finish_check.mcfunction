# 試合終了時の隠し実績。br.playing 全員を実行者として呼ぶ（br.winner は設定済み）
scoreboard players operation #dist br.tmp = @s br.st_walk
scoreboard players operation #dist br.tmp += @s br.st_sprint
execute if score #dist br.tmp matches 300000.. run function oa:ach/give {id:"walker",name:"地平線の向こうへ"}
execute if score @s br.st_jmp matches 300.. run function oa:ach/give {id:"jumper",name:"ウサギ跳び"}
execute unless entity @s[tag=br.winner] run return 0
execute if score @s br.st_kill matches 0 run function oa:ach/give {id:"peace_win",name:"平和主義者"}
execute store result score #hp br.tmp run data get entity @s Health 1
execute if score #hp br.tmp matches ..2 run function oa:ach/give {id:"close_call",name:"紙一重"}
