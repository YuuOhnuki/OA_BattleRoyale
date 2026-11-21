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
execute if score @s tdm.type matches 104 run data modify storage oa:tdm_label name set value "回復 ♥×5・満腹度5ゲージ [近づくと取得]"
# weapon-colour206
data modify storage oa:tdm_label component set value {text:"",extra:[]}
data modify storage oa:tdm_label component.text set from storage oa:tdm_label name
execute if score @s tdm.type matches 1 run data modify storage oa:tdm_label component set value {"text":"","extra":[{"text":"ゆうあ","color":"#fdc5f9","italic":false,"bold":true},{"text":" [シフトで交換]","color":"gray"}]}
execute if score @s tdm.type matches 2 run data modify storage oa:tdm_label component set value {"text":"","extra":[{"text":"ぴちぴち","color":"white","italic":false,"font":"oa:weapon_pichipichi","bold":false,"shadow_color":0},{"text":" [シフトで交換]","color":"gray"}]}
execute if score @s tdm.type matches 3 run data modify storage oa:tdm_label component set value {"text":"","extra":[{"text":"らじ","color":"#ffad29","italic":false,"bold":true},{"text":" [シフトで交換]","color":"gray"}]}
execute if score @s tdm.type matches 4 run data modify storage oa:tdm_label component set value {"text":"","extra":[{"text":"ネロノワール","color":"white","italic":false,"font":"oa:weapon_neronoir","bold":false,"shadow_color":0},{"text":" [シフトで交換]","color":"gray"}]}
execute if score @s tdm.type matches 5 run data modify storage oa:tdm_label component set value {"text":"","extra":[{"text":"キリング","color":"#8d59ff","italic":false,"bold":true},{"text":" [シフトで交換]","color":"gray"}]}
execute if score @s tdm.type matches 6 run data modify storage oa:tdm_label component set value {"text":"","extra":[{"text":"ゆったり","color":"#65fff0","italic":false,"bold":true},{"text":" [シフトで交換]","color":"gray"}]}
execute if score @s tdm.type matches 7 run data modify storage oa:tdm_label component set value {"text":"","extra":[{"text":"ほちきす","color":"#851c1c","italic":false,"bold":true},{"text":" [シフトで交換]","color":"gray"}]}
execute if score @s tdm.type matches 8 run data modify storage oa:tdm_label component set value {"text":"","extra":[{"text":"こまめ","color":"#51c5ff","italic":false,"bold":true},{"text":" [シフトで交換]","color":"gray"}]}
execute if score @s tdm.type matches 10 run data modify storage oa:tdm_label component set value {"text":"","extra":[{"text":"いとり","color":"#006dff","italic":false,"bold":true},{"text":" [シフトで交換]","color":"gray"}]}
execute if score @s tdm.type matches 103 run data modify storage oa:tdm_label component set value {"text":"","extra":[{"text":"ゆー","color":"white","italic":false,"font":"oa:weapon_yu","bold":false,"shadow_color":0},{"text":" [近づくと取得]","color":"gray"}]}
function oa:tdm/loot/label_spawn with storage oa:tdm_label
scoreboard players operation @e[tag=tdm.label_new,limit=1] tdm.dropid = @s tdm.dropid
tag @e[tag=tdm.label_new] remove tdm.label_new
