# macro: tag, slot  タグ $(tag) の item の中身を、このマスへ入れて消す
$item replace entity @s $(slot) from entity @e[type=minecraft:item,tag=$(tag),limit=1] contents
$kill @e[type=minecraft:item,tag=$(tag)]
