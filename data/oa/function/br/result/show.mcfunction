scoreboard players set #10 br.tmp 10
scoreboard players set #100 br.tmp 100
tellraw @a[tag=br.playing] {text:"━━ 試合リザルト ━━",color:"yellow",bold:true}
execute as @a[tag=br.playing] run function oa:br/result/line
tellraw @a[tag=br.playing] {text:"（与ダメはハート換算ではなくHP値、移動は歩行＋ダッシュ）",color:"dark_gray"}
