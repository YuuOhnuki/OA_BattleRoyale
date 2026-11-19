scoreboard players set @s oa.blocked 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
damage @s 10 oa:gacha_blast by @a[tag=oa.g_source,limit=1]
