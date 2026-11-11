execute on vehicle if entity @s[type=minecraft:armor_stand,tag=oa.furo_carrier] run function oa:furoball/carrier/release
execute if entity @s[tag=oa.furo_up] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:62}] run effect clear @s minecraft:levitation
execute if entity @s[tag=oa.furo_up] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:31}] run effect clear @s minecraft:levitation
execute if entity @s[tag=oa.furo_up] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:72}] run effect clear @s minecraft:levitation
execute if entity @s[tag=oa.furo_up] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:44}] run effect clear @s minecraft:levitation
tag @s remove oa.furo_up
scoreboard players set @s oa.fup 0
