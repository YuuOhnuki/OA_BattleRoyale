execute unless score #state br.state matches 1 run return 0
scoreboard players operation #cur br.tmp = @s br.sp
scoreboard players set #best br.tmp -1
scoreboard players set #max br.tmp -1
execute as @a[tag=br.alive,nbt=!{Health:0.0f}] run scoreboard players operation #max br.tmp > @s br.pid
execute as @a[tag=br.alive,nbt=!{Health:0.0f}] if score @s br.pid < #cur br.tmp run scoreboard players operation #best br.tmp > @s br.pid
execute if score #best br.tmp matches -1 run scoreboard players operation #best br.tmp = #max br.tmp
execute if score #best br.tmp matches -1 run return run tellraw @s {text:"観戦できる生存者がいません。",color:"yellow"}
scoreboard players operation @s br.sp = #best br.tmp
function oa:br/spec/attach
