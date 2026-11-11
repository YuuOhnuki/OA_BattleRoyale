execute if score @s br.opened matches 1 run return 0
scoreboard players set @s br.opened 1
scoreboard players set #open_reward br.flag 1
summon minecraft:text_display ~ ~1.2 ~ {Tags:["br.open_label"],text:{text:"開封済み",color:"gray"},billboard:"center",view_range:0.5,background:0,shadow:1b,see_through:1b}
