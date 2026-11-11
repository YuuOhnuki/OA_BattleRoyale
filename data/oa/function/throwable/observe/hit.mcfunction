scoreboard players set #hit oa.tmp 1
scoreboard players set @s oa.blocked 0
execute if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run function oa:curse/roll
execute if score @s oa.blocked matches 1 run return 0
function oa:throwable/push/start
execute if score #obs_snow oa.tmp matches 1 run function oa:throwable/chill
execute if score #obs_snow oa.tmp matches 0 run particle minecraft:crit ~ ~1 ~ 0.25 0.4 0.25 0.01 6 normal @a[distance=..24]

scoreboard players add @s oa.throw_hits 1

execute if entity @a[tag=oa.observe_owner,limit=1] run damage @s 0.1 minecraft:thrown by @a[tag=oa.observe_owner,limit=1]

# Nested damage callbacks may use shared temporary scores. Stop this impact after one victim.
scoreboard players set #hit oa.tmp 1
