scoreboard players add #serial oa.serial 1
execute store result storage oa:args serial int 1 run scoreboard players get #serial oa.serial
execute store result score #kind br.tmp run random value 1..160
execute if score #kind br.tmp matches 1..10 if score #yuua_issued br.tmp matches 1 run execute store result score #kind br.tmp run random value 11..160
execute if score #kind br.tmp matches 1..10 run function oa:give/internal/yuua with storage oa:args
execute if score #kind br.tmp matches 11..25 run function oa:give/internal/pichipichi with storage oa:args
execute if score #kind br.tmp matches 26..40 run function oa:give/internal/lazi with storage oa:args
execute if score #kind br.tmp matches 41..55 run function oa:give/internal/nero with storage oa:args
execute if score #kind br.tmp matches 56..70 run function oa:give/internal/killing with storage oa:args
execute if score #kind br.tmp matches 71..85 run function oa:give/internal/yuttari with storage oa:args
execute if score #kind br.tmp matches 86..100 run function oa:give/internal/hotchikisu with storage oa:args
execute if score #kind br.tmp matches 101..115 run function oa:give/internal/overwork
execute if score #kind br.tmp matches 116..130 run function oa:give/internal/komame with storage oa:args

execute if score #kind br.tmp matches 131..145 run function oa:give/internal/tayayuyu with storage oa:args

execute if score #kind br.tmp matches 146..160 run function oa:give/internal/itori with storage oa:args
