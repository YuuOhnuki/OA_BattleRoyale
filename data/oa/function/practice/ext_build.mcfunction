# 1.9.100 practice extension: range lane (south strip), height stations, weapon challenge board
kill @e[tag=oa.practice_landmark,tag=oa.practice_station,distance=..75]
fill ~-45 ~1 ~43 ~45 ~14 ~45 minecraft:air
fill ~-45 ~0 ~43 ~45 ~0 ~45 minecraft:smooth_stone
fill ~-45 ~0 ~44 ~-43 ~0 ~44 minecraft:gold_block
setblock ~-39 ~0 ~43 minecraft:white_concrete
execute positioned ~-39.5 ~1 ~44.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:0}
summon minecraft:text_display ~-39.5 ~3.3 ~44.5 {Tags:["oa.practice_landmark","oa.practice_station"],text:{text:"5m",color:"yellow",bold:true},billboard:"center",shadow:1b,view_range:0.7f}
setblock ~-34 ~0 ~43 minecraft:white_concrete
execute positioned ~-34.5 ~1 ~44.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:0}
summon minecraft:text_display ~-34.5 ~3.3 ~44.5 {Tags:["oa.practice_landmark","oa.practice_station"],text:{text:"10m",color:"yellow",bold:true},billboard:"center",shadow:1b,view_range:0.7f}
setblock ~-24 ~0 ~43 minecraft:white_concrete
execute positioned ~-24.5 ~1 ~44.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:0}
summon minecraft:text_display ~-24.5 ~3.3 ~44.5 {Tags:["oa.practice_landmark","oa.practice_station"],text:{text:"20m",color:"yellow",bold:true},billboard:"center",shadow:1b,view_range:0.7f}
setblock ~-14 ~0 ~43 minecraft:white_concrete
execute positioned ~-14.5 ~1 ~44.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:0}
summon minecraft:text_display ~-14.5 ~3.3 ~44.5 {Tags:["oa.practice_landmark","oa.practice_station"],text:{text:"30m",color:"yellow",bold:true},billboard:"center",shadow:1b,view_range:0.7f}
setblock ~-4 ~0 ~43 minecraft:white_concrete
execute positioned ~-4.5 ~1 ~44.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:0}
summon minecraft:text_display ~-4.5 ~3.3 ~44.5 {Tags:["oa.practice_landmark","oa.practice_station"],text:{text:"40m",color:"yellow",bold:true},billboard:"center",shadow:1b,view_range:0.7f}
summon minecraft:text_display ~-43.5 ~2.4 ~44.5 {Tags:["oa.practice_landmark","oa.practice_station"],text:{text:"射程レーン\nここから東へ狙う",color:"gold"},billboard:"center",shadow:1b,view_range:0.7f}
fill ~14 ~1 ~44 ~16 ~5 ~45 minecraft:stone_bricks
fill ~14 ~6 ~44 ~16 ~6 ~45 minecraft:smooth_stone_slab[type=bottom]
execute positioned ~15.5 ~7 ~44.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:0}
summon minecraft:text_display ~15.5 ~9.3 ~44.5 {Tags:["oa.practice_landmark","oa.practice_station"],text:{text:"高さ6m",color:"yellow",bold:true},billboard:"center",shadow:1b,view_range:0.7f}
fill ~22 ~1 ~44 ~24 ~9 ~45 minecraft:stone_bricks
fill ~22 ~10 ~44 ~24 ~10 ~45 minecraft:smooth_stone_slab[type=bottom]
execute positioned ~23.5 ~11 ~44.5 summon minecraft:marker run function oa:practice/dummy_spawn_init {tier:0}
summon minecraft:text_display ~23.5 ~13.3 ~44.5 {Tags:["oa.practice_landmark","oa.practice_station"],text:{text:"高さ10m",color:"yellow",bold:true},billboard:"center",shadow:1b,view_range:0.7f}
summon minecraft:text_display ~-40.5 ~4.6 ~44.5 {Tags:["oa.practice_landmark","oa.practice_station"],text:[{text:"武器ごとの課題\n",color:"gold",bold:true},{text:"ぴちぴち：高さ6mの的に跳んで当てる\nふろボール：高さ10mの的を狙う\nlazi：音波が届く距離を見る\nネロ：遠い的へ印を飛ばす\nほちきす：拘束して10秒の連続ダメージ\n（/trigger oa.dps で計測）",color:"white"}],billboard:"center",shadow:1b,view_range:0.9f}
