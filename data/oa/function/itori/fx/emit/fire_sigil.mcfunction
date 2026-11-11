summon minecraft:item_display ~ ~0.06 ~ {Tags:["oa.itori_fx","oa.i_fx_new","oa.i_fire_floor"],item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"oa:itori_fire_sigil"}},item_display:"fixed",billboard:"fixed",view_range:0.75f,teleport_duration:1,brightness:{block:15,sky:15},transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[12f,1f,12f]}}
execute positioned ~ ~0.06 ~ run tp @e[type=minecraft:item_display,tag=oa.i_fx_new,limit=1] ~ ~ ~ ~ 0
scoreboard players set @e[tag=oa.i_fx_new,limit=1] oa.i_fxlife 21
scoreboard players operation @e[tag=oa.i_fx_new,limit=1] br.round = #round br.round
tag @e[tag=oa.i_fx_new] remove oa.i_fx_new
