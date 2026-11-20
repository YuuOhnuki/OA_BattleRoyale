execute if items entity @s container.* *[minecraft:custom_data~{oa_overwork:1b}] run return 0
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa_overwork:1b}] run return 0
tag @s add tdm.yu_equip
function oa:give/overwork
tag @s remove tdm.yu_equip
