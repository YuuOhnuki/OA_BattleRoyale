# 1.9.221：お題の文言（正本はここ）。#mission br.tmp から storage oa:br mission {name, hard} を作る。hard=1 は難しいお題（ごほうび2倍）
execute if score #mission br.tmp matches 1 run data modify storage oa:br mission set value {name:"チェストを8個開ける",hard:0}
execute if score #mission br.tmp matches 2 run data modify storage oa:br mission set value {name:"1キルする",hard:0}
execute if score #mission br.tmp matches 3 run data modify storage oa:br mission set value {name:"6分以上生き残る",hard:0}
execute if score #mission br.tmp matches 4 run data modify storage oa:br mission set value {name:"素手（手に何も持たない）で1キルする",hard:0}
execute if score #mission br.tmp matches 5 run data modify storage oa:br mission set value {name:"ジャンプを100回する",hard:0}
execute if score #mission br.tmp matches 6 run data modify storage oa:br mission set value {name:"鉱石を5個掘る",hard:0}
execute if score #mission br.tmp matches 7 run data modify storage oa:br mission set value {name:"相手に合計♡×20のダメージを与える",hard:0}
execute if score #mission br.tmp matches 8 run data modify storage oa:br mission set value {name:"合計1000m移動する",hard:0}
execute if score #mission br.tmp matches 9 run data modify storage oa:br mission set value {name:"2キルする",hard:1}
execute if score #mission br.tmp matches 10 run data modify storage oa:br mission set value {name:"9分以上生き残る",hard:1}
execute if score #mission br.tmp matches 11 run data modify storage oa:br mission set value {name:"封印の宝珠を解錠する",hard:1}
execute if score #mission br.tmp matches 12 run data modify storage oa:br mission set value {name:"チェストを15個開ける",hard:1}
