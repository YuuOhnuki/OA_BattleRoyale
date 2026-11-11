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
