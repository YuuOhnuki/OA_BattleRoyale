execute store result storage oa:kb id int 1 run scoreboard players get @s oa.id
function oa:knockback/save with storage oa:kb
scoreboard players set @s oa.kpush 3
scoreboard players operation @s oa.kby = @a[tag=oa.caster,limit=1] oa.id

scoreboard players set @s oa.kboost 0
