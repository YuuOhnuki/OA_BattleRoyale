execute store result storage oa:br_args id int 1 run scoreboard players get @s oa.id
function oa:br/erase_backup with storage oa:br_args
scoreboard players set @s br.saved 0
