# 1.9.186: 毒霧の中にいるか（生存者として）。中心からの水平の距離が半径以内なら毎秒1（魔法）＋毒II
execute store result score #fog_px br.tmp run data get entity @s Pos[0]
execute store result score #fog_pz br.tmp run data get entity @s Pos[2]
scoreboard players operation #fog_px br.tmp -= #fog_cx br.tmp
scoreboard players operation #fog_pz br.tmp -= #fog_cz br.tmp
scoreboard players operation #fog_px br.tmp *= #fog_px br.tmp
scoreboard players operation #fog_pz br.tmp *= #fog_pz br.tmp
scoreboard players operation #fog_px br.tmp += #fog_pz br.tmp
execute if score #fog_px br.tmp > #fog_r2 br.tmp run return 0
effect give @s minecraft:poison 3 1 true
function oa:disaster/dmg {amount:1,type:"minecraft:magic"}
tag @s add br.dis_msg
execute if score #dis_phase br.tmp matches 1 run title @s actionbar {text:"☠ 毒霧の中！ 中心から離れよう",color:"dark_green"}
