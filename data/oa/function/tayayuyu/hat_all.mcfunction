execute unless score #state br.state matches 1 run return 0
execute as @a[tag=br.playing,tag=!oa.practice] if score @s br.round = #round br.round run tellraw @s {text:"たやゆゆ変態ガチャ：帽子 → 古い帽子を削除し、生存者1人に帽子を強制装着",color:"green"}
scoreboard players operation #hat_cut oa.serial = #serial oa.serial
scoreboard players operation #hat_round oa.serial = #round br.round
execute as @a[tag=br.playing,tag=!oa.practice] if score @s br.round = #round br.round if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run function oa:internal/cleanup
execute as @a[tag=br.playing,tag=!oa.practice] if score @s br.round = #round br.round run clear @s *[minecraft:custom_data~{oa:{kind:1}}]
execute in oa:br as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa:{kind:1}}] run function oa:tayayuyu/prune_ground_hat
tag @a[tag=oa.hat_candidate] remove oa.hat_candidate
execute as @a[tag=br.playing,tag=br.alive,tag=!oa.practice,gamemode=!spectator,nbt=!{Health:0.0f}] if score @s br.round = #round br.round run tag @s add oa.hat_candidate
execute as @a[tag=oa.hat_candidate,sort=random,limit=1] at @s run function oa:tayayuyu/hat
tag @a[tag=oa.hat_candidate] remove oa.hat_candidate
