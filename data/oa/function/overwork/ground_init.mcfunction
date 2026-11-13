# 地面に落ちたゆーを、落とした直後からすぐ拾えるようにし、アイテム名を表示する
tag @s add oa.yu_ground
data merge entity @s {PickupDelay:0s}
execute if data entity @s Item.components."minecraft:custom_name" run data modify entity @s CustomName set from entity @s Item.components."minecraft:custom_name"
data merge entity @s {CustomNameVisible:1b}
