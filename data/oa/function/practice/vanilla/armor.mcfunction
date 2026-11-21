execute unless entity @s[tag=oa.practice] run return 0
execute unless dimension oa:practice run return 0
$data modify storage oa:practice_request armor set value "$(m)"
execute unless data storage oa:practice_request {armor:"leather"} unless data storage oa:practice_request {armor:"chainmail"} unless data storage oa:practice_request {armor:"iron"} unless data storage oa:practice_request {armor:"diamond"} run return run tellraw @s {text:"この防具はバトルロワイヤルに出現しません。",color:"yellow"}
$item replace entity @s armor.head with minecraft:$(m)_helmet
$item replace entity @s armor.chest with minecraft:$(m)_chestplate
$item replace entity @s armor.legs with minecraft:$(m)_leggings
$item replace entity @s armor.feet with minecraft:$(m)_boots
tellraw @s {text:"バニラの防具を着ました。",color:"green"}
