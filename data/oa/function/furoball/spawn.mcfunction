summon minecraft:item_display ~ ~ ~ {Tags:["oa.furoball","oa.furo_new","oa.furo_visual1918"],item:{id:"minecraft:fire_charge",count:1},item_display:"fixed",billboard:"center",teleport_duration:1,brightness:{block:15,sky:15},transformation:{translation:[0f,0f,0f],left_rotation:[0f,0f,0f,1f],scale:[3f,3f,3f],right_rotation:[0f,0f,0f,1f]}}
tp @e[type=minecraft:item_display,tag=oa.furo_new,limit=1] ~ ~ ~ ~ ~
scoreboard players operation @e[tag=oa.furo_new] oa.fowner = #f_owner oa.tmp
scoreboard players operation @e[tag=oa.furo_new] oa.fteam = #f_team oa.tmp
scoreboard players operation @e[tag=oa.furo_new] br.round = #round br.round
scoreboard players operation @e[tag=oa.furo_new] oa.fvel = #f_accel oa.tmp
execute if entity @s[tag=oa.debug] run tag @e[tag=oa.furo_new] add oa.db_projectile
# 1.9.186: 殴って打ち返すための当たり判定（interaction、0.9ブロック四方）。furoball/tick が毎 tick ボールの位置へ動かす
summon minecraft:interaction ~ ~-0.45 ~ {Tags:["oa.furo_hitbox","oa.furo_new"],width:0.9f,height:0.9f,response:1b}
scoreboard players add #fid oa.tmp 1
scoreboard players operation @e[tag=oa.furo_new] oa.fid = #fid oa.tmp
scoreboard players set @e[type=minecraft:interaction,tag=oa.furo_new] oa.fhb 3
tag @e[tag=oa.furo_new] remove oa.furo_new


