execute if entity @s[tag=oa.gacha_exposed] run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match,tag=!br.alive] run return 0
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return run function oa:combat/protection_notice
execute if entity @s[tag=oa.ambush_active] run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
function oa:combat/select_targets
tag @e[tag=oa.chosen] remove oa.chosen
execute as @e[tag=oa.target,distance=0..,sort=random,limit=1] run tag @s add oa.chosen
execute unless entity @e[tag=oa.chosen] run return run function oa:yuttari/no_target
function oa:nero/save
data modify storage oa:ambush origin set from storage oa:position value
scoreboard players set @s oa.cd 200
function oa:yuttari/teleport_fx
playsound minecraft:entity.warden.roar player @a[distance=..48] ~ ~ ~ 2.4 1.5
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:yuttari/save_origin with storage oa:args
execute at @e[tag=oa.chosen,limit=1] rotated as @e[tag=oa.chosen,limit=1] rotated ~ 0 positioned ^ ^ ^-1.5 run tp @s ~ ~ ~ facing entity @e[tag=oa.chosen,limit=1] feet
execute at @s run rotate @s ~ 0
execute at @s run function oa:yuttari/teleport_fx
effect give @s minecraft:glowing 3 0 true
effect give @e[tag=oa.chosen,limit=1] minecraft:glowing 3 0 true
tag @s add oa.external_glow
tag @e[tag=oa.chosen,limit=1] add oa.external_glow
tag @s add oa.ambush_active
scoreboard players set @s oa.back 20
execute at @s run particle minecraft:reverse_portal ~ ~1 ~ 0.4 0.6 0.4 0.04 24 normal @a[distance=..32]
data modify storage oa:damage amount set value 0.5
data modify storage oa:damage type set value "oa:ambush"
execute as @e[tag=oa.chosen,limit=1] at @s run function oa:combat/gated_damage
execute as @e[tag=oa.chosen,limit=1] at @s if score @s oa.blocked matches 0 unless entity @s[nbt={Health:0.0f}] run function oa:yuttari/queue_push
execute store result score #roll oa.tmp run random value 0..1
execute if score #roll oa.tmp matches 0 run effect give @s minecraft:speed 5 0 true
execute if score #roll oa.tmp matches 0 run effect give @e[tag=oa.chosen] minecraft:slowness 5 0 true
execute if score #roll oa.tmp matches 1 run effect give @s minecraft:slowness 5 0 true
execute if score #roll oa.tmp matches 1 run effect give @e[tag=oa.chosen] minecraft:speed 5 0 true
tag @s add oa.external_slow
tag @s add oa.external_speed
tag @e[tag=oa.chosen] add oa.external_slow
tag @e[tag=oa.chosen] add oa.external_speed
execute at @s run particle minecraft:flash{color:[0.2,0.9,1.0,1.0]} ~ ~ ~ 0 0 0 0 1 normal @a[distance=..32]

tag @e[tag=oa.chosen] remove oa.chosen
function oa:combat/finish

particle minecraft:firework ~ ~1 ~ 0.5 0.7 0.5 0.03 16 normal @a[distance=..24]
