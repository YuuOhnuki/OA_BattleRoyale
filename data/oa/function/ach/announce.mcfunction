# 実績の解除をチャットで知らせる（ach/give から。引数は oa:ach_info.<id> の name・desc）。実績名にカーソルを合わせると説明が出る
$tellraw @a[tag=br.playing] [{text:"◆ ",color:"gold"},{selector:"@s"},{text:" が実績『"},{text:"$(name)",underlined:true,hover_event:{action:"show_text",value:[{text:"$(name)\n",color:"gold",bold:true},{text:"$(desc)",color:"gray"}]}},{text:"』を解除！"}]
$tellraw @s[tag=!br.playing] [{text:"◆ 実績『",color:"yellow"},{text:"$(name)",underlined:true,hover_event:{action:"show_text",value:[{text:"$(name)\n",color:"gold",bold:true},{text:"$(desc)",color:"gray"}]}},{text:"』を解除！"}]
