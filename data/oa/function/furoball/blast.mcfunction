function oa:furoball/range
execute if score #fb_range oa.tmp matches 0 run return 0
execute if score @s oa.id = #f_owner oa.tmp run return run function oa:furoball/up
execute unless entity @a[tag=oa.f_source,tag=oa.db_friendly] if score #f_team oa.tmp matches 1.. if score @s oa.team = #f_team oa.tmp run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
scoreboard players set @s oa.blocked 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
execute if entity @a[tag=oa.f_source] run damage @s 3 minecraft:explosion by @a[tag=oa.f_source,limit=1]
execute unless entity @a[tag=oa.f_source] run damage @s 3 minecraft:explosion
execute as @a[tag=oa.f_source,limit=1] run function oa:ach/give {id:"furoball_blast",name:"爆風の洗礼"}
