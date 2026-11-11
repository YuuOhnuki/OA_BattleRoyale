kill @e[tag=oa.exhibit_itori,distance=..60]
fill ~10 ~0 ~29 ~14 ~0 ~33 minecraft:chiseled_quartz_block
setblock ~12 ~0 ~31 minecraft:sea_lantern
summon minecraft:mannequin ~12.5 ~1 ~31.5 {Tags:["oa.lobby_exhibit","oa.gallery","oa.exhibit_itori"],profile:{name:"itori0814"},pose:"standing",immovable:1b,hide_description:1b,Invulnerable:1b,NoGravity:1b,Silent:1b,PersistenceRequired:1b,Rotation:[180f,0f]}
item replace entity @e[type=minecraft:mannequin,tag=oa.exhibit_itori,limit=1] weapon.mainhand with minecraft:carrot_on_a_stick[minecraft:item_model="oa:itori"]
summon minecraft:text_display ~12.5 ~4 ~31.5 {Tags:["oa.lobby_label","oa.gallery","oa.exhibit_itori"],text:{text:"昭心\nitori0814",color:"gold"},billboard:"center",background:1073741824,shadow:1b,line_width:200,view_range:0.5f}
setblock ~12 ~0 ~28 minecraft:chiseled_quartz_block
setblock ~12 ~1 ~28 minecraft:stone_button[face=floor,facing=north,powered=false]
summon minecraft:interaction ~12.5 ~1 ~28.5 {Tags:["oa.gallery","oa.gallery_button","oa.gallery_12","oa.gallery_new","oa.exhibit_itori"],width:0.9f,height:0.75f,response:1b}
scoreboard players set @e[type=minecraft:interaction,tag=oa.gallery_new] oa.gallery_id 12
scoreboard players set @e[type=minecraft:interaction,tag=oa.gallery_new] oa.exbtn -1
tag @e[tag=oa.gallery_new] remove oa.gallery_new

summon minecraft:text_display ~12.5 ~2.05 ~28.5 {Tags:["oa.lobby_label","oa.gallery","oa.exhibit_itori"],text:{text:"詳細ボタン［右クリック］",color:"aqua"},billboard:"center",background:0,shadow:1b,line_width:160,view_range:0.3f}
