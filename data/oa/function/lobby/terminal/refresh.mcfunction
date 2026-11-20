# 1.9.203: 出撃ターミナルの表示・操作部品だけを置き直す（oa.admin 46）。ブロックは変えない。
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-40 ~ ~-40 run return run tellraw @s {text:"ロビー全体が読み込まれていません。ロビーの中央で実行してください。",color:"yellow"}
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~40 ~ ~40 run return run tellraw @s {text:"ロビー全体が読み込まれていません。ロビーの中央で実行してください。",color:"yellow"}
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-40 ~ ~40 run return run tellraw @s {text:"ロビー全体が読み込まれていません。ロビーの中央で実行してください。",color:"yellow"}
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~40 ~ ~-40 run return run tellraw @s {text:"ロビー全体が読み込まれていません。ロビーの中央で実行してください。",color:"yellow"}
$execute in minecraft:overworld positioned $(x) $(y) $(z) align xyz run function oa:lobby/terminal/entities
function oa:lobby/protect_exhibits
tellraw @s {text:"出撃ターミナルの表示・受付端末・武器展示を置き直しました（建物は変更なし）。",color:"green"}
