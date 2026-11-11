attribute @s minecraft:scale modifier remove oa:komame_small
execute if entity @s[tag=oa.komame_res,nbt={active_effects:[{id:"minecraft:resistance",amplifier:0}]}] run effect clear @s minecraft:resistance
execute if entity @s[tag=oa.komame_hp,nbt={active_effects:[{id:"minecraft:health_boost",amplifier:0}]}] run effect clear @s minecraft:health_boost
tag @s remove oa.komame_res
tag @s remove oa.komame_hp
scoreboard players set @s oa.small 0

execute if entity @s[tag=oa.komame_speed,nbt={active_effects:[{id:"minecraft:speed",amplifier:0}]}] run effect clear @s minecraft:speed
tag @s remove oa.komame_speed
