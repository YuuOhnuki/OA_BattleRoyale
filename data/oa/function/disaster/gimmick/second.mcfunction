# 1秒ごと。配置は試合開始から1秒に1回ずつ試す（最大6個）。動作は生存者の周囲の印だけ処理する。
execute if score #gm_off br.tmp matches 1 run return 0
execute if score #gm_cnt br.tmp matches ..5 if score #gm_try br.tmp matches ..59 if score #time br.time matches ..3600 run function oa:disaster/gimmick/place
execute if score #gm_cnt br.tmp matches 1.. as @a[tag=br.alive,limit=1] at @s as @e[type=minecraft:marker,tag=br.gimmick,distance=..500] at @s run function oa:disaster/gimmick/tick
