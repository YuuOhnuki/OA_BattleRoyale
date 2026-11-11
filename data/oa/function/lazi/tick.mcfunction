execute unless entity @s[tag=oa.lazi_hp] run attribute @s minecraft:max_health modifier add oa:lazi_health 6 add_value
tag @s add oa.lazi_hp
scoreboard players add @s oa.beat 1
execute if score @s oa.beat matches 1 run playsound minecraft:entity.warden.ambient player @a[distance=..32] ~ ~ ~ 5.33333 0.8 0.666667
execute if score @s oa.breath matches 1.. run effect give @s minecraft:slowness 1 2 true
execute if score @s oa.breath matches 1.. run tag @s add oa.tired
execute if score @s oa.breath matches 0 if entity @s[tag=oa.tired] run effect clear @s minecraft:slowness
execute if score @s oa.breath matches 0 run tag @s remove oa.tired
execute if score @s oa.beat matches 40.. run scoreboard players set @s oa.beat 0

execute if score @s oa.cd matches 0 run function oa:lazi/interval
execute if score @s oa.beat matches 1 run playsound minecraft:entity.ender_dragon.growl player @a[distance=..32] ~ ~ ~ 5.33333 1.6 0.666667
execute if score @s oa.beat matches 20 run playsound minecraft:block.note_block.didgeridoo player @a[distance=..32] ~ ~ ~ 5.33333 0.5 0.666667
execute if score @s oa.beat matches 30 run playsound minecraft:entity.goat.screaming.ambient player @a[distance=..32] ~ ~ ~ 5.33333 1.3 0.666667
