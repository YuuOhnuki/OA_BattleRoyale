execute if items entity @s armor.head * run function oa:inventory/drop {slot:"armor.head"}
$item replace entity @s armor.head from entity @s $(slot)
$item replace entity @s $(slot) with minecraft:air
