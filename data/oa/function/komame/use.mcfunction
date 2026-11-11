execute if entity @s[tag=oa.gacha_exposed] run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match,tag=!br.alive] run return 0
execute unless score @s oa.kind matches 8 run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
execute if score @s oa.small matches 1.. run return 0
scoreboard players set @s oa.cd 400
scoreboard players set @s oa.small 200
attribute @s minecraft:scale modifier remove oa:komame_small
execute unless entity @s[tag=oa.gacha_size] run attribute @s minecraft:scale modifier add oa:komame_small -0.5 add_multiplied_total
execute unless entity @s[nbt={active_effects:[{id:"minecraft:resistance"}]}] run function oa:komame/resistance
execute unless entity @s[nbt={active_effects:[{id:"minecraft:health_boost"}]}] run function oa:komame/health
playsound minecraft:block.amethyst_block.chime player @a[distance=..24] ~ ~ ~ 3.6 1.4
function oa:komame/fx
playsound minecraft:entity.evoker.cast_spell player @a[distance=..32] ~ ~ ~ 2.16 1.6
particle minecraft:snowflake ~ ~0.8 ~ 0.7 0.7 0.7 0.05 45 normal @a[distance=..32]
particle minecraft:cloud ~ ~0.3 ~ 0.5 0.1 0.5 0.04 18 normal @a[distance=..32]

function oa:komame/speed
playsound minecraft:entity.firework_rocket.twinkle player @a[distance=..32] ~ ~ ~ 2.4 1.5
particle minecraft:firework ~ ~1 ~ 0.7 0.8 0.7 0.07 32 normal @a[distance=..32]
