execute if entity @s[tag=oa.g_oni] run return 0
# 1.9.253: 元の頭の物は、空いているマス（取り出したマスを含む）へ入れる。固有武器・空きなしは従来どおり足もとへ
function oa:inventory/hold_head
execute if items entity @s armor.head * run return 0
$item replace entity @s armor.head from entity @s $(slot)
$item replace entity @s $(slot) with minecraft:air
function oa:inventory/release_head
