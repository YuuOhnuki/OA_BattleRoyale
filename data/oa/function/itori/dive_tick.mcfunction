execute unless entity @s[tag=br.alive] unless entity @s[tag=oa.db_free_match] run return run function oa:itori/dive_cancel
scoreboard players remove @s oa.i_dive 1
execute if score @s oa.i_dive matches 36 run function oa:itori/dive_rise_frame {steps:14}
execute if score @s oa.i_dive matches 35 run function oa:itori/dive_rise_frame {steps:11}
execute if score @s oa.i_dive matches 34 run function oa:itori/dive_rise_frame {steps:10}
execute if score @s oa.i_dive matches 33 run function oa:itori/dive_rise_frame {steps:9}
execute if score @s oa.i_dive matches 32 run function oa:itori/dive_rise_frame {steps:8}
execute if score @s oa.i_dive matches 31 run function oa:itori/dive_rise_frame {steps:7}
execute if score @s oa.i_dive matches 30 run function oa:itori/dive_rise_frame {steps:6}
execute if score @s oa.i_dive matches 29 run function oa:itori/dive_rise_frame {steps:5}
execute if score @s oa.i_dive matches 28 run function oa:itori/dive_rise_frame {steps:4}
execute if score @s oa.i_dive matches 27 run function oa:itori/dive_rise_frame {steps:3}
execute if score @s oa.i_dive matches 26 run function oa:itori/dive_rise_frame {steps:2}
execute if score @s oa.i_dive matches 25 run function oa:itori/dive_rise_frame {steps:1}
execute if score @s oa.i_dive matches 25 at @s run function oa:itori/dive_apex
execute if score @s oa.i_dive matches 20..24 run function oa:itori/dive_hover
execute if score @s oa.i_dive matches 19 run playsound minecraft:entity.breeze.wind_burst player @a[distance=..32] ~ ~ ~ 0.8 0.7
execute if score @s oa.i_dive matches 1..19 run function oa:itori/dive_fast
execute if score @s oa.i_dive matches 0 run function oa:itori/dive_cancel
particle minecraft:electric_spark ~ ~0.8 ~ 0.3 0.6 0.3 0.06 5 normal @a[distance=..28]
