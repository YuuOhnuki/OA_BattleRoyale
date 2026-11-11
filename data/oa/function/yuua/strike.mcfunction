execute if entity @s[tag=br.pvp_grace] run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute as @e[tag=oa.hat_victim,limit=1] at @s run particle minecraft:crit ~ ~1 ~ 0.4 0.5 0.4 0.05 15 normal @a[distance=..32]
function oa:yuua/silence_begin
damage @e[tag=oa.hat_victim,limit=1] 10000 oa:execution by @s
function oa:yuua/silence_end
execute if entity @e[tag=oa.hat_victim,nbt={Health:0.0f},limit=1] run tellraw @a [{selector:"@e[tag=oa.hat_victim,limit=1]"},{text:" はゆうあ財閥（資金提供者"},{selector:"@s"},{text:"）によってOA鯖を永久追放された",color:"light_purple"}]
