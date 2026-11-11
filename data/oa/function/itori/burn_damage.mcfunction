tag @a remove oa.caster
scoreboard players operation #i_burnby oa.tmp = @s oa.i_burnby
execute as @a[tag=br.alive] if score @s oa.id = #i_burnby oa.tmp run tag @s add oa.caster
data merge storage oa:damage {amount:1.0,type:"minecraft:on_fire"}
function oa:combat/gated_damage
tag @a remove oa.caster
