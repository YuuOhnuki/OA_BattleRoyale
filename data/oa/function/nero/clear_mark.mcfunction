$data remove storage oa:players p$(id).mark
$execute in minecraft:overworld run kill @e[distance=0..,tag=oa.nero_mark,scores={oa.id=$(id)}]
$execute in oa:br run kill @e[distance=0..,tag=oa.nero_mark,scores={oa.id=$(id)}]
$execute in oa:practice run kill @e[distance=0..,tag=oa.nero_mark,scores={oa.id=$(id)}]
$execute in minecraft:the_nether run kill @e[distance=0..,tag=oa.nero_mark,scores={oa.id=$(id)}]
$execute in minecraft:the_end run kill @e[distance=0..,tag=oa.nero_mark,scores={oa.id=$(id)}]
