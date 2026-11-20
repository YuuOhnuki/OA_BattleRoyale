$execute if data storage oa:lobby origin{terminal:202} in minecraft:overworld positioned $(x) $(y) $(z) positioned ~26 ~0 ~20 run return run function oa:lobby/terminal/board_build
$execute in minecraft:overworld positioned $(x) $(y) $(z) run function oa:lobby/board/build_at
data modify storage oa:lobby board_built set value 1b
data modify storage oa:lobby board_ver set value 106
data modify storage oa:lobby board_at set from storage oa:lobby origin
