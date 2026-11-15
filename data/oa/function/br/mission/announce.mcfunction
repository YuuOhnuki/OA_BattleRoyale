# 今回のお題（br/intro の中で1行。1.9.186：見出しと同じ行に、ごほうびは応急キット1つ）
execute if score #mission br.tmp matches 1 run tellraw @a[tag=br.playing] [{text:" ★ 今回のお題  ",color:"gold",bold:true},{text:"チェストを8個開ける",color:"yellow"}]
execute if score #mission br.tmp matches 2 run tellraw @a[tag=br.playing] [{text:" ★ 今回のお題  ",color:"gold",bold:true},{text:"1キルする",color:"yellow"}]
execute if score #mission br.tmp matches 3 run tellraw @a[tag=br.playing] [{text:" ★ 今回のお題  ",color:"gold",bold:true},{text:"6分以上生き残る",color:"yellow"}]
execute if score #mission br.tmp matches 4 run tellraw @a[tag=br.playing] [{text:" ★ 今回のお題  ",color:"gold",bold:true},{text:"素手（手に何も持たない）で1キルする",color:"yellow"}]
execute if score #mission br.tmp matches 5 run tellraw @a[tag=br.playing] [{text:" ★ 今回のお題  ",color:"gold",bold:true},{text:"ジャンプを100回する",color:"yellow"}]
tellraw @a[tag=br.playing] [{text:"    達成すると ",color:"gray"},{text:"応急キット",color:"green"},{text:" を1つもらえます（/trigger oa.mission で確認）",color:"gray"}]
