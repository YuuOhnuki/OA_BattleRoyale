execute if score #state br.state matches 1 as @e[distance=0..,type=minecraft:arrow,tag=!oa.bow_checked,nbt={weapon:{id:"minecraft:bow"}}] run function oa:br/combat/bow_arrow
execute if score #state br.state matches 1 as @e[distance=0..,type=minecraft:spectral_arrow,tag=!oa.bow_checked,nbt={weapon:{id:"minecraft:bow"}}] run function oa:br/combat/bow_arrow
execute if entity @a[tag=oa.gacha_exposed] as @e[distance=0..,type=#oa:gacha_projectiles] run function oa:tayayuyu/projectile_check
execute as @e[distance=0..,type=minecraft:item,tag=!oa.ground] if items entity @s contents *[minecraft:custom_data~{oa:{unique:1b}}] run function oa:ground/init
execute as @e[distance=0..,type=minecraft:item,tag=!oa.yu_ground] if items entity @s contents *[minecraft:custom_data~{oa_overwork:1b}] run function oa:overwork/ground_init
execute as @e[distance=0..,type=minecraft:armor_stand,tag=oa.furo_carrier] at @s run function oa:furoball/carrier/tick
scoreboard players remove @e[distance=0..,type=minecraft:item,tag=oa.ground,scores={oa.wait=1..}] oa.wait 1
kill @e[distance=0..,tag=oa.projectile,scores={oa.wait=0}]
scoreboard players remove @e[distance=0..,tag=oa.projectile,scores={oa.wait=1..}] oa.wait 1
# Loaded stale decoys disappear even if their owner logged out or the pack reloaded.
kill @e[distance=0..,tag=oa.decoy]
execute as @e[distance=0..,type=minecraft:armor_stand,tag=oa.nero_anchor] at @s run function oa:nero/anchor_tick
execute as @e[distance=0..,type=minecraft:marker,tag=oa.note_wave] at @s run function oa:lazi/wave_tick


execute if score #vclock br.tmp matches 0 as @e[type=minecraft:item,tag=oa.ground] at @s if entity @a[tag=oa.player,distance=..32] run function oa:ground/fx
execute if score #vclock br.tmp matches 0 as @e[type=minecraft:item,tag=oa.yu_ground] at @s if entity @a[tag=oa.player,distance=..32] run function oa:overwork/ground

# Snowballs/eggs now use vanilla collision and entity_hurt_player rewards.



function oa:throwable/observe/world


execute as @e[distance=0..,type=minecraft:block_display,tag=oa.gacha_bomb] at @s run function oa:tayayuyu/bomb_tick



execute if entity @e[distance=0..,type=minecraft:item_display,tag=oa.furoball] run function oa:furoball/border_prepare
execute as @e[distance=0..,type=minecraft:item_display,tag=oa.furoball] at @s run function oa:furoball/tick



function oa:debug/world

execute if score #clock oa.beat matches 5.. run function oa:perf/world_maintenance

execute as @e[distance=0..,type=minecraft:interaction,tag=oa.itori_proxy] at @s run function oa:itori/proxy_tick
execute as @e[distance=0..,type=minecraft:item_display,tag=oa.itori_bolt] at @s run function oa:itori/bolt_tick
execute as @e[distance=0..,type=minecraft:marker,tag=oa.itori_sweep] at @s run function oa:itori/sweep_tick

execute as @e[distance=0..,type=minecraft:item_display,tag=oa.itori_fx] at @s run function oa:itori/fx/display_tick
execute as @e[distance=0..,type=minecraft:item_display,tag=oa.itori_shield_mesh] at @s run function oa:itori/fx/shield_validate

execute as @e[distance=0..,type=minecraft:item_display,tag=oa.itori_charge_fx] at @s run function oa:itori/windup_validate

execute as @e[distance=0..,type=minecraft:marker,tag=oa.i_dive_goal] run function oa:itori/dive_validate
execute as @e[distance=0..,type=minecraft:marker,tag=oa.i_dive_apex] run function oa:itori/dive_validate
