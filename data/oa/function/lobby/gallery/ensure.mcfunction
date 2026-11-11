$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-34 ~0 ~-27 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-34 ~0 ~-11 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-34 ~0 ~5 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-34 ~0 ~21 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-34 ~0 ~27 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~34 ~0 ~-27 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~34 ~0 ~-11 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~34 ~0 ~5 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~34 ~0 ~21 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~34 ~0 ~27 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-36 ~0 ~-36 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~36 ~0 ~-36 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-36 ~0 ~36 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~36 ~0 ~36 run return 0
execute unless score #state br.state matches 0 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-32 ~0 ~-18 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-32 ~0 ~-6 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-32 ~0 ~6 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-32 ~0 ~18 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~32 ~0 ~-18 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~32 ~0 ~-6 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~32 ~0 ~6 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~-12 ~0 ~-32 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~12 ~0 ~-32 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~32 ~0 ~18 run return 0
$execute in minecraft:overworld positioned $(x) $(y) $(z) unless loaded ~ ~0 ~-32 run return 0
data modify storage oa:lobby origin.gallery set value 1981
$execute in minecraft:overworld positioned $(x) $(y) $(z) run function oa:lobby/gallery/build
data modify storage oa:lobby origin.gallery set value 1981
