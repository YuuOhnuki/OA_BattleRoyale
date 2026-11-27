# 1.9.255: 札（@s、札の位置）の下のチェストの中身を調べて、文字を決める。チェストは一番近い目印 br.chest（札は目印の1.2上。下の広場のチェストは0.2上）
scoreboard players set #lbl_full br.tmp 0
execute store success score #lbl_full br.tmp as @e[type=minecraft:marker,tag=br.chest,distance=..2.5,sort=nearest,limit=1] at @s if items block ~ ~ ~ container.* *
execute if entity @s[tag=br.open_rich] if score #lbl_full br.tmp matches 1 run return run data modify entity @s text set value {text:"★ 特別チェスト",color:"gold"}
execute if entity @s[tag=br.open_rich] run return run data modify entity @s text set value [{text:"★ 特別チェスト",color:"gold"},{text:"\n空",color:"gray"}]
execute if score #lbl_full br.tmp matches 1 run return run data modify entity @s text set from storage oa:br open_label
data modify entity @s text set from storage oa:br open_label_empty
