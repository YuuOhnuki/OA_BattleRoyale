execute as @a[tag=oa.caster,limit=1] run function oa:itori/normal_damage
execute as @e[tag=oa.i_bolt_target,sort=nearest,limit=1] run function oa:itori/bolt_apply
tag @e[tag=oa.i_bolt_target] remove oa.i_bolt_target
particle minecraft:dust{color:[0.8,0.25,1.0],scale:1.2} ~ ~ ~ 0.15 0.15 0.15 0 8 normal @a[distance=..24]
particle minecraft:electric_spark ~ ~ ~ 0.13 0.13 0.13 0.03 6 normal @a[distance=..24]
playsound minecraft:block.amethyst_block.hit player @a[distance=..24] ~ ~ ~ 0.6 1.6
kill @s
