# 登録チェスト（建物の中）の真上に、封印の宝珠を置く。呼び出し元：disaster/init（チェストの印の位置で実行）
summon minecraft:interaction ~ ~0.5 ~ {Tags:["br.relic","br.relic_new"],width:1.0f,height:1.4f,response:1b}
summon minecraft:item_display ~ ~1.3 ~ {Tags:["br.relic","br.relic_disp"],item:{id:"minecraft:heart_of_the_sea",count:1},billboard:"center",Glowing:1b}
scoreboard players set @e[type=minecraft:interaction,tag=br.relic_new,distance=..2,limit=1] br.gkind 1
tag @e[type=minecraft:interaction,tag=br.relic_new,distance=..2] remove br.relic_new
