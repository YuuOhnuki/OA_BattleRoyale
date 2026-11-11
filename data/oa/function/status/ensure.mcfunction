tag @s add oa.carrier_dirty
execute if items entity @s armor.head *[minecraft:custom_data~{oa_receiver:1b}] unless items entity @s armor.head #oa:stackable_supplies run return 0
execute if items entity @s armor.chest *[minecraft:custom_data~{oa_receiver:1b}] unless items entity @s armor.chest #oa:stackable_supplies run return 0
execute if items entity @s armor.legs *[minecraft:custom_data~{oa_receiver:1b}] unless items entity @s armor.legs #oa:stackable_supplies run return 0
execute if items entity @s armor.feet *[minecraft:custom_data~{oa_receiver:1b}] unless items entity @s armor.feet #oa:stackable_supplies run return 0
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{oa_receiver:1b}] unless items entity @s weapon.mainhand #oa:stackable_supplies run return 0
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa_receiver:1b}] unless items entity @s weapon.offhand #oa:stackable_supplies run return 0
function oa:status/clear_carriers
execute if items entity @s armor.head * unless items entity @s armor.head #oa:stackable_supplies run return run item modify entity @s armor.head oa:status_add
execute if items entity @s armor.chest * unless items entity @s armor.chest #oa:stackable_supplies run return run item modify entity @s armor.chest oa:status_add
execute if items entity @s armor.legs * unless items entity @s armor.legs #oa:stackable_supplies run return run item modify entity @s armor.legs oa:status_add
execute if items entity @s armor.feet * unless items entity @s armor.feet #oa:stackable_supplies run return run item modify entity @s armor.feet oa:status_add
execute if items entity @s weapon.mainhand * unless items entity @s weapon.mainhand #oa:stackable_supplies run return run item modify entity @s weapon.mainhand oa:status_add
execute if items entity @s weapon.offhand * unless items entity @s weapon.offhand #oa:stackable_supplies run return run item modify entity @s weapon.offhand oa:status_add
# No placeholder and no consumable-stack mutation. Empty equipment cannot carry movement effects.
