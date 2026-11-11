scoreboard players set @s br.saved 0
execute store result storage oa:br_args id int 1 run scoreboard players get @s oa.id
function oa:br/snapshot with storage oa:br_args
