execute if entity @s[tag=oa.debug,tag=!oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match,tag=!br.alive] run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
execute if score @s oa.mark matches 1.. run return run function oa:nero/return
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:nero/clear_mark with storage oa:args
summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.nero_anchor","oa.nero_mark","oa.anchor_new"],Invisible:1b,NoGravity:1b,Invulnerable:1b,Marker:1b,NoBasePlate:1b,Silent:1b}
scoreboard players operation @e[tag=oa.anchor_new,limit=1] oa.id = @s oa.id
scoreboard players operation @e[tag=oa.anchor_new,limit=1] oa.epoch = #epoch oa.epoch
scoreboard players operation @e[tag=oa.anchor_new,limit=1] oa.steps = #flight oa.tmp
scoreboard players set @e[tag=oa.anchor_new,limit=1] oa.mfx 40
scoreboard players operation @e[tag=oa.anchor_new,limit=1] oa.life = #mark oa.mark
data modify entity @e[tag=oa.anchor_new,limit=1] Rotation set from entity @s Rotation
execute store result score #pitch oa.tmp run data get entity @s Rotation[1] 1000
execute if score #pitch oa.tmp matches ..-1 run data modify entity @e[tag=oa.anchor_new,limit=1] Rotation[1] set value 0.0f
# Save dimension from the player; individual non-player entity NBT does not guarantee Dimension.
function oa:nero/save
function oa:nero/save_owned with storage oa:args
scoreboard players operation @s oa.mark = #mark oa.mark
tag @e[tag=oa.anchor_new] remove oa.anchor_new
playsound minecraft:block.respawn_anchor.charge player @a[distance=..24] ~ ~ ~ 0.84 1.4
particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.5 0.3 0.03 14 normal @a[distance=..32]
