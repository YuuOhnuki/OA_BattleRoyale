execute if entity @s[tag=tdm.player,tag=!br.alive] run return run function oa:yuttari/cancel
execute if entity @s[tag=tdm.player,scores={tdm.wait=1..}] run return run function oa:yuttari/cancel
execute store result storage oa:args id int 1 run scoreboard players get @s oa.id
function oa:yuttari/load_origin with storage oa:args
tag @s remove oa.ambush_active
scoreboard players set @s oa.back 0
