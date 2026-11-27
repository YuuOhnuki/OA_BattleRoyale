execute unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run return 0
execute unless items entity @s armor.head *[minecraft:custom_data~{oa:{mask_v161:1b}}] run item modify entity @s armor.head oa:visual/k5
execute unless entity @s[tag=oa.db_keepwear] run item modify entity @s armor.head oa:killing_wear
# 1.9.257：移動速度+175%（1.9.250〜1.9.256 は+150%）・体力の上限を半分（oa:curse_hp。外すと internal/cleanup・active_changed が戻す）
execute unless entity @s[tag=oa.curse_v257] run attribute @s minecraft:movement_speed modifier remove oa:curse
execute unless entity @s[tag=oa.curse_v257] run attribute @s minecraft:movement_speed modifier add oa:curse 1.75 add_multiplied_total
execute unless entity @s[tag=oa.curse_v257] run attribute @s minecraft:max_health modifier remove oa:curse_hp
execute unless entity @s[tag=oa.curse_v257] run attribute @s minecraft:max_health modifier add oa:curse_hp -0.5 add_multiplied_total
tag @s remove oa.curse_v1911
tag @s remove oa.curse_v250
tag @s add oa.curse_v257
execute store result storage oa:args serial int 1 run scoreboard players get @s oa.owner
execute unless entity @s[tag=oa.db_keepwear] run function oa:curse/age with storage oa:args
execute unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run return 0
execute if entity @s[tag=oa.dark] run effect clear @s minecraft:darkness
execute if entity @s[tag=oa.nausea] run effect clear @s minecraft:nausea
tag @s remove oa.dark
tag @s remove oa.nausea
effect give @s minecraft:blindness 2 0 true
tag @s add oa.curse_blind
scoreboard players add @s oa.noise 1
execute if score @s oa.noise matches 1 run playsound minecraft:entity.warden.ambient player @s ~ ~ ~ 6 0.6
execute if score @s oa.noise matches 1 run playsound minecraft:entity.elder_guardian.curse player @s ~ ~ ~ 3 0.7
execute if score @s oa.noise matches 15 run playsound minecraft:entity.goat.screaming.ambient player @s ~ ~ ~ 3 0.6
execute if score @s oa.noise matches 30 run playsound minecraft:block.note_block.didgeridoo player @s ~ ~ ~ 3 0.5
execute if score @s oa.noise matches 40.. run scoreboard players set @s oa.noise 0

execute if score @s oa.radar matches 1.. run function oa:curse/radar/list
scoreboard players set @s oa.radar 0
scoreboard players enable @s oa.radar
