# 1.9.253: 元の頭の物はインベントリの空きへ（固有武器は従来どおり足もとへ）
function oa:inventory/hold_head
$item replace entity @s armor.head from entity @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:5,serial:$(serial)}}}}},limit=1] contents
$kill @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:5,serial:$(serial)}}}}}]
function oa:inventory/release_head
