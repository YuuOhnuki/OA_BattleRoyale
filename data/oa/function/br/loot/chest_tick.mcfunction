execute unless block ~ ~ ~ minecraft:chest[type=single] run return 0
execute unless score @s br.round = #round br.round run function oa:br/loot/chest_initial
execute if score #time br.time matches 7200.. if score @s br.cstage matches 0 run function oa:br/loot/chest_upgrade
# 1.9.157: 通常チェストの名前に再補充までの残り時間（br/loot/chest_title）。1秒に1回だけ書き換える
execute if score #perf oa.tmp matches 0 if entity @s[tag=!br.rich] run data modify block ~ ~ ~ CustomName set from storage oa:br chest_title
