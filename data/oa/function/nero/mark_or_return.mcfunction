execute if entity @s[tag=oa.debug,tag=!oa.db_free_match] unless score #state br.state matches 1 run return 0
execute if entity @s[tag=oa.debug,tag=!oa.db_free_match,tag=!br.alive] run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute if entity @s[tag=oa.decoy_grace] run return 0
execute if score @s oa.mark matches 1.. run return run function oa:nero/return
execute unless entity @s[tag=oa.db_free_cd] if score @s oa.cd matches 1.. run return 0
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:nero/clear_mark with storage oa:args
summon minecraft:armor_stand ~ ~ ~ {Tags:["oa.nero_anchor","oa.nero_mark","oa.anchor_new"],Invisible:1b,NoGravity:1b,Invulnerable:1b,Marker:1b,NoBasePlate:1b,Silent:1b}
scoreboard players operation @e[tag=oa.anchor_new,limit=1] oa.id = @s oa.id
scoreboard players operation @e[tag=oa.anchor_new,limit=1] oa.epoch = #epoch oa.epoch
scoreboard players operation @e[tag=oa.anchor_new,limit=1] oa.steps = #flight oa.tmp
scoreboard players set @e[tag=oa.anchor_new,limit=1] oa.mfx 40
# 1.9.187: 印の目印（光るエンダーアイ）。プラグインが本人以外から隠す（プラグインがないと全員に見える）。nero/mark_tick が印について動かす
summon minecraft:item_display ~ ~1.2 ~ {Tags:["oa.nero_vis","oa.vis_new"],item:{id:"minecraft:ender_eye",count:1},billboard:"center",Glowing:1b,glow_color_override:11158783,brightness:{block:15,sky:15},teleport_duration:2,transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.6f,0.6f,0.6f]}}
scoreboard players operation @e[type=minecraft:item_display,tag=oa.vis_new] oa.id = @s oa.id
scoreboard players set @e[type=minecraft:item_display,tag=oa.vis_new] oa.mvis 3
tag @e[type=minecraft:item_display,tag=oa.vis_new] remove oa.vis_new
data modify entity @e[tag=oa.anchor_new,limit=1] Rotation set from entity @s Rotation
execute store result score #pitch oa.tmp run data get entity @s Rotation[1] 1000
# 1.9.186: 真下に近い向き（75°以上）なら自分の場所に置く。それ以外は（上・下とも）水平に進む
data modify entity @e[tag=oa.anchor_new,limit=1] Rotation[1] set value 0.0f
execute if score #pitch oa.tmp matches 75000.. run scoreboard players set @e[tag=oa.anchor_new,limit=1] oa.steps 0
scoreboard players set @e[tag=oa.anchor_new,limit=1] oa.mclimb 99
# Save dimension from the player; individual non-player entity NBT does not guarantee Dimension.
function oa:nero/save
function oa:nero/save_owned with storage oa:args
scoreboard players operation @s oa.mark = #mark oa.mark
tag @e[tag=oa.anchor_new] remove oa.anchor_new
# 1.9.224：スキルの音は本人だけ（デコイのデバフ・テレポートの音はほかの人にも）
playsound minecraft:block.respawn_anchor.charge player @s ~ ~ ~ 0.84 1.4
# 1.9.186: 印の粒は本人にだけ
particle minecraft:reverse_portal ~ ~1 ~ 0.3 0.5 0.3 0.03 14 normal @s
