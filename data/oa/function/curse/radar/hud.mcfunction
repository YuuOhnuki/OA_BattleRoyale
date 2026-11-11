execute unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run return 0
execute at @s run function oa:curse/radar/nearest
