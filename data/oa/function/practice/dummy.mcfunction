function oa:debug/dummy_init
tag @s add oa.practice_dummy
function oa:practice/dummy_unname
attribute @s minecraft:max_health base set 20
attribute @s minecraft:armor base set 0
data merge entity @s {Health:20.0f,IsBaby:0b,PersistenceRequired:1b,DeathLootTable:"minecraft:empty"}
scoreboard players operation #practice_spawned oa.tmp = @s oa.id
scoreboard players operation @s oa.kind = #practice_tier oa.tmp
attribute @s minecraft:armor_toughness base set 0
data remove entity @s equipment
data merge entity @s {CanPickUpLoot:0b,drop_chances:{head:0.0f,chest:0.0f,legs:0.0f,feet:0.0f,mainhand:0.0f,offhand:0.0f}}
execute if score @s oa.kind matches 1 run function oa:practice/dummy_armor {material:"leather"}
execute if score @s oa.kind matches 2 run function oa:practice/dummy_armor {material:"chainmail"}
execute if score @s oa.kind matches 3 run function oa:practice/dummy_armor {material:"golden"}
execute if score @s oa.kind matches 4 run function oa:practice/dummy_armor {material:"iron"}
execute if score @s oa.kind matches 5 run function oa:practice/dummy_armor {material:"diamond"}
scoreboard players set @s oa.db_hp 20000
