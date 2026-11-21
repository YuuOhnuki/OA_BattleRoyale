# 1.9.212：通常の災害の抽選。発生が決まったら、同時に起こる数を 1（75%）・2（20%）・3（5%）で決め（cfg.multi2・multi3）、
# このマップの災害から重み（cfg.weight.kN）で重複なく選ぶ。前回と同じ災害はなるべく避ける。5秒後に始まる
execute unless data storage oa:br center run return 0
function oa:disaster/available
function oa:disaster/plan_clear
execute store result score #r100 br.tmp run random value 1..100
execute store result score #m2 br.tmp run data get storage oa:disaster cfg.multi2
execute store result score #m3 br.tmp run data get storage oa:disaster cfg.multi3
scoreboard players set #want br.tmp 1
scoreboard players set #lim br.tmp 100
scoreboard players operation #lim br.tmp -= #m2 br.tmp
scoreboard players operation #lim br.tmp -= #m3 br.tmp
execute if score #r100 br.tmp > #lim br.tmp run scoreboard players set #want br.tmp 2
scoreboard players operation #lim br.tmp += #m2 br.tmp
execute if score #r100 br.tmp > #lim br.tmp run scoreboard players set #want br.tmp 3
scoreboard players set #avoid_last br.tmp 1
function oa:disaster/pick_n
execute if score #plan_n br.tmp matches 0 run return 0
function oa:disaster/plan_commit
