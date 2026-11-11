scoreboard players set #g_restore_res oa.tmp 0
execute unless entity @s[tag=oa.self_decoy] if data entity @s active_effects[{id:"minecraft:resistance",amplifier:4}] run scoreboard players set #g_restore_res oa.tmp 1
execute if score #g_restore_res oa.tmp matches 1 run effect clear @s minecraft:resistance
execute if score #g_restore_res oa.tmp matches 1 if score @s oa.gres_amp matches 0..3 if score @s oa.gres_left matches 1.. run function oa:tayayuyu/peace_restore
tag @s remove oa.gacha_peace
execute if score #time br.time matches 1200.. run tag @s remove br.pvp_grace
execute if score #state br.state matches 1 if entity @s[tag=br.playing] run function oa:br/grace/restore_team
