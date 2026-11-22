scoreboard players add #mp_n oa.tmp 1
execute if score #mp_n oa.tmp matches 5.. run return run scoreboard players set #mp oa.tmp -1
scoreboard players operation #mp oa.tmp += #ms_dir oa.tmp
execute if score #mp oa.tmp matches 5.. run scoreboard players set #mp oa.tmp 0
execute if score #mp oa.tmp matches ..-1 run scoreboard players set #mp oa.tmp 4
execute if score #mp oa.tmp matches 0 if data storage oa:maps saved.br{state:3} run return 1
execute if score #mp oa.tmp matches 1 if data storage oa:maps saved.nether{state:3} run return 1
execute if score #mp oa.tmp matches 2 if data storage oa:maps saved.cave{state:3} run return 1
execute if score #mp oa.tmp matches 3 if data storage oa:maps saved.sky{state:3} run return 1
execute if score #mp oa.tmp matches 4 if data storage oa:maps saved.end{state:3} run return 1
function oa:lobby/mapsel/peek_try
