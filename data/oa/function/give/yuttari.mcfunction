execute unless entity @s[tag=oa.player] run return run tellraw @s {text:"先に /function oa:test/join を実行してください",color:"red"}
scoreboard players add #serial oa.serial 1
execute store result storage oa:args serial int 1 run scoreboard players get #serial oa.serial
function oa:give/internal/yuttari with storage oa:args
