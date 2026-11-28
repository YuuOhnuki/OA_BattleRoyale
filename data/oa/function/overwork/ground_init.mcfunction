# 地面に落ちたゆーのアイテム名を表示する。1.9.264：拾える待ち時間はふつうのアイテムと同じ（捨てたら約2秒）。以前は PickupDelay 0 で、渡そうと捨てた本人がすぐ拾い直していた
tag @s add oa.yu_ground
execute if data entity @s Item.components."minecraft:custom_name" run data modify entity @s CustomName set from entity @s Item.components."minecraft:custom_name"
data merge entity @s {CustomNameVisible:1b}
