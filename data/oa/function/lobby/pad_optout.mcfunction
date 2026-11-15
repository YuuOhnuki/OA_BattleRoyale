# 1.9.190: 今あるロビーに不参加パッドを1回だけ置く（ロビーを建て直さなくてよいように。lobby/tick から、引数はロビーの原点）。
# 置く場所が読み込まれていなければ、次の機会に回す
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-8 ~ ~33 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) run fill ~-9 ~-1 ~32 ~-7 ~-1 ~34 minecraft:brown_wool
kill @e[type=minecraft:text_display,tag=oa.optout_label]
$execute in minecraft:overworld positioned $(x) $(y) $(z) run summon minecraft:text_display ~-8 ~1 ~33.5 {Tags:["oa.lobby_label","oa.optout_label"],text:{text:"不参加\n（ロビー・練習場で待つ）",color:"#b07040"},billboard:"center",background:0}
data modify storage oa:lobby optout_pad set value 1b
