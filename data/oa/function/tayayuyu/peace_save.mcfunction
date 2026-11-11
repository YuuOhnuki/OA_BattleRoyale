scoreboard players set @s oa.gres_amp -1
scoreboard players set @s oa.gres_left 0
execute if data entity @s active_effects[{id:"minecraft:resistance"}] store result score @s oa.gres_amp run data get entity @s active_effects[{id:"minecraft:resistance"}].amplifier
execute if score @s oa.gres_amp matches 0..3 store result score @s oa.gres_left run data get entity @s active_effects[{id:"minecraft:resistance"}].duration
