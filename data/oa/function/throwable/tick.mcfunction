# Execute from each snowball/egg, before native movement. Owner and team attribution
# are selected from the projectile's native origin relationship, not nearest player.
tag @a[tag=oa.caster] remove oa.caster
tag @e[tag=oa.target] remove oa.target
execute on origin run function oa:throwable/owner
execute unless entity @a[tag=oa.caster] run return 0
tag @s add oa.throw_current
scoreboard players set #hit oa.tmp 0
scoreboard players set #ray oa.tmp 6
execute store result score #mx oa.tmp run data get entity @s Motion[0] 10000
execute store result score #my oa.tmp run data get entity @s Motion[1] 10000
execute store result score #mz oa.tmp run data get entity @s Motion[2] 10000
scoreboard players set #five oa.tmp 5
scoreboard players operation #mx oa.tmp /= #five oa.tmp
scoreboard players operation #my oa.tmp /= #five oa.tmp
scoreboard players operation #mz oa.tmp /= #five oa.tmp
execute store result storage oa:throw_step x double 0.0001 run scoreboard players get #mx oa.tmp
execute store result storage oa:throw_step y double 0.0001 run scoreboard players get #my oa.tmp
execute store result storage oa:throw_step z double 0.0001 run scoreboard players get #mz oa.tmp
summon minecraft:marker ~ ~ ~ {Tags:["oa.throw_probe"]}
execute as @e[type=minecraft:marker,tag=oa.throw_probe,limit=1] at @s run function oa:throwable/ray
kill @e[type=minecraft:marker,tag=oa.throw_probe]
execute if score #hit oa.tmp matches 1 run kill @s
tag @s remove oa.throw_current
execute as @a[tag=oa.caster,limit=1] run function oa:combat/finish
