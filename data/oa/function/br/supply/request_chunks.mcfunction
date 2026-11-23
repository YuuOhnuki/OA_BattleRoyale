# 選出の前に対象範囲を非同期で準備。抽選/地面判定は既存placeへ戻す。
data modify storage oa:supply prepare set from storage oa:br_spawn
execute store result storage oa:supply prepare.minimum int 1 run scoreboard players get #sup_min2 br.tmp
execute store result storage oa:supply prepare.round int 1 run scoreboard players get #round br.round
execute store result storage oa:supply prepare.map int 1 run scoreboard players get #map oa.mapid
scoreboard players operation #supply_reveal br.tmp = #time br.time
scoreboard players add #supply_reveal br.tmp 420
execute store result storage oa:supply prepare.reveal int 1 run scoreboard players get #supply_reveal br.tmp
