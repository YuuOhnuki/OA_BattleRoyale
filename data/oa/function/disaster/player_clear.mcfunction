# 1.9.212：1人分の災害の効果を外す（脱落・ログイン・試合の終わり）。ほかの仕組みの効果（固有武器の属性など）には触れない
attribute @s minecraft:gravity modifier remove oa:dis_gravity
attribute @s minecraft:jump_strength modifier remove oa:dis_gravity
tag @s remove oa.dis_grav
function oa:disaster/fall_off
scoreboard players set @s br.dfall 0
scoreboard players set @s br.dpig 0
tag @s remove oa.dis_air
