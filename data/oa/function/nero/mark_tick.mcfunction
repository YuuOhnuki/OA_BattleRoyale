# 1.9.186: 1 tick に 0.25m を4回（1m/tick）。ブロックをすり抜けないよう細かく調べる。段差は nero/mark_step で上がる
execute if score @s oa.steps matches 1.. at @s rotated as @s positioned ^ ^ ^0.25 run function oa:nero/mark_step
execute if score @s oa.steps matches 1.. at @s rotated as @s positioned ^ ^ ^0.25 run function oa:nero/mark_step
execute if score @s oa.steps matches 1.. at @s rotated as @s positioned ^ ^ ^0.25 run function oa:nero/mark_step
execute if score @s oa.steps matches 1.. at @s rotated as @s positioned ^ ^ ^0.25 run function oa:nero/mark_step
scoreboard players remove @s[scores={oa.steps=1..}] oa.steps 1
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:nero/checkpoint with storage oa:args
# 1.9.186: 印の粒は本人にだけ見せる（oa.mark_owner は nero/anchor_tick が付ける）
# 1.9.187: 印の粒は、置いたあともずっと本人に見せる（以前は最初の2秒だけ）
execute if score #clock oa.beat matches 5.. at @s run particle minecraft:reverse_portal ~ ~0.8 ~ 0.12 0.3 0.12 0.02 3 normal @a[tag=oa.mark_owner]
# 1.9.187: 目印（光るエンダーアイ）を印について動かす。動かされなくなると3 tick で消える（world_tick）
execute at @s as @e[type=minecraft:item_display,tag=oa.nero_vis,distance=..64] if score @s oa.id = #owner oa.id run function oa:nero/vis_follow
scoreboard players remove @s[scores={oa.mfx=1..}] oa.mfx 1
