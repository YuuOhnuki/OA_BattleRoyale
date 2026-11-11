# The caster arrived behind the target, so the target's horizontal look is away.
data modify storage oa:kb yaw set from entity @s Rotation[0]
execute store result storage oa:kb id int 1 run scoreboard players get @s oa.id
function oa:knockback/save with storage oa:kb
scoreboard players set @s oa.kpush 20
scoreboard players set @s oa.kboost 1
scoreboard players operation @s oa.kby = @a[tag=oa.caster,limit=1] oa.id
