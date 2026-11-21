# 移動速度と跳躍力を0にする（名前 oa:countdown。向きは変えられる）
attribute @s minecraft:movement_speed modifier remove oa:countdown
attribute @s minecraft:movement_speed modifier add oa:countdown -1 add_multiplied_total
attribute @s minecraft:jump_strength modifier remove oa:countdown
attribute @s minecraft:jump_strength modifier add oa:countdown -1 add_multiplied_total
tag @s add oa.countdown
