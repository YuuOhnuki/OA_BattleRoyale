# 生成：scripts/gen_disasters.py（直接編集しない）
# 単発・複数・全同時とも同じチャット形式。タイトルは共通の「⚠ 災害発生」だけ（1.9.240）。
scoreboard players set #plan_n br.tmp 0
execute if score #p1 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #p2 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #p3 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #p4 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #p5 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #p6 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #p7 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #p8 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #p9 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #p10 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #p11 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #p12 br.tmp matches 1 run scoreboard players add #plan_n br.tmp 1
execute if score #plan_n br.tmp matches 0 run return 0
title @a[tag=br.playing] times 10 50 15
title @a[tag=br.playing] subtitle {"text":"内容はチャットを確認","color":"yellow"}
title @a[tag=br.playing] title {"text":"⚠ 災害発生","color":"dark_red","bold":true}
execute if score #p1 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"酸性雨","bold":true},{"text":"  ★★★★☆"},{"text":"\n    屋根の下か頭の防具で防げる","color":"gray"}]
execute if score #p1 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"酸性雨","bold":true},{"text":"  ★★★★☆"},{"text":"\n    屋根の下か頭の防具で防げる","color":"gray"}]
execute if score #p1 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"酸性雨","bold":true},{"text":"  ★★★★☆"},{"text":"\n    屋根の下か頭の防具で防げる","color":"gray"}]
execute if score #p1 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"酸性雨","bold":true},{"text":"  ★★★★☆"},{"text":"\n    屋根の下か頭の防具で防げる","color":"gray"}]
execute if score #p1 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"酸性雨","bold":true},{"text":"  ★★★★☆"},{"text":"\n    屋根の下か頭の防具で防げる","color":"gray"}]
execute if score #p2 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"寒波","bold":true},{"text":"  ★★★★☆"},{"text":"\n    屋根の下か革の胸当てで防げる","color":"gray"}]
execute if score #p2 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"寒波","bold":true},{"text":"  ★★★★☆"},{"text":"\n    屋根の下か革の胸当てで防げる","color":"gray"}]
execute if score #p2 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"寒波","bold":true},{"text":"  ★★★★☆"},{"text":"\n    屋根の下か革の胸当てで防げる","color":"gray"}]
execute if score #p2 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"寒波","bold":true},{"text":"  ★★★★☆"},{"text":"\n    屋根の下か革の胸当てで防げる","color":"gray"}]
execute if score #p2 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"寒波","bold":true},{"text":"  ★★★★☆"},{"text":"\n    屋根の下か革の胸当てで防げる","color":"gray"}]
execute if score #p3 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"隕石群","bold":true},{"text":"  ★★★★★"},{"text":"\n    赤い円から離れるか屋根の下へ","color":"gray"}]
execute if score #p3 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"火山弾","bold":true},{"text":"  ★★★★★"},{"text":"\n    赤い円から離れるか屋根の下へ","color":"gray"}]
execute if score #p3 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"落盤","bold":true},{"text":"  ★★★★★"},{"text":"\n    赤い円から離れよう","color":"gray"}]
execute if score #p3 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"隕石群","bold":true},{"text":"  ★★★★★"},{"text":"\n    赤い円から離れるか屋根の下へ","color":"gray"}]
execute if score #p3 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"隕石群","bold":true},{"text":"  ★★★★★"},{"text":"\n    赤い円から離れるか屋根の下へ","color":"gray"}]
execute if score #p4 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"毒霧","bold":true},{"text":"  ★★★★☆"},{"text":"\n    中心から広がる。外へ逃げよう","color":"gray"}]
execute if score #p4 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"毒の瘴気","bold":true},{"text":"  ★★★★☆"},{"text":"\n    中心から広がる。外へ逃げよう","color":"gray"}]
execute if score #p4 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"毒霧","bold":true},{"text":"  ★★★★☆"},{"text":"\n    中心から広がる。外へ逃げよう","color":"gray"}]
execute if score #p4 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"毒霧","bold":true},{"text":"  ★★★★☆"},{"text":"\n    中心から広がる。外へ逃げよう","color":"gray"}]
execute if score #p4 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"毒霧","bold":true},{"text":"  ★★★★☆"},{"text":"\n    中心から広がる。外へ逃げよう","color":"gray"}]
execute if score #p5 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"地震","bold":true},{"text":"  ★★★☆☆"},{"text":"\n    動くとダメージ。止まって耐えよう","color":"gray"}]
execute if score #p5 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"地震","bold":true},{"text":"  ★★★☆☆"},{"text":"\n    動くとダメージ。止まって耐えよう","color":"gray"}]
execute if score #p5 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"地震","bold":true},{"text":"  ★★★☆☆"},{"text":"\n    動くとダメージ。止まって耐えよう","color":"gray"}]
execute if score #p5 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"地震","bold":true},{"text":"  ★★★☆☆"},{"text":"\n    動くとダメージ。止まって耐えよう","color":"gray"}]
execute if score #p5 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"地震","bold":true},{"text":"  ★★★☆☆"},{"text":"\n    動くとダメージ。止まって耐えよう","color":"gray"}]
execute if score #p6 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"濃霧","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    視界が狭くなる","color":"gray"}]
execute if score #p6 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"灰嵐","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    視界が狭くなる","color":"gray"}]
execute if score #p6 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"濃霧","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    視界が狭くなる","color":"gray"}]
execute if score #p6 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"濃霧","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    視界が狭くなる","color":"gray"}]
execute if score #p6 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"濃霧","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    視界が狭くなる","color":"gray"}]
execute if score #p7 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"重力異常","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    高く跳べる。落下ダメージなし","color":"gray"}]
execute if score #p7 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"重力異常","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    高く跳べる。落下ダメージなし","color":"gray"}]
execute if score #p7 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"重力異常","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    高く跳べる。落下ダメージなし","color":"gray"}]
execute if score #p7 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"重力異常","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    高く跳べる。落下ダメージなし","color":"gray"}]
execute if score #p7 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"重力異常","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    高く跳べる。落下ダメージなし","color":"gray"}]
execute if score #p8 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"ニワトリ大量発生","bold":true},{"text":"  ★☆☆☆☆"},{"text":"\n    卵に当たると押し飛ばされる","color":"gray"}]
execute if score #p8 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"ニワトリ大量発生","bold":true},{"text":"  ★☆☆☆☆"},{"text":"\n    卵に当たると押し飛ばされる","color":"gray"}]
execute if score #p8 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"ニワトリ大量発生","bold":true},{"text":"  ★☆☆☆☆"},{"text":"\n    卵に当たると押し飛ばされる","color":"gray"}]
execute if score #p8 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"ニワトリ大量発生","bold":true},{"text":"  ★☆☆☆☆"},{"text":"\n    卵に当たると押し飛ばされる","color":"gray"}]
execute if score #p8 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"ニワトリ大量発生","bold":true},{"text":"  ★☆☆☆☆"},{"text":"\n    卵に当たると押し飛ばされる","color":"gray"}]
execute if score #p9 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"血の月","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    全員が光り、居場所が丸見え","color":"gray"}]
execute if score #p9 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"血の月","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    全員が光り、居場所が丸見え","color":"gray"}]
execute if score #p9 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"血の月","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    全員が光り、居場所が丸見え","color":"gray"}]
execute if score #p9 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"血の月","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    全員が光り、居場所が丸見え","color":"gray"}]
execute if score #p9 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"血の月","bold":true},{"text":"  ★★☆☆☆"},{"text":"\n    全員が光り、居場所が丸見え","color":"gray"}]
execute if score #p10 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"竜巻","bold":true},{"text":"  ★★★★☆"},{"text":"\n    吸い寄せられて打ち上げられる","color":"gray"}]
execute if score #p10 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"竜巻","bold":true},{"text":"  ★★★★☆"},{"text":"\n    吸い寄せられて打ち上げられる","color":"gray"}]
execute if score #p10 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"竜巻","bold":true},{"text":"  ★★★★☆"},{"text":"\n    吸い寄せられて打ち上げられる","color":"gray"}]
execute if score #p10 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"竜巻","bold":true},{"text":"  ★★★★☆"},{"text":"\n    吸い寄せられて打ち上げられる","color":"gray"}]
execute if score #p10 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"竜巻","bold":true},{"text":"  ★★★★☆"},{"text":"\n    吸い寄せられて打ち上げられる","color":"gray"}]
execute if score #p11 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"ブタの大行進","bold":true},{"text":"  ★★★☆☆"},{"text":"\n    ブタが爆発しながら走り回る","color":"gray"}]
execute if score #p11 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"ブタの大行進","bold":true},{"text":"  ★★★☆☆"},{"text":"\n    ブタが爆発しながら走り回る","color":"gray"}]
execute if score #p11 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"ブタの大行進","bold":true},{"text":"  ★★★☆☆"},{"text":"\n    ブタが爆発しながら走り回る","color":"gray"}]
execute if score #p11 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"ブタの大行進","bold":true},{"text":"  ★★★☆☆"},{"text":"\n    ブタが爆発しながら走り回る","color":"gray"}]
execute if score #p11 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"ブタの大行進","bold":true},{"text":"  ★★★☆☆"},{"text":"\n    ブタが爆発しながら走り回る","color":"gray"}]
execute if score #p12 br.tmp matches 1 if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"塔の砲撃","bold":true},{"text":"  ★★★★☆"},{"text":"\n    紫の線が出たら横へ動くか物陰へ","color":"gray"}]
execute if score #p12 br.tmp matches 1 if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"塔の砲撃","bold":true},{"text":"  ★★★★☆"},{"text":"\n    紫の線が出たら横へ動くか物陰へ","color":"gray"}]
execute if score #p12 br.tmp matches 1 if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"塔の砲撃","bold":true},{"text":"  ★★★★☆"},{"text":"\n    紫の線が出たら横へ動くか物陰へ","color":"gray"}]
execute if score #p12 br.tmp matches 1 if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"塔の砲撃","bold":true},{"text":"  ★★★★☆"},{"text":"\n    紫の線が出たら横へ動くか物陰へ","color":"gray"}]
execute if score #p12 br.tmp matches 1 if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{"text":"⚠ ","color":"red","bold":true},{"text":"塔の砲撃","bold":true},{"text":"  ★★★★☆"},{"text":"\n    紫の線が出たら横へ動くか物陰へ","color":"gray"}]
