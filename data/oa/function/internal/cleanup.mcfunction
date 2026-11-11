function oa:komame/cleanup
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
tag @s remove oa.night

scoreboard players set @s oa.water 0
scoreboard players set @s oa.wdelay 0
scoreboard players set @s oa.noise 0
tag @s remove oa.water_jump
execute if entity @s[tag=oa.external_glow] unless entity @s[tag=oa.gacha_glow] run effect clear @s minecraft:glowing
tag @s remove oa.external_glow

tag @s remove oa.ambush_active
scoreboard players set @s oa.back 0
scoreboard players set @s oa.wait 0
execute if entity @s[tag=oa.external_weak] run effect clear @s minecraft:weakness
tag @s remove oa.external_weak

scoreboard players set @s oa.shade 0

execute if entity @s[tag=oa.curse_blind] run stopsound @s player minecraft:entity.warden.ambient
execute if entity @s[tag=oa.curse_blind] unless entity @s[tag=oa.gacha_mood] run effect clear @s minecraft:blindness
tag @s remove oa.curse_blind
scoreboard players set @s oa.radar 0
scoreboard players set @s oa.rindex 0
scoreboard players set @s oa.rclock 0
tag @s remove oa.radar_viewer
tag @s remove oa.radar_target

attribute @s minecraft:max_health modifier remove oa:lazi_health
tag @s remove oa.lazi_hp
tag @s remove oa.fish1911

scoreboard players set @s oa.tpush 0

tag @s remove oa.curse_guard

function oa:itori/off
