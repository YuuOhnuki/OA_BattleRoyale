# macro: slot  預かった元の頭の物を、このマスへ入れる
$item replace entity @s $(slot) from entity @e[type=minecraft:item,tag=oa.hat_hold,limit=1] contents
kill @e[type=minecraft:item,tag=oa.hat_hold]
