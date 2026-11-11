execute unless entity @s[tag=oa.practice_dummy] unless entity @a[tag=oa.debug,distance=..64] run return run function oa:br/world/remove_mob
execute if entity @s[nbt={Health:0.0f}] run return 0
execute if entity @s[tag=oa.practice_dummy,tag=oa.taya_fall] run return run function oa:practice/dummy_flight
execute if entity @s[tag=oa.practice_dummy] run data merge entity @s {Motion:[0.0d,0.0d,0.0d]}
execute unless entity @s[tag=oa.practice_dummy] run data merge entity @s {Health:1024.0f,Motion:[0.0d,0.0d,0.0d]}
execute unless entity @s[tag=oa.practice_dummy] run scoreboard players set @s oa.db_hp 1024000
execute store result storage oa:debug_dummy args.id int 1 run scoreboard players get @s oa.id
function oa:debug/dummy_pin with storage oa:debug_dummy args
