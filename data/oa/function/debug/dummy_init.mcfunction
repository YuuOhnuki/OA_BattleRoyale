function oa:debug/target_init
tag @s add oa.debug_dummy
attribute @s minecraft:max_health base set 1024
attribute @s minecraft:knockback_resistance base set 1
attribute @s minecraft:movement_speed base set 0
data merge entity @s {Health:1024.0f,NoAI:1b,NoGravity:1b,Silent:1b,CustomName:{text:"不動・回復する練習標的",color:"gold"},CustomNameVisible:1b}
scoreboard players set @s oa.db_hp 1024000
execute store result storage oa:debug_dummy args.id int 1 run scoreboard players get @s oa.id
function oa:debug/dummy_save with storage oa:debug_dummy args
