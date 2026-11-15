# 1.9.186: バニラの防具一式を着る（引数 m = iron / diamond / netherite）。今着ている防具は消える（練習中の荷物）
$item replace entity @s armor.head with minecraft:$(m)_helmet
$item replace entity @s armor.chest with minecraft:$(m)_chestplate
$item replace entity @s armor.legs with minecraft:$(m)_leggings
$item replace entity @s armor.feet with minecraft:$(m)_boots
tellraw @s {text:"バニラの防具を着ました。",color:"green"}
