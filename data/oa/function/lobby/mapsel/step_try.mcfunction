scoreboard players add #ms_n oa.tmp 1
execute if score #ms_n oa.tmp matches 3.. run return run tellraw @s {text:"ほかに生成済みのマップがありません。管理者に生成してもらってください。",color:"yellow"}
scoreboard players operation #ms oa.tmp += #ms_dir oa.tmp
execute if score #ms oa.tmp matches 3.. run scoreboard players set #ms oa.tmp 0
execute if score #ms oa.tmp matches ..-1 run scoreboard players set #ms oa.tmp 2
execute if score #ms oa.tmp matches 0 if data storage oa:maps saved.br{state:3} run return run function oa:lobby/mapsel/pick {key:"br"}
execute if score #ms oa.tmp matches 1 if data storage oa:maps saved.nether{state:3} run return run function oa:lobby/mapsel/pick {key:"nether"}
execute if score #ms oa.tmp matches 2 if data storage oa:maps saved.cave{state:3} run return run function oa:lobby/mapsel/pick {key:"cave"}
function oa:lobby/mapsel/step_try
