execute unless score #state br.state matches 1 run return 0
# 1.9.178: 実績「DQNに屈した」用。帽子の効果を引いた本人に印（試合ごとに ach/reset で外す。帽子を被った人に倒されると ach/trig/dqn）
tag @s[tag=br.playing] add oa.dqn
# 1.9.213: ほかの結果と同じ2行の形（名前は緑、→ 対象：効果 は灰色）
execute as @a[tag=br.playing,tag=!oa.practice] if score @s br.round = #round br.round run tellraw @s {text:"たやゆゆ変態ガチャ：帽子",color:"#12a88f"}
execute as @a[tag=br.playing,tag=!oa.practice] if score @s br.round = #round br.round run tellraw @s {text:" → 生存者1人：ゆうあの帽子を強制装着（古い帽子は消える）",color:"gray"}
scoreboard players operation #hat_cut oa.serial = #serial oa.serial
scoreboard players operation #hat_round oa.serial = #round br.round
execute as @a[tag=br.playing,tag=!oa.practice] if score @s br.round = #round br.round if items entity @s armor.head *[minecraft:custom_data~{oa:{kind:1}}] run function oa:internal/cleanup
execute as @a[tag=br.playing,tag=!oa.practice] if score @s br.round = #round br.round run clear @s *[minecraft:custom_data~{oa:{kind:1}}]
execute if score #map oa.mapid matches 0 in oa:br as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa:{kind:1}}] run function oa:tayayuyu/prune_ground_hat
execute if score #map oa.mapid matches 1 in oa:br_nether as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa:{kind:1}}] run function oa:tayayuyu/prune_ground_hat
execute if score #map oa.mapid matches 2 in oa:br_cave as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa:{kind:1}}] run function oa:tayayuyu/prune_ground_hat
execute if score #map oa.mapid matches 3 in oa:br_sky as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa:{kind:1}}] run function oa:tayayuyu/prune_ground_hat
execute if score #map oa.mapid matches 4 in oa:br_end as @e[distance=0..,type=minecraft:item] if items entity @s contents *[minecraft:custom_data~{oa:{kind:1}}] run function oa:tayayuyu/prune_ground_hat
tag @a[tag=oa.hat_candidate] remove oa.hat_candidate
execute as @a[tag=br.playing,tag=br.alive,tag=!oa.practice,gamemode=!spectator,tag=!oa.dead] if score @s br.round = #round br.round run tag @s add oa.hat_candidate
execute as @a[tag=oa.hat_candidate,sort=random,limit=1] at @s run function oa:tayayuyu/hat
tag @a[tag=oa.hat_candidate] remove oa.hat_candidate
