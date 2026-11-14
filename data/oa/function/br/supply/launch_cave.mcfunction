# 1.9.167: 洞窟の補給物資。天井の割れ目から鎖で吊り下ろす（7.2ブロック上から、着地まで約9秒＝地上と同じ）。パラシュートはなし
tag @s add br.supply_drop
scoreboard players set #falling br.tmp 1
summon minecraft:block_display ~ ~7.2 ~ {Tags:["br.supply_crate","br.supply_main","br.supply_slow"],block_state:{id:"minecraft:barrel",properties:{facing:"up",open:"false"}},teleport_duration:2,Glowing:1b,glow_color_override:16755200,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.75f,0f,-0.75f],scale:[1.5f,1.5f,1.5f]}}
summon minecraft:block_display ~ ~8.7 ~ {Tags:["br.supply_crate","br.supply_slow"],block_state:{id:"minecraft:iron_chain",properties:{axis:"y"}},teleport_duration:2,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.2f,0f,-0.2f],scale:[0.4f,8f,0.4f]}}
particle minecraft:falling_dust{block_state:"minecraft:stone"} ~ ~8 ~ 0.6 0.2 0.6 0 30 force @a[tag=br.playing,distance=..64]
playsound minecraft:block.stone.break ambient @a[tag=br.playing,distance=..48] ~ ~8 ~ 1.5 0.6
title @a[tag=br.playing] times 5 50 15
title @a[tag=br.playing] subtitle [{text:"場所：",color:"white"},{storage:"oa:supply",nbt:"region",interpret:true,color:"aqua",bold:true}]
title @a[tag=br.playing] title {text:"⛓ 補給物資が降下中",color:"gold",bold:true}
tellraw @a[tag=br.playing] [{text:"⛓ 補給物資が天井から降りてくる！約9秒後に着地します。",color:"gold",bold:true}]
execute as @a[tag=br.playing] at @s run function oa:br/supply/guide_chat
execute as @a[tag=br.playing] at @s run playsound minecraft:block.beacon.activate player @s ~ ~ ~ 1.5 1.2
execute as @a[tag=br.playing] at @s run playsound minecraft:block.chain.place player @s ~ ~ ~ 1.5 0.6
