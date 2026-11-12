# 会場のランプを交互に点滅（無いブロックは触らない）。#fstep の偶奇で点灯・消灯
scoreboard players set #2 br.tmp 2
scoreboard players operation #fpar br.tmp = #fstep br.tmp
scoreboard players operation #fpar br.tmp %= #2 br.tmp
execute if score #fpar br.tmp matches 0 run function oa:br/finale/lamps_on_at
execute if score #fpar br.tmp matches 1 run function oa:br/finale/lamps_off_at
