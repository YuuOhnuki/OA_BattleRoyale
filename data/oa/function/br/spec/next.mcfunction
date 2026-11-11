execute unless score #state br.state matches 1 run return 0
scoreboard players operation #cur br.tmp = @s br.sp
scoreboard players set #best br.tmp 2147483647
scoreboard players set #min br.tmp 2147483647
execute as @a[tag=br.alive,nbt=!{Health:0.0f}] if score @s br.pid < #min br.tmp run scoreboard players operation #min br.tmp = @s br.pid
execute as @a[tag=br.alive,nbt=!{Health:0.0f}] if score @s br.pid > #cur br.tmp if score @s br.pid < #best br.tmp run scoreboard players operation #best br.tmp = @s br.pid
execute if score #best br.tmp matches 2147483647 run scoreboard players operation #best br.tmp = #min br.tmp
execute if score #best br.tmp matches 2147483647 run return run tellraw @s {text:"観戦できる生存者がいません。",color:"yellow"}
scoreboard players operation @s br.sp = #best br.tmp
function oa:br/spec/attach
