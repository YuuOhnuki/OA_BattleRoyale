# 1.9.247：吹き飛ぶ標的の広場（練習場の北東）。practice/catalog/build から（練習場の原点で align xyz して実行）
kill @e[tag=oa.kb,distance=..80]
setblock ~16 ~0 ~-34 minecraft:polished_andesite
setblock ~24 ~0 ~-34 minecraft:polished_andesite
summon minecraft:marker ~16.5 ~1 ~-33.5 {Tags:["oa.kb","oa.kb_home","oa.kb_home1"]}
summon minecraft:marker ~24.5 ~1 ~-33.5 {Tags:["oa.kb","oa.kb_home","oa.kb_home2"]}
scoreboard players set @e[type=minecraft:marker,tag=oa.kb_home1,distance=..80] oa.kb_pair 1
scoreboard players set @e[type=minecraft:marker,tag=oa.kb_home2,distance=..80] oa.kb_pair 2
summon minecraft:text_display ~20.5 ~3.6 ~-33.5 {Tags:["oa.kb","oa.practice_catalog"],text:{text:"",extra:[{text:"吹き飛ぶ標的\n",color:"gold",bold:true},{text:"殴ると飛ぶ。3秒で元の場所へ",color:"white"}]},billboard:"center",line_width:200,background:1426063360,shadow:1b,view_range:1.0f,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.9f,0.9f,0.9f]}}
