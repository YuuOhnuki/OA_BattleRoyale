data modify storage oa:ally_entry uuid set from entity @s UUID
execute store result storage oa:ally_entry x int 1 run data get entity @s Pos[0]
execute store result storage oa:ally_entry y int 1 run data get entity @s Pos[1]
execute store result storage oa:ally_entry z int 1 run data get entity @s Pos[2]
function oa:br/ui/teammates/append with storage oa:ally_entry
