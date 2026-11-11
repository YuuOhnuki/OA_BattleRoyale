# Share the established enchantment registry entry; dispatch by the actual striking item.
scoreboard players set #taya_hit oa.tmp 0
execute on attacker if items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:9}}] run scoreboard players set #taya_hit oa.tmp 1
execute if score #taya_hit oa.tmp matches 1 run return run function oa:tayayuyu/hit
execute if entity @s[tag=br.pvp_grace] run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
effect give @s minecraft:slowness 2 0 true
tag @s add oa.external_slow
playsound minecraft:block.glass.hit player @a[distance=..24] ~ ~ ~ 0.84 1.5
particle minecraft:snowflake ~ ~1 ~ 0.3 0.5 0.3 0.02 16 normal @a[distance=..24]
particle minecraft:dust{color:[0.65,0.32,0.4],scale:1.1} ~ ~1 ~ 0.3 0.4 0.3 0 8 normal @a[distance=..24]
