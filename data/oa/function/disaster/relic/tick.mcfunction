# 近く（12m）に生存者が来たら宝珠の輪郭を表示。離れれば消す。
execute if entity @a[tag=br.alive,gamemode=!spectator,distance=..12] run data merge entity @e[type=minecraft:item_display,tag=br.relic_disp,distance=..2,sort=nearest,limit=1] {Glowing:1b,glow_color_override:11141375}
execute unless entity @a[tag=br.alive,gamemode=!spectator,distance=..12] run data merge entity @e[type=minecraft:item_display,tag=br.relic_disp,distance=..2,sort=nearest,limit=1] {Glowing:0b}
# 宝珠の1ティック処理（interaction として実行）。br.gkind：1=封印中、2=解錠中
execute if score @s br.gkind matches 1 run return run function oa:disaster/relic/sealed
execute if score @s br.gkind matches 2 run function oa:disaster/relic/unlock
