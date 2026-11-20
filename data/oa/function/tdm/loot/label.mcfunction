scoreboard players add #next tdm.dropid 1
scoreboard players operation @s tdm.dropid = #next tdm.dropid
data modify storage oa:tdm_label name set value "ドロップ"
execute if score @s tdm.type matches 1 run data modify storage oa:tdm_label name set value "ゆうあ [シフトで交換]"
execute if score @s tdm.type matches 2 run data modify storage oa:tdm_label name set value "ぴちぴち [シフトで交換]"
execute if score @s tdm.type matches 3 run data modify storage oa:tdm_label name set value "らじ [シフトで交換]"
execute if score @s tdm.type matches 4 run data modify storage oa:tdm_label name set value "ねろ [シフトで交換]"
execute if score @s tdm.type matches 5 run data modify storage oa:tdm_label name set value "キリング [シフトで交換]"
execute if score @s tdm.type matches 6 run data modify storage oa:tdm_label name set value "ゆったり [シフトで交換]"
execute if score @s tdm.type matches 7 run data modify storage oa:tdm_label name set value "ほちきす [シフトで交換]"
execute if score @s tdm.type matches 8 run data modify storage oa:tdm_label name set value "こまめ [シフトで交換]"
execute if score @s tdm.type matches 10 run data modify storage oa:tdm_label name set value "いとり [シフトで交換]"
execute if score @s tdm.type matches 101 run data modify storage oa:tdm_label name set value "鉄防具一式 [近づくと取得]"
execute if score @s tdm.type matches 102 run data modify storage oa:tdm_label name set value "ダイヤ防具一式 [近づくと取得]"
execute if score @s tdm.type matches 103 run data modify storage oa:tdm_label name set value "ゆー：オーバーワーク [近づくと取得]"
execute if score @s tdm.type matches 104 run data modify storage oa:tdm_label name set value "即時回復 +10HP [近づくと取得]"
function oa:tdm/loot/label_spawn with storage oa:tdm_label
scoreboard players operation @e[tag=tdm.label_new,limit=1] tdm.dropid = @s tdm.dropid
tag @e[tag=tdm.label_new] remove tdm.label_new
