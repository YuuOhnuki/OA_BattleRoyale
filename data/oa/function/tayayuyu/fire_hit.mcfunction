scoreboard players set @s oa.blocked 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
execute if entity @s[tag=br.pvp_grace] run return 0
tag @a remove oa.g_source
scoreboard players operation #g_owner oa.tmp = @s oa.gby
execute as @a if score @s oa.id = #g_owner oa.tmp run tag @s add oa.g_source
execute if entity @a[tag=oa.g_source] run damage @s 1 minecraft:in_fire by @a[tag=oa.g_source,limit=1]
execute unless entity @a[tag=oa.g_source] run damage @s 1 minecraft:in_fire
tag @a remove oa.g_source
