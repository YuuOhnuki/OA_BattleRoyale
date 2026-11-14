tag @s add br.supply_drop
scoreboard players set #falling br.tmp 1
summon minecraft:block_display ~ ~90 ~ {Tags:["br.supply_crate","br.supply_main"],block_state:{id:"minecraft:barrel",properties:{facing:"up",open:"false"}},teleport_duration:2,Glowing:1b,glow_color_override:16755200,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.75f,0f,-0.75f],scale:[1.5f,1.5f,1.5f]}}
summon minecraft:block_display ~ ~94 ~ {Tags:["br.supply_crate"],block_state:"minecraft:white_wool",teleport_duration:2,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-2f,0f,-2f],scale:[4f,0.4f,4f]}}
summon minecraft:block_display ~ ~94.4 ~ {Tags:["br.supply_crate"],block_state:"minecraft:red_wool",teleport_duration:2,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-1.2f,0f,-1.2f],scale:[2.4f,0.4f,2.4f]}}
summon minecraft:block_display ~ ~91.5 ~ {Tags:["br.supply_crate"],block_state:{id:"minecraft:iron_chain",properties:{axis:"y"}},teleport_duration:2,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[-0.2f,0f,-0.2f],scale:[0.4f,2.5f,0.4f]}}
title @a[tag=br.playing] times 5 50 15
title @a[tag=br.playing] subtitle [{text:"場所：",color:"white"},{storage:"oa:supply",nbt:"region",interpret:true,color:"aqua",bold:true}]
title @a[tag=br.playing] title {text:"✈ 補給物資が降下中",color:"gold",bold:true}
tellraw @a[tag=br.playing] [{text:"✈ 補給物資が降下中！約9秒後に着地します。",color:"gold",bold:true}]
execute as @a[tag=br.playing] at @s run function oa:br/supply/guide_chat
execute as @a[tag=br.playing] at @s run playsound minecraft:block.beacon.activate player @s ~ ~ ~ 1.5 1.2
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.firework_rocket.launch player @s ~ ~ ~ 1.5 0.8
