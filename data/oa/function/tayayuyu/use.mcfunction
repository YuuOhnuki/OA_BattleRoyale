execute if entity @s[tag=oa.gacha_exposed] run return 0
execute if entity @s[tag=oa.db_free_match] run return run function oa:debug/gacha/use
execute unless entity @s[tag=oa.db_free_grace] if entity @s[tag=br.pvp_grace] run return run function oa:combat/protection_notice
execute unless entity @s[tag=oa.db_free_match] unless score #state br.state matches 1 run return run tellraw @s {text:"試合中に使用してください。",color:"yellow"}
execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=br.alive] run return 0
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
scoreboard players set @s oa.cd 900
scoreboard players operation #gacha_caster oa.tmp = @s oa.id
scoreboard players add #serial oa.serial 1
scoreboard players operation #gacha_event oa.tmp = #serial oa.serial
execute store result score #gacha_roll oa.tmp run random value 1..15
playsound minecraft:block.end_portal.spawn player @a[tag=br.playing] ~ ~ ~ 1.2 1.5
particle minecraft:totem_of_undying ~ ~1 ~ 0.7 1 0.7 0.2 60 normal @a[distance=..48]
execute if score #gacha_roll oa.tmp matches 1 run function oa:tayayuyu/health_all
execute if score #gacha_roll oa.tmp matches 2 run function oa:tayayuyu/fire_all
execute if score #gacha_roll oa.tmp matches 3 run function oa:tayayuyu/revive_all
execute if score #gacha_roll oa.tmp matches 4 run function oa:tayayuyu/hat_all
execute if score #gacha_roll oa.tmp matches 5 run function oa:tayayuyu/bomb_all
execute if score #gacha_roll oa.tmp matches 6 run function oa:tayayuyu/tiny_all
execute if score #gacha_roll oa.tmp matches 7 run function oa:tayayuyu/shuffle
execute if score #gacha_roll oa.tmp matches 8 run function oa:tayayuyu/gather
execute if score #gacha_roll oa.tmp matches 9 run function oa:tayayuyu/mood_all
execute if score #gacha_roll oa.tmp matches 10 run function oa:tayayuyu/reveal_all
execute if score #gacha_roll oa.tmp matches 11 run function oa:tayayuyu/hunger_all
execute if score #gacha_roll oa.tmp matches 12 run function oa:tayayuyu/giant_all
execute if score #gacha_roll oa.tmp matches 13 run function oa:tayayuyu/critical
execute if score #gacha_roll oa.tmp matches 14 run function oa:tayayuyu/stiff
execute if score #gacha_roll oa.tmp matches 15 run function oa:tayayuyu/exposed
