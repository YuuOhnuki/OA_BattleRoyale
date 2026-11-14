execute if score @s br.opened matches 1 run return 0
scoreboard players set @s br.opened 1
scoreboard players set #open_reward br.flag 1
# 1.9.159: 通常チェストの札は、再補充までの残り時間つき（br/loot/open_label が毎秒書き換える）。特別チェストは「開封済み」のまま
execute if entity @s[tag=br.rich] run summon minecraft:text_display ~ ~1.2 ~ {Tags:["br.open_label","br.open_rich"],text:{text:"開封済み",color:"gray"},billboard:"center",view_range:0.5,background:0,shadow:1b,see_through:1b}
execute if entity @s[tag=!br.rich] run summon minecraft:text_display ~ ~1.2 ~ {Tags:["br.open_label","br.open_new"],text:{text:"開封済み",color:"gray"},billboard:"center",view_range:0.5,background:0,shadow:1b,see_through:1b}
execute positioned ~ ~1.2 ~ as @e[type=minecraft:text_display,tag=br.open_new,distance=..0.15] run data modify entity @s text set from storage oa:br open_label
execute positioned ~ ~1.2 ~ run tag @e[type=minecraft:text_display,tag=br.open_new,distance=..0.15] remove br.open_new
