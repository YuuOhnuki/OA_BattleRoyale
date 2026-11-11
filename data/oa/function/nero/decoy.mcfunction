execute if entity @s[tag=oa.debug,tag=!oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match,tag=!br.alive] run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
execute unless score @s oa.kind matches 4 run return 0
function oa:nero/upgrade
function oa:nero/save
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:nero/save_decoy with storage oa:args
summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.nero_anchor","oa.decoy_origin","oa.anchor_new"],Invisible:1b,NoGravity:1b,Invulnerable:1b,Marker:1b,NoBasePlate:1b,Silent:1b}
scoreboard players operation @e[tag=oa.anchor_new,limit=1] oa.id = @s oa.id
scoreboard players operation @e[tag=oa.anchor_new,limit=1] oa.epoch = #epoch oa.epoch
data modify entity @e[tag=oa.anchor_new,limit=1] Rotation set from entity @s Rotation
tag @e[tag=oa.anchor_new] remove oa.anchor_new
scoreboard players operation @s oa.decoy = #decoy oa.decoy
scoreboard players set @s oa.cd 200
tag @s add oa.self_decoy
# Resistance V reduces standard attacks before HP loss, unlike healing after damage.
effect give @s minecraft:resistance 9 4 true
attribute @s minecraft:attack_damage modifier add oa:decoy_disarm -1 add_multiplied_total
attribute @s minecraft:knockback_resistance modifier add oa:decoy_guard 1 add_value
advancement revoke @s only oa:nero/decoy_hit
playsound minecraft:entity.illusioner.cast_spell player @s ~ ~ ~ 0.96 1.1
