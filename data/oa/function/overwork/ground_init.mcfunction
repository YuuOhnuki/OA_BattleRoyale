# 地面に落ちたゆーを、落とした直後からすぐ拾えるようにする（バニラの拾得待ち40tickを解除）
tag @s add oa.yu_ground
data merge entity @s {PickupDelay:0s}
