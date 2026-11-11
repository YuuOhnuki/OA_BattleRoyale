function oa:tayayuyu/stiff_end
function oa:tayayuyu/exposed_end
execute if entity @s[tag=oa.gacha_peace] if data entity @s active_effects[{id:"minecraft:resistance",amplifier:4}] run effect clear @s minecraft:resistance
execute if entity @s[tag=oa.gacha_peace] run function oa:tayayuyu/peace_end
execute if entity @s[tag=oa.gacha_mood] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run effect clear @s minecraft:blindness
execute if entity @s[tag=oa.gacha_glow] unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run effect clear @s minecraft:glowing
attribute @s minecraft:scale modifier remove oa:gacha_size
attribute @s minecraft:movement_speed modifier remove oa:gacha_mood
tag @s remove oa.gacha_size
tag @s remove oa.gacha_mood
tag @s remove oa.gacha_glow
scoreboard players set @s oa.gsize 0
scoreboard players set @s oa.gpeace 0
scoreboard players set @s oa.gmood 0
scoreboard players set @s oa.gglow 0
attribute @s minecraft:max_health modifier remove oa:gacha_hp
attribute @s minecraft:movement_speed modifier remove oa:gacha_speed
execute if entity @s[tag=oa.gacha_lift] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:11}] run effect clear @s minecraft:levitation
tag @s remove oa.gacha_lift
scoreboard players set @s oa.ghp 0
scoreboard players set @s oa.gspeed 0
scoreboard players set @s oa.gfire 0
scoreboard players set @s oa.glift 0

tag @s remove oa.gacha_affected

tag @s remove oa.gacha_hp
tag @s remove oa.gacha_speed

scoreboard players set @s oa.gres_amp -1
scoreboard players set @s oa.gres_left 0
