# 1.9.186: 印を0.25m進める。ふさがっていたら、半ブロック（0.55）・1ブロック（1.05）上がれるなら上がって進む（段差・ハーフブロック）。
# 上がった直後（3回以内）にまた上がる＝壁なので止まる（oa.mclimb は前に上がってからの回数）
execute if score #state br.state matches 1 run function oa:br/border/check_position
execute if score #state br.state matches 1 if score #inside br.flag matches 0 run return run scoreboard players set @s oa.steps 0
execute unless loaded ~ ~ ~ run return run scoreboard players set @s oa.steps 0
scoreboard players add @s oa.mclimb 1
execute if function oa:nero/mark_clear run return run tp @s ~ ~ ~
execute if score @s oa.mclimb matches ..3 run return run scoreboard players set @s oa.steps 0
execute positioned ~ ~0.55 ~ if function oa:nero/mark_clear run return run function oa:nero/mark_climb
execute positioned ~ ~1.05 ~ if function oa:nero/mark_clear run return run function oa:nero/mark_climb
scoreboard players set @s oa.steps 0
