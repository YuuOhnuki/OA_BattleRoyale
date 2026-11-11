execute if entity @s[tag=oa.db_unbind] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run item modify entity @s armor.head oa:debug/unbind
execute unless entity @s[tag=oa.db_unbind] if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run item modify entity @s armor.head oa:debug/bind
function oa:debug/hand {slot:"weapon.mainhand"}
function oa:debug/hand {slot:"weapon.offhand"}
