summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.furo_emitter","oa.furo_emitter_new"],Invisible:1b,Invulnerable:1b,NoGravity:1b,Silent:1b,Marker:1b}
item replace entity @e[type=minecraft:armor_stand,tag=oa.furo_emitter_new,limit=1] weapon.mainhand with minecraft:paper[minecraft:enchantments={"oa:furo_blast":1},minecraft:custom_data={oa_furo_emitter:true}]
scoreboard players operation @e[tag=oa.furo_emitter_new,limit=1] oa.fowner = #f_owner oa.tmp
scoreboard players operation @e[tag=oa.furo_emitter_new,limit=1] oa.fteam = #f_team oa.tmp
tag @e[tag=oa.furo_emitter_new] remove oa.furo_emitter_new
