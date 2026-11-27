# 1.9.253: 頭へ強制装着する前に、いま被っている物を一時的に預かる（inventory/release_head で空いているマスへ入れる）
# 固有武器（キリングのお面など）は従来どおり足もとへ落とす。預けられなかったときは頭に残す（呼び出し側は上書きしない）
execute unless items entity @s armor.head * run return 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{unique:1b}}] run return run function oa:inventory/drop {slot:"armor.head"}
summon minecraft:item ~ ~0.5 ~ {Tags:["oa.hat_hold"],PickupDelay:32767s,NoGravity:1b,Invulnerable:1b,Item:{id:"minecraft:stone",count:1}}
execute store success score #ok oa.tmp run item replace entity @e[type=minecraft:item,tag=oa.hat_hold,limit=1] contents from entity @s armor.head
execute if score #ok oa.tmp matches 1 run item replace entity @s armor.head with minecraft:air
execute if score #ok oa.tmp matches 0 run kill @e[type=minecraft:item,tag=oa.hat_hold]
