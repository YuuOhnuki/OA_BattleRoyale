# 生成：scripts/gen_disasters.py（直接編集しない）
# 初回は全設定、既存設定には今回変更した間隔だけを移行。重み・安全上限などの個別設定は残す。
execute unless data storage oa:disaster cfg run data modify storage oa:disaster cfg set value {"cd_min":50,"cd_max":75,"first_min":30,"first_max":45,"multi2":20,"multi3":5,"dot_cap":4,"mob_cap":90,"chicken_cap":60,"pig_cap":30,"chicken_population_v":240,"weight":{"k1":10,"k2":10,"k3":10,"k4":10,"k5":10,"k6":10,"k7":7,"k8":7,"k9":7,"k10":7,"k11":7,"k12":8},"v":214}
execute unless data storage oa:disaster cfg{v:214} run function oa:disaster/cfg_migrate214
execute unless data storage oa:disaster cfg{chicken_population_v:240} run function oa:disaster/cfg_chickens240
execute unless data storage oa:disaster cfg.weight.k1 run data modify storage oa:disaster cfg.weight.k1 set value 10
execute unless data storage oa:disaster cfg.weight.k2 run data modify storage oa:disaster cfg.weight.k2 set value 10
execute unless data storage oa:disaster cfg.weight.k3 run data modify storage oa:disaster cfg.weight.k3 set value 10
execute unless data storage oa:disaster cfg.weight.k4 run data modify storage oa:disaster cfg.weight.k4 set value 10
execute unless data storage oa:disaster cfg.weight.k5 run data modify storage oa:disaster cfg.weight.k5 set value 10
execute unless data storage oa:disaster cfg.weight.k6 run data modify storage oa:disaster cfg.weight.k6 set value 10
execute unless data storage oa:disaster cfg.weight.k7 run data modify storage oa:disaster cfg.weight.k7 set value 7
execute unless data storage oa:disaster cfg.weight.k8 run data modify storage oa:disaster cfg.weight.k8 set value 7
execute unless data storage oa:disaster cfg.weight.k9 run data modify storage oa:disaster cfg.weight.k9 set value 7
execute unless data storage oa:disaster cfg.weight.k10 run data modify storage oa:disaster cfg.weight.k10 set value 7
execute unless data storage oa:disaster cfg.weight.k11 run data modify storage oa:disaster cfg.weight.k11 set value 7
execute unless data storage oa:disaster cfg.weight.k12 run data modify storage oa:disaster cfg.weight.k12 set value 8
data modify storage oa:disaster defs set value {"k1":{"key":"acid_rain","name":"酸性雨","danger":4,"stars":"★★★★☆","sec":30,"desc":"屋根の下か頭の防具で防げる","maps":[0]},"k2":{"key":"cold_wave","name":"寒波","danger":4,"stars":"★★★★☆","sec":30,"desc":"屋根の下か革の胸当てで防げる","maps":[0]},"k3":{"key":"meteor","name":"隕石群","danger":5,"stars":"★★★★★","sec":24,"desc":"赤い円から離れるか屋根の下へ","maps":[0,1,2,3,4]},"k4":{"key":"poison_fog","name":"毒霧","danger":4,"stars":"★★★★☆","sec":40,"desc":"中心から広がる。外へ逃げよう","maps":[0,1,2,3,4]},"k5":{"key":"earthquake","name":"地震","danger":3,"stars":"★★★☆☆","sec":10,"desc":"動くとダメージ。止まって耐えよう","maps":[0,1,2,3,4]},"k6":{"key":"fog","name":"濃霧","danger":2,"stars":"★★☆☆☆","sec":30,"desc":"視界が狭くなる","maps":[0,1,2,3,4]},"k7":{"key":"gravity","name":"重力異常","danger":2,"stars":"★★☆☆☆","sec":20,"desc":"高く跳べる。落下ダメージなし","maps":[0,1,2,3,4]},"k8":{"key":"chickens","name":"ニワトリ大量発生","danger":1,"stars":"★☆☆☆☆","sec":20,"desc":"卵に当たると押し飛ばされる","maps":[0,1,2,3,4]},"k9":{"key":"blood_moon","name":"血の月","danger":2,"stars":"★★☆☆☆","sec":30,"desc":"全員が光り、居場所が丸見え","maps":[0,1,2,3,4]},"k10":{"key":"tornado","name":"竜巻","danger":4,"stars":"★★★★☆","sec":30,"desc":"吸い寄せられて打ち上げられる","maps":[0,1]},"k11":{"key":"pig_parade","name":"ブタの大行進","danger":3,"stars":"★★★☆☆","sec":15,"desc":"ブタが爆発しながら走り回る","maps":[0,1,2,3,4]},"k12":{"key":"tower_barrage","name":"塔の砲撃","danger":4,"stars":"★★★★☆","sec":45,"desc":"紫の線が出たら横へ動くか物陰へ","maps":[4]}}
