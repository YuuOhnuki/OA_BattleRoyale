$item replace entity @s armor.head from entity @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:5,serial:$(serial)}}}}},limit=1] contents
$kill @e[type=minecraft:item,nbt={Item:{components:{"minecraft:custom_data":{oa:{kind:5,serial:$(serial)}}}}}]
