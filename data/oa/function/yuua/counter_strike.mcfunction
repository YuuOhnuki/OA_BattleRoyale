scoreboard players set @s oa.blocked 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
execute if entity @a[tag=oa.yuua_counter_source,limit=1] run damage @s 10000 oa:yuua_counter by @a[tag=oa.yuua_counter_source,limit=1]
