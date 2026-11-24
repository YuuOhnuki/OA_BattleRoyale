# 1.9.248: 実行者＝候補。らじの足元（#lazi_c*、×100）から水平4・上下6の円柱の中だけダメージ
execute store result score #lazi_dx oa.tmp run data get entity @s Pos[0] 100
execute store result score #lazi_dy oa.tmp run data get entity @s Pos[1] 100
execute store result score #lazi_dz oa.tmp run data get entity @s Pos[2] 100
scoreboard players operation #lazi_dy oa.tmp -= #lazi_cy oa.tmp
execute unless score #lazi_dy oa.tmp matches -600..600 run return 0
scoreboard players operation #lazi_dx oa.tmp -= #lazi_cx oa.tmp
scoreboard players operation #lazi_dz oa.tmp -= #lazi_cz oa.tmp
scoreboard players operation #lazi_dx oa.tmp *= #lazi_dx oa.tmp
scoreboard players operation #lazi_dz oa.tmp *= #lazi_dz oa.tmp
scoreboard players operation #lazi_dx oa.tmp += #lazi_dz oa.tmp
execute unless score #lazi_dx oa.tmp matches ..160000 run return 0
function oa:combat/gated_damage
