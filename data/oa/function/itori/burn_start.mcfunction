scoreboard players set @s oa.i_burn 60
scoreboard players set #i_burnby oa.tmp 0
execute as @a[tag=oa.caster,limit=1] run scoreboard players operation #i_burnby oa.tmp = @s oa.id
scoreboard players operation @s oa.i_burnby = #i_burnby oa.tmp
