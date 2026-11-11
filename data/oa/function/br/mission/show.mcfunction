execute unless score #state br.state matches 1 run return run tellraw @s {text:"お題は試合中に表示されます。",color:"yellow"}
tellraw @s {text:"━━ 今日のお題 ━━",color:"gold",bold:true}
execute if score #mission br.tmp matches 1 run tellraw @s {text:"チェストを8個開ける",color:"yellow"}
execute if score #mission br.tmp matches 2 run tellraw @s {text:"1キルする",color:"yellow"}
execute if score #mission br.tmp matches 3 run tellraw @s {text:"6分以上生き残る",color:"yellow"}
execute if score #mission br.tmp matches 4 run tellraw @s {text:"素手（手に何も持たない）で1キルする",color:"yellow"}
execute if score #mission br.tmp matches 5 run tellraw @s {text:"ジャンプを100回する",color:"yellow"}
execute if score @s br.mdone matches 1 run tellraw @s {text:"（達成済み）",color:"green"}
