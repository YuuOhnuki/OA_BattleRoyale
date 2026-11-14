tellraw @a[tag=br.playing] {text:"━━ 今回のお題 ━━",color:"gold",bold:true}
execute if score #mission br.tmp matches 1 run tellraw @a[tag=br.playing] {text:"チェストを8個開ける",color:"yellow"}
execute if score #mission br.tmp matches 2 run tellraw @a[tag=br.playing] {text:"1キルする",color:"yellow"}
execute if score #mission br.tmp matches 3 run tellraw @a[tag=br.playing] {text:"6分以上生き残る",color:"yellow"}
execute if score #mission br.tmp matches 4 run tellraw @a[tag=br.playing] {text:"素手（手に何も持たない）で1キルする",color:"yellow"}
execute if score #mission br.tmp matches 5 run tellraw @a[tag=br.playing] {text:"ジャンプを100回する",color:"yellow"}
tellraw @a[tag=br.playing] [{text:"達成すると",color:"gray"},{text:"ごほうび",color:"gray",underlined:true,hover_event:{action:"show_text",value:[{text:"ごほうび\n",color:"gold",bold:true},{text:"回復アイテムを1つ（包帯 または 応急キット）",color:"gray"}]}},{text:"がもらえます。",color:"gray"}]
