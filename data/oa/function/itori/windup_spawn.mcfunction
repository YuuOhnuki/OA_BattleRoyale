$kill @e[type=minecraft:item_display,tag=oa.itori_charge_fx,scores={oa.owner=$(id)}]
summon minecraft:item_display ~ ~1 ~ {Tags:["oa.itori_charge_fx","oa.i_fx_new"],item:{id:"minecraft:paper",count:1,components:{"minecraft:item_model":"oa:itori_bolt"}},item_display:"fixed",billboard:"center",view_range:0.5f,teleport_duration:1,brightness:{block:15,sky:15},transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.05f,0.05f,0.05f]}}
scoreboard players operation @e[tag=oa.i_fx_new,limit=1] oa.owner = @s oa.id
scoreboard players operation @e[tag=oa.i_fx_new,limit=1] br.round = #round br.round
data merge entity @e[tag=oa.i_fx_new,limit=1] {start_interpolation:0,interpolation_duration:15,transformation:{translation:[0.0f,0.0f,0.0f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],scale:[0.375f,0.375f,0.375f]}}
tag @e[tag=oa.i_fx_new] remove oa.i_fx_new
function oa:itori/windup_follow with storage oa:itori
