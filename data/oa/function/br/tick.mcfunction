execute if score #state br.state matches 3 run function oa:br/celebration/tick
scoreboard players add #vclock br.tmp 1
execute if score #vclock br.tmp matches 10.. run scoreboard players set #vclock br.tmp 0
execute if score #state br.state matches 0 if score #vclock br.tmp matches 0 as @a[scores={br.preview=1..}] at @s run function oa:br/zone/visual
scoreboard players remove @a[scores={br.preview=1..}] br.preview 1
execute if score #state br.state matches 0 as @a[tag=br.lobby,scores={br.saved=0}] at @s run function oa:br/team/select
execute as @a[tag=!oa.practice,scores={br.saved=1,br.retry=0}] unless score @s br.round = #round br.round at @s unless entity @s[nbt={Health:0.0f}] run function oa:br/recover
execute if score #state br.state matches 0 as @a[tag=!oa.practice,scores={br.saved=1,br.retry=0}] at @s unless entity @s[nbt={Health:0.0f}] run function oa:br/recover
execute unless score #state br.state matches 1 run return 0
scoreboard players add #time br.time 1
function oa:br/day/tick
function oa:br/weather/tick
execute if score #time br.time matches 2400 in oa:br run worldborder set 230 60s
execute if score #time br.time matches 4800 in oa:br run worldborder set 160 60s
execute if score #time br.time matches 7200 in oa:br run worldborder set 90 60s
execute if score #time br.time matches 10800 in oa:br run worldborder set 20 60s
execute if score #time br.time matches 12000 in oa:br run worldborder set 2 60s
scoreboard players add #pulse br.tmp 1
execute if score #time br.time matches 10800.. run function oa:br/finale/tick
execute as @a[tag=br.playing,tag=br.alive] unless score @s br.left = @s oa.left at @s run function oa:br/surrender
execute as @a[tag=br.playing,tag=br.alive,nbt={Health:0.0f}] at @s run function oa:br/eliminate
execute as @a[tag=br.playing,tag=!br.alive,tag=!br.gm_override,gamemode=!spectator] run gamemode spectator @s
execute if score #state br.state matches 1 as @a[tag=br.playing,tag=!br.alive,tag=!oa.spec_init,gamemode=spectator] run function oa:br/spec/begin
execute if score #time br.time matches 1200 as @a[tag=br.spawn_protection] run effect clear @s minecraft:resistance
execute if score #time br.time matches 1200 run tag @a[tag=br.playing] remove br.spawn_protection
execute if score #time br.time matches 1200 run function oa:br/protection_end
execute if score #pulse br.tmp matches 20.. run function oa:br/second

execute if score #state br.state matches 1 as @a[tag=br.playing] at @s run function oa:br/zone/visual_stagger

execute if score #state br.state matches 1 if score #vclock br.tmp matches 0 as @a[tag=br.playing] run function oa:br/zone/hud
execute if score #state br.state matches 1 if score #vclock br.tmp matches 5 as @a[tag=br.playing] run function oa:br/zone/hud

execute if score #state br.state matches 1 as @a[tag=br.playing,scores={br.open=1..}] at @s run function oa:br/loot/open_sound

execute if score #time br.time matches ..1199 as @a[tag=br.alive,tag=br.pvp_grace] run effect give @s minecraft:resistance 2 4 true

execute if score #time br.time matches 2340 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 2360 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 2380 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 4740 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 4760 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 4780 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 7140 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 7160 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 7180 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 10740 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 10760 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 10780 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 11940 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 11960 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
execute if score #time br.time matches 11980 as @a[tag=br.playing] at @s run playsound minecraft:block.bell.use player @s ~ ~ ~ 1 1
