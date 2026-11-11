summon minecraft:item_display ~ ~0.08 ~ {Tags:["oa.itori_fx","oa.i_fx_new","oa.i_orange_floor"],view_range:0.0f}
execute positioned ~ ~0.08 ~ run tp @e[type=minecraft:item_display,tag=oa.i_fx_new,limit=1] ~ ~ ~ ~ 0
scoreboard players set @e[tag=oa.i_fx_new,limit=1] oa.i_fxlife 14
scoreboard players operation @e[tag=oa.i_fx_new,limit=1] br.round = #round br.round
tag @e[tag=oa.i_fx_new] remove oa.i_fx_new
