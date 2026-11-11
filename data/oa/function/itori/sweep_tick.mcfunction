execute unless score @s br.round = #round br.round run return run function oa:itori/kill_effect
function oa:itori/source
execute unless entity @a[tag=oa.caster] run return run function oa:itori/kill_effect
execute if entity @a[tag=oa.caster,tag=oa.gacha_exposed] run return run function oa:itori/kill_effect
execute at @a[tag=oa.caster,limit=1] run tp @s ~ ~ ~
execute at @s run function oa:itori/sweep_work
scoreboard players operation #i_sweep_phase oa.tmp = @s oa.i_frame
scoreboard players set #i_sweep_four oa.tmp 4
scoreboard players operation #i_sweep_phase oa.tmp %= #i_sweep_four oa.tmp
execute if score #i_sweep_phase oa.tmp matches 3 run function oa:itori/source
execute if score #i_sweep_phase oa.tmp matches 3 if entity @a[tag=oa.caster,tag=!oa.gacha_exposed] at @s run function oa:itori/sweep_work
tag @a[tag=oa.caster] remove oa.caster
