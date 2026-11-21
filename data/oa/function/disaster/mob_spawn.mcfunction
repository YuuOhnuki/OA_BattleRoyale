# 1.9.212：災害の動物を1匹出す（プレイヤーとして実行。引数 kind＝chicken／pig）。全体の上限（cfg.mob_cap）と種類ごとの上限を守る
execute store result score #mob_all br.tmp if entity @e[tag=oa.dis_mob]
execute store result score #mob_capv br.tmp run data get storage oa:disaster cfg.mob_cap
execute if score #mob_all br.tmp >= #mob_capv br.tmp run return 0
$execute store result score #mob_k br.tmp if entity @e[tag=oa.dis_$(kind)]
$execute store result score #mob_capv br.tmp run data get storage oa:disaster cfg.$(kind)_cap
execute if score #mob_k br.tmp >= #mob_capv br.tmp run return 0
execute store result storage oa:disaster m.mx double 0.01 run random value -45..45
execute store result storage oa:disaster m.mz double 0.01 run random value -45..45
$function oa:disaster/mob_summon_$(kind) with storage oa:disaster m
