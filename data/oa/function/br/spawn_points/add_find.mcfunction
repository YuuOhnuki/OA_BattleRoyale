# 1.9.155: 登録する高さを、実際の地表にそろえる（位置：x,z はブロックの中心、y は足の高さを切り捨てた値）。
# 土の道・ハーフブロック・ソウルサンドなど高さが1に満たない床では切り捨てで床の中になるので1つ上を、
# ジャンプ中なら下を試す。どこでも立てなければ add_here がいつものメッセージで断る。
function oa:br/spawn_points/check
execute if score #spawn_floor br.flag matches 1 run return run function oa:br/spawn_points/add_here
execute positioned ~ ~1 ~ run function oa:br/spawn_points/check
execute if score #spawn_floor br.flag matches 1 positioned ~ ~1 ~ run return run function oa:br/spawn_points/add_here
execute positioned ~ ~-1 ~ run function oa:br/spawn_points/check
execute if score #spawn_floor br.flag matches 1 positioned ~ ~-1 ~ run return run function oa:br/spawn_points/add_here
execute positioned ~ ~-2 ~ run function oa:br/spawn_points/check
execute if score #spawn_floor br.flag matches 1 positioned ~ ~-2 ~ run return run function oa:br/spawn_points/add_here
function oa:br/spawn_points/add_here
