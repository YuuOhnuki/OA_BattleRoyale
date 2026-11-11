tag @a[tag=oa.caster] remove oa.caster
scoreboard players operation #i_owner oa.tmp = @s oa.owner
execute as @a[tag=br.alive] if score @s oa.id = #i_owner oa.tmp run tag @s add oa.caster
execute as @a[tag=oa.db_free_match] if score @s oa.id = #i_owner oa.tmp run tag @s add oa.caster
