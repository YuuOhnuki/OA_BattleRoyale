# 1.9.186: 補給の着地点が中心から近すぎないか（マーカーとして）。水平の距離の2乗が #sup_min2 未満なら #sup_good=0
execute store result score #sfx br.tmp run data get entity @s Pos[0]
execute store result score #sfz br.tmp run data get entity @s Pos[2]
execute store result score #scx br.tmp run data get storage oa:br center.x
execute store result score #scz br.tmp run data get storage oa:br center.z
scoreboard players operation #sfx br.tmp -= #scx br.tmp
scoreboard players operation #sfz br.tmp -= #scz br.tmp
scoreboard players operation #sfx br.tmp *= #sfx br.tmp
scoreboard players operation #sfz br.tmp *= #sfz br.tmp
scoreboard players operation #sfx br.tmp += #sfz br.tmp
execute if score #sfx br.tmp < #sup_min2 br.tmp run scoreboard players set #sup_good br.tmp 0
