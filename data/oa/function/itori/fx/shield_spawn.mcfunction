summon minecraft:item_display ~ ~0.9 ~ {Tags:["oa.itori_shield_mesh","oa.i_fx_new"],item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"oa:itori_shield"}},item_display:"fixed",billboard:"fixed",view_range:0.75f,teleport_duration:1,brightness:{block:15,sky:15},transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[2.25f,2.25f,2.25f]}}
scoreboard players operation @e[tag=oa.i_fx_new,limit=1] oa.owner = @s oa.id
scoreboard players operation @e[tag=oa.i_fx_new,limit=1] br.round = #round br.round
tag @e[tag=oa.i_fx_new] remove oa.i_fx_new
