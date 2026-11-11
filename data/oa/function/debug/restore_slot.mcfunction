$execute if items entity @s $(slot) *[minecraft:custom_data~{oa:{kind:5}}] run item modify entity @s $(slot) oa:debug/bind
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_furoball:1b}] run item modify entity @s $(slot) oa:debug/restore_furo_cooldown
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_furoball:1b}] run item modify entity @s $(slot) oa:debug/remove_remainder
$execute if items entity @s $(slot) *[minecraft:custom_data~{br_heal:1b}] run item modify entity @s $(slot) oa:debug/remove_remainder
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_buff:"beer"}] run item modify entity @s $(slot) oa:debug/remove_remainder
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_buff:"doria"}] run item modify entity @s $(slot) oa:debug/remove_remainder
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_buff:"salmon"}] run item modify entity @s $(slot) oa:debug/remove_remainder
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_buff:"paimon"}] run item modify entity @s $(slot) oa:debug/remove_remainder
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_buff:"yuzupon"}] run item modify entity @s $(slot) oa:debug/remove_remainder
$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_buff:"azuki"}] run item modify entity @s $(slot) oa:debug/remove_remainder

$execute if items entity @s $(slot) *[minecraft:custom_data~{oa_db_patch:1b}] run item modify entity @s $(slot) oa:debug/clear_patch
