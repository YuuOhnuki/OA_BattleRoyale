function oa:itori/fx/emit/fire
scoreboard players set #i_flame_ray oa.tmp 0
function oa:itori/flame_ray

particle minecraft:dust{color:[1.0,0.4,0.03],scale:2.0} ^ ^1.2 ^12 0.08 0.4 0.08 0 2 normal @a[distance=..40]
particle minecraft:dust{color:[1.0,0.75,0.15],scale:1.6} ^ ^1.4 ^17 0.08 0.4 0.08 0 1 normal @a[distance=..40]
