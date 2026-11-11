scoreboard players operation #signature br.tmp = #phase br.tmp
scoreboard players operation #signature br.tmp *= #two br.tmp
scoreboard players operation #signature br.tmp += #shrinking br.flag
execute if score #sec br.sec matches 600..659 run scoreboard players set #signature br.tmp 99
execute if score #sec br.sec matches 660.. run scoreboard players set #signature br.tmp 100
execute if score #signature br.tmp = #notice br.tmp run return 0
scoreboard players operation #notice br.tmp = #signature br.tmp
execute store result storage oa:br_notice phase int 1 run scoreboard players get #phase br.tmp
execute store result storage oa:br_notice next int 1 run scoreboard players get #next br.tmp
data modify storage oa:br_notice state set value "待機開始"
execute if score #shrinking br.flag matches 1 run data modify storage oa:br_notice state set value "収縮開始！"
execute if score #sec br.sec matches 600..659 run data modify storage oa:br_notice state set value "延長戦・最終収縮！"
execute if score #sec br.sec matches 660.. run data modify storage oa:br_notice state set value "最終ボーダー到達"
function oa:br/phase/announce with storage oa:br_notice
