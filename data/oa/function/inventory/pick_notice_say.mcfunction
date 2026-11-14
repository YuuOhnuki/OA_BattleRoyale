# 名前にカーソルを合わせると、そのアイテム（説明文つき）が表示される
$tellraw @a [{selector:"@s",color:"yellow"},{text:" が "},{nbt:'item.components."minecraft:custom_name"',storage:"oa:scan",interpret:true,underlined:true,hover_event:{action:"show_item",id:"$(id)",count:1,components:$(components)}},{text:" を拾いました！",color:"gold"}]
