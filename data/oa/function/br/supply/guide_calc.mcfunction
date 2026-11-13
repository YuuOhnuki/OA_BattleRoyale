scoreboard players set #m1 br.tmp -1
scoreboard players set #c2 br.tmp 2
scoreboard players set #c4 br.tmp 4
scoreboard players set #c5 br.tmp 5
scoreboard players set #c10 br.tmp 10
execute store result score #px br.tmp run data get entity @s Pos[0]
execute store result score #pz br.tmp run data get entity @s Pos[2]
scoreboard players operation #dx br.tmp = #mx br.tmp
scoreboard players operation #dx br.tmp -= #px br.tmp
scoreboard players operation #dz br.tmp = #mz br.tmp
scoreboard players operation #dz br.tmp -= #pz br.tmp
scoreboard players operation #ax br.tmp = #dx br.tmp
execute if score #ax br.tmp matches ..-1 run scoreboard players operation #ax br.tmp *= #m1 br.tmp
scoreboard players operation #az br.tmp = #dz br.tmp
execute if score #az br.tmp matches ..-1 run scoreboard players operation #az br.tmp *= #m1 br.tmp
scoreboard players operation #big br.tmp = #ax br.tmp
scoreboard players operation #big br.tmp > #az br.tmp
scoreboard players operation #small br.tmp = #ax br.tmp
scoreboard players operation #small br.tmp < #az br.tmp
scoreboard players operation #small br.tmp *= #c4 br.tmp
scoreboard players operation #small br.tmp /= #c10 br.tmp
scoreboard players operation #dist br.tmp = #big br.tmp
scoreboard players operation #dist br.tmp += #small br.tmp
scoreboard players set #mode br.tmp 0
scoreboard players operation #t1 br.tmp = #az br.tmp
scoreboard players operation #t1 br.tmp *= #c5 br.tmp
scoreboard players operation #t2 br.tmp = #ax br.tmp
scoreboard players operation #t2 br.tmp *= #c2 br.tmp
execute if score #t1 br.tmp < #t2 br.tmp run scoreboard players set #mode br.tmp 1
scoreboard players operation #t1 br.tmp = #ax br.tmp
scoreboard players operation #t1 br.tmp *= #c5 br.tmp
scoreboard players operation #t2 br.tmp = #az br.tmp
scoreboard players operation #t2 br.tmp *= #c2 br.tmp
execute if score #t1 br.tmp < #t2 br.tmp run scoreboard players set #mode br.tmp 2
data modify storage oa:supply dir set value "南東"
data modify storage oa:supply arrow set value "⬊"
execute if score #mode br.tmp matches 0 if score #dx br.tmp matches ..0 if score #dz br.tmp matches 1.. run data modify storage oa:supply dir set value "南西"
execute if score #mode br.tmp matches 0 if score #dx br.tmp matches ..0 if score #dz br.tmp matches 1.. run data modify storage oa:supply arrow set value "⬋"
execute if score #mode br.tmp matches 0 if score #dx br.tmp matches 1.. if score #dz br.tmp matches ..0 run data modify storage oa:supply dir set value "北東"
execute if score #mode br.tmp matches 0 if score #dx br.tmp matches 1.. if score #dz br.tmp matches ..0 run data modify storage oa:supply arrow set value "⬈"
execute if score #mode br.tmp matches 0 if score #dx br.tmp matches ..0 if score #dz br.tmp matches ..0 run data modify storage oa:supply dir set value "北西"
execute if score #mode br.tmp matches 0 if score #dx br.tmp matches ..0 if score #dz br.tmp matches ..0 run data modify storage oa:supply arrow set value "⬉"
execute if score #mode br.tmp matches 1 if score #dx br.tmp matches 1.. run data modify storage oa:supply dir set value "東"
execute if score #mode br.tmp matches 1 if score #dx br.tmp matches 1.. run data modify storage oa:supply arrow set value "➡"
execute if score #mode br.tmp matches 1 if score #dx br.tmp matches ..0 run data modify storage oa:supply dir set value "西"
execute if score #mode br.tmp matches 1 if score #dx br.tmp matches ..0 run data modify storage oa:supply arrow set value "⬅"
execute if score #mode br.tmp matches 2 if score #dz br.tmp matches 1.. run data modify storage oa:supply dir set value "南"
execute if score #mode br.tmp matches 2 if score #dz br.tmp matches 1.. run data modify storage oa:supply arrow set value "⬇"
execute if score #mode br.tmp matches 2 if score #dz br.tmp matches ..0 run data modify storage oa:supply dir set value "北"
execute if score #mode br.tmp matches 2 if score #dz br.tmp matches ..0 run data modify storage oa:supply arrow set value "⬆"
# 1.9.153: 矢印は「自分の向きから見た補給物資の方向」にする（上＝正面、右＝右手、下＝背後）。方角の文字（北・南東など）は従来どおり。
execute store result storage oa:supply f.x int 1 run scoreboard players get #mx br.tmp
execute store result storage oa:supply f.z int 1 run scoreboard players get #mz br.tmp
summon minecraft:marker ~ ~ ~ {Tags:["br.sup_arrow"]}
function oa:br/supply/guide_face with storage oa:supply f
execute store result score #ty br.tmp run data get entity @e[type=minecraft:marker,tag=br.sup_arrow,distance=..1,limit=1] Rotation[0] 10
kill @e[type=minecraft:marker,tag=br.sup_arrow,distance=..1]
execute store result score #py br.tmp run data get entity @s Rotation[0] 10
scoreboard players operation #rel br.tmp = #ty br.tmp
scoreboard players operation #rel br.tmp -= #py br.tmp
execute if score #rel br.tmp matches 1801.. run scoreboard players remove #rel br.tmp 3600
execute if score #rel br.tmp matches ..-1801 run scoreboard players add #rel br.tmp 3600
data modify storage oa:supply arrow set value "⬇"
execute if score #rel br.tmp matches -225..225 run data modify storage oa:supply arrow set value "⬆"
execute if score #rel br.tmp matches 226..675 run data modify storage oa:supply arrow set value "⬈"
execute if score #rel br.tmp matches 676..1125 run data modify storage oa:supply arrow set value "➡"
execute if score #rel br.tmp matches 1126..1575 run data modify storage oa:supply arrow set value "⬊"
execute if score #rel br.tmp matches -675..-226 run data modify storage oa:supply arrow set value "⬉"
execute if score #rel br.tmp matches -1125..-676 run data modify storage oa:supply arrow set value "⬅"
execute if score #rel br.tmp matches -1575..-1126 run data modify storage oa:supply arrow set value "⬋"
