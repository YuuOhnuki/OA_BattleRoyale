scoreboard players remove @s br.dtmr 1
data remove entity @s interaction
execute unless entity @a[tag=br.alive,distance=..5] run return run function oa:disaster/relic/cancel
particle minecraft:end_rod ~ ~1.2 ~ 0.25 0.5 0.25 0.02 2 force @a[distance=..64]
scoreboard players operation #rl_m br.tmp = @s br.dtmr
scoreboard players operation #rl_m br.tmp %= #20 br.tmp
execute if score @s br.dtmr matches 1.. if score #rl_m br.tmp matches 0 run function oa:disaster/relic/pulse
execute if score @s br.dtmr matches ..0 run function oa:disaster/relic/finish
