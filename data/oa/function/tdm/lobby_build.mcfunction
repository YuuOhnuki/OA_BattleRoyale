execute if data storage oa:lobby origin.terminal run return run data modify storage oa:lobby tdm_station set value 1b
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~8 ~ ~33 run return 0
execute in minecraft:overworld run kill @e[tag=tdm.station]
$execute in minecraft:overworld positioned $(x) $(y) $(z) run fill ~7 ~-1 ~32 ~9 ~-1 ~34 minecraft:orange_wool
$execute in minecraft:overworld positioned $(x) $(y) $(z) run setblock ~8 ~ ~34 minecraft:chiseled_stone_bricks
$execute in minecraft:overworld positioned $(x) $(y) $(z) run setblock ~8 ~1 ~34 minecraft:stone_button[face=floor]
$execute in minecraft:overworld positioned $(x) $(y) $(z) run summon minecraft:marker ~8 ~1 ~34 {Tags:["tdm.station","tdm.button"]}
$execute in minecraft:overworld positioned $(x) $(y) $(z) run summon minecraft:text_display ~8 ~2.5 ~34 {Tags:["oa.lobby_label","tdm.station"],text:{text:"ゲームモード・TDM準備\nボタンで選択メニュー",color:"gold"},billboard:"center",background:0}
data modify storage oa:lobby tdm_station set value 1b
