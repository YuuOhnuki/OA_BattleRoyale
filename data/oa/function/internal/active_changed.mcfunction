function oa:komame/cleanup
tag @s remove oa.fish1911
execute if entity @s[tag=oa.ambush_active] run function oa:yuttari/return
# A live decoy cannot evade its return by switching gear. Death/leave cancel without moving a corpse.
execute if entity @s[tag=oa.self_decoy] unless entity @s[nbt={Health:0.0f}] unless entity @s[gamemode=spectator] run function oa:nero/decoy_return
function oa:nero/decoy_release
attribute @s minecraft:jump_strength modifier remove oa:fish_jump
attribute @s minecraft:movement_speed modifier remove oa:fish
attribute @s minecraft:movement_speed modifier remove oa:curse
attribute @s minecraft:movement_speed modifier remove oa:night
attribute @s minecraft:attack_damage modifier remove oa:night
attribute @s minecraft:armor modifier remove oa:night
execute if entity @s[tag=oa.glow] unless entity @s[tag=oa.gacha_glow] run effect clear @s minecraft:glowing
execute if entity @s[tag=oa.dark] run effect clear @s minecraft:darkness
execute if entity @s[tag=oa.tired] run effect clear @s minecraft:slowness
tag @s remove oa.glow
tag @s remove oa.dark
execute if entity @s[tag=oa.nausea] run effect clear @s minecraft:nausea
tag @s remove oa.nausea
tag @s remove oa.tired
scoreboard players set @s oa.mark 0
scoreboard players set @s oa.decoy 0
scoreboard players set @s oa.breath 0
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:internal/clear_owned with storage oa:args

execute if score @s oa.kind matches 2 run attribute @s minecraft:movement_speed modifier add oa:fish 1.5 add_multiplied_total
execute if score @s oa.kind matches 5 run attribute @s minecraft:movement_speed modifier add oa:curse 1.75 add_multiplied_total
tag @s remove oa.night

scoreboard players set @s oa.sonic 0

scoreboard players set @s oa.shade 0

execute if entity @s[tag=oa.curse_blind] run stopsound @s player minecraft:entity.warden.ambient
execute if entity @s[tag=oa.curse_blind] unless entity @s[tag=oa.gacha_mood] run effect clear @s minecraft:blindness
tag @s remove oa.curse_blind

execute if score @s oa.kind matches 2 run attribute @s minecraft:jump_strength modifier add oa:fish_jump 0.5 add_value

attribute @s minecraft:max_health modifier remove oa:lazi_health
tag @s remove oa.lazi_hp

function oa:itori/off

execute if score @s oa.kind matches 10 run attribute @s minecraft:attack_damage modifier add oa:itori_no_melee -1 add_multiplied_total
