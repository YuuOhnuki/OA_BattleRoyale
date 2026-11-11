execute unless score @s br.round = #round br.round run return run function oa:itori/kill_effect
function oa:itori/source
execute unless entity @a[tag=oa.caster] run return run function oa:itori/kill_effect
execute if entity @a[tag=oa.caster,tag=oa.gacha_exposed] run return run function oa:itori/kill_effect
scoreboard players set @s oa.i_sub 4
scoreboard players operation #i_bolt_phase oa.tmp = #total oa.gtime
scoreboard players set #i_bolt_four oa.tmp 4
scoreboard players operation #i_bolt_phase oa.tmp %= #i_bolt_four oa.tmp
execute if score #i_bolt_phase oa.tmp matches 0 run scoreboard players set @s oa.i_sub 3
function oa:itori/bolt_step
tag @a[tag=oa.caster] remove oa.caster
