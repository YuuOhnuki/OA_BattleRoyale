# 登録チェスト（建物の中）の真上に、封印の宝珠を置く。呼び出し元：disaster/init（チェストの印の位置で実行）
summon minecraft:interaction ~ ~0.5 ~ {Tags:["br.relic","br.relic_new"],width:1.0f,height:1.4f,response:1b}
summon minecraft:item_display ~ ~1.3 ~ {Tags:["br.relic","br.relic_disp"],item:{id:"minecraft:heart_of_the_sea",count:1},billboard:"center"}
# 1.9.213: 解錠の方法を明記（近くの人だけに見える）
summon minecraft:text_display ~ ~2.05 ~ {Tags:["br.relic","br.relic_label"],text:[{text:"封印の宝珠\n",color:"light_purple",bold:true},{text:"右クリックで解錠（5秒そばにいる）",color:"white"}],billboard:"center",background:1073741824,shadow:1b,view_range:0.25f,transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],scale:[0.8f,0.8f,0.8f]}}
scoreboard players set @e[type=minecraft:interaction,tag=br.relic_new,distance=..2,limit=1] br.gkind 1
tag @e[type=minecraft:interaction,tag=br.relic_new,distance=..2] remove br.relic_new
