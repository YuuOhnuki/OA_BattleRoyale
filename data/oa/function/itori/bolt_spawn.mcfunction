execute anchored eyes positioned ^ ^ ^0.25 run summon minecraft:item_display ~ ~ ~ {Tags:["oa.itori_bolt","oa.i_new"],item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"oa:itori_bolt"}},item_display:"fixed",billboard:"center",view_range:0.5f,teleport_duration:1,brightness:{block:15,sky:15},transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.9f,0.9f,0.9f]}}
data modify entity @e[tag=oa.i_new,limit=1] Rotation set from entity @s Rotation
scoreboard players operation @e[tag=oa.i_new,limit=1] oa.owner = @s oa.id
scoreboard players operation @e[tag=oa.i_new,limit=1] br.round = #round br.round
scoreboard players set @e[tag=oa.i_new,limit=1] oa.i_range 1
tag @e[tag=oa.i_new] remove oa.i_new
playsound minecraft:entity.evoker.cast_spell player @a[distance=..20] ~ ~ ~ 0.65 1.65
playsound minecraft:block.amethyst_block.chime player @a[distance=..20] ~ ~ ~ 0.4 1.9
