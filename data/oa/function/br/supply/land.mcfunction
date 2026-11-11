execute at @s run particle minecraft:explosion_emitter ~ ~ ~ 0 0 0 0 1 force @a[tag=br.playing,distance=..160]
execute at @s run playsound minecraft:entity.generic.explode player @a[tag=br.playing,distance=..100] ~ ~ ~ 2 1.2
kill @e[type=minecraft:block_display,tag=br.supply_crate]
scoreboard players set #falling br.tmp 0
execute as @e[type=minecraft:marker,tag=br.supply_wait,limit=1] at @s run function oa:br/supply/spawn
