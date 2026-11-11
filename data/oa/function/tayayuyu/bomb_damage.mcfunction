scoreboard players set @s oa.blocked 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
$execute if data storage oa:gacha_hits $(ledger).e$(event).p$(victim) run return 0
$data modify storage oa:gacha_hits $(ledger).e$(event).p$(victim) set value 1b
execute if entity @a[tag=oa.g_source] run damage @s 6 minecraft:explosion by @a[tag=oa.g_source,limit=1]
execute unless entity @a[tag=oa.g_source] run damage @s 6 minecraft:explosion
