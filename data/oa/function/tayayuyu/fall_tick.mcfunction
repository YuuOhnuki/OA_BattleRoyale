execute if entity @s[gamemode=spectator] run return run function oa:tayayuyu/fall_clear
execute if entity @s[nbt={Health:0.0f}] run return run function oa:tayayuyu/fall_clear
execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=br.alive] run return run function oa:tayayuyu/fall_clear
scoreboard players add @s oa.tfall 1
execute if entity @s[nbt={OnGround:0b}] run tag @s add oa.taya_air
execute if score @s oa.tfall matches 4.. if score @s oa.glift matches 0 if entity @s[nbt={OnGround:1b}] run function oa:tayayuyu/fall_clear
