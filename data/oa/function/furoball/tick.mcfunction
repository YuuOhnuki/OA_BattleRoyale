execute unless entity @s[tag=oa.furo_visual1918] run item modify entity @s contents oa:furo_native_visual
tag @s add oa.furo_visual1918
execute if entity @s[tag=oa.db_projectile] unless entity @a[tag=oa.debug] run return run kill @s
execute unless entity @s[tag=oa.db_projectile] unless score #state br.state matches 1 run return run kill @s
execute unless score @s br.round = #round br.round run return run kill @s
tag @e[tag=oa.f_current] remove oa.f_current
tag @s add oa.f_current
scoreboard players operation #f_owner oa.tmp = @s oa.fowner
scoreboard players operation #f_team oa.tmp = @s oa.fteam
scoreboard players set #f_hit oa.tmp 0
scoreboard players operation @s oa.fvel += #f_accel oa.tmp
scoreboard players operation @s oa.fvel *= #f_air95 oa.tmp
scoreboard players operation @s oa.fvel /= #f_air100 oa.tmp
execute store result storage oa:furo_move step double 0.00000006666666666666667 run scoreboard players get @s oa.fvel
particle minecraft:flame ~ ~ ~ 0.2 0.2 0.2 0.01 3 normal @a[distance=..48]
execute if score #clock oa.beat matches 5.. run particle minecraft:smoke ~ ~ ~ 0.15 0.15 0.15 0.005 1 normal @a[distance=..48]
scoreboard players set #f_step oa.tmp 16
function oa:furoball/step
