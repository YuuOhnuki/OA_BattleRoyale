scoreboard players set #fb_range oa.tmp 0
execute store result score #fb_scale oa.tmp run attribute @s minecraft:scale get 1000
scoreboard players set #fb_ten oa.tmp 10
scoreboard players set #fb_three oa.tmp 3
scoreboard players set #fb_eighteen oa.tmp 18
scoreboard players operation #fb_w oa.tmp = #fb_scale oa.tmp
scoreboard players operation #fb_w oa.tmp *= #fb_three oa.tmp
scoreboard players operation #fb_w oa.tmp /= #fb_ten oa.tmp
scoreboard players operation #fb_h oa.tmp = #fb_scale oa.tmp
scoreboard players operation #fb_h oa.tmp *= #fb_eighteen oa.tmp
scoreboard players operation #fb_h oa.tmp /= #fb_ten oa.tmp
execute store result score #fb_x oa.tmp run data get entity @e[type=minecraft:item_display,tag=oa.f_current,distance=0..,limit=1] Pos[0] 1000
execute store result score #fb_p oa.tmp run data get entity @s Pos[0] 1000
scoreboard players operation #fb_x oa.tmp -= #fb_p oa.tmp
scoreboard players set #fb_neg oa.tmp 0
scoreboard players operation #fb_neg oa.tmp -= #fb_x oa.tmp
execute if score #fb_x oa.tmp matches ..-1 run scoreboard players operation #fb_x oa.tmp = #fb_neg oa.tmp
scoreboard players operation #fb_x oa.tmp -= #fb_w oa.tmp
execute if score #fb_x oa.tmp matches ..0 run scoreboard players set #fb_x oa.tmp 0
scoreboard players operation #fb_x oa.tmp *= #fb_x oa.tmp
execute store result score #fb_y oa.tmp run data get entity @e[type=minecraft:item_display,tag=oa.f_current,distance=0..,limit=1] Pos[1] 1000
execute store result score #fb_p oa.tmp run data get entity @s Pos[1] 1000
scoreboard players operation #fb_y oa.tmp -= #fb_p oa.tmp
# Below the feet, keep the signed offset for squaring. Above the head, subtract body height.
execute if score #fb_y oa.tmp matches 0.. if score #fb_y oa.tmp <= #fb_h oa.tmp run scoreboard players set #fb_y oa.tmp 0
execute if score #fb_y oa.tmp > #fb_h oa.tmp run scoreboard players operation #fb_y oa.tmp -= #fb_h oa.tmp
scoreboard players operation #fb_y oa.tmp *= #fb_y oa.tmp
execute store result score #fb_z oa.tmp run data get entity @e[type=minecraft:item_display,tag=oa.f_current,distance=0..,limit=1] Pos[2] 1000
execute store result score #fb_p oa.tmp run data get entity @s Pos[2] 1000
scoreboard players operation #fb_z oa.tmp -= #fb_p oa.tmp
scoreboard players set #fb_neg oa.tmp 0
scoreboard players operation #fb_neg oa.tmp -= #fb_z oa.tmp
execute if score #fb_z oa.tmp matches ..-1 run scoreboard players operation #fb_z oa.tmp = #fb_neg oa.tmp
scoreboard players operation #fb_z oa.tmp -= #fb_w oa.tmp
execute if score #fb_z oa.tmp matches ..0 run scoreboard players set #fb_z oa.tmp 0
scoreboard players operation #fb_z oa.tmp *= #fb_z oa.tmp
scoreboard players operation #fb_x oa.tmp += #fb_y oa.tmp
scoreboard players operation #fb_x oa.tmp += #fb_z oa.tmp
execute if score #fb_x oa.tmp matches ..12250000 run scoreboard players set #fb_range oa.tmp 1
