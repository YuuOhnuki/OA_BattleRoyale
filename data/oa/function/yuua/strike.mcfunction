# 1.9.185: 倒された人は @e では選べない（死んだエンティティは @e の対象外。@a は選べる）ので、相手は @a で選ぶ。
# 以前は固有キルログ（ゆうあ財閥…）の条件と名前が @e で、ログが出ないことがあった（飛び道具で倒したときなど）
execute if entity @s[tag=br.pvp_grace] run return 0
execute if entity @s[tag=oa.self_decoy] run return 0
execute as @a[tag=oa.hat_victim,limit=1] at @s run particle minecraft:crit ~ ~1 ~ 0.4 0.5 0.4 0.05 15 normal @a[distance=..32]
function oa:yuua/silence_begin
damage @a[tag=oa.hat_victim,limit=1] 10000 oa:execution by @s
function oa:yuua/silence_end
execute if entity @a[tag=oa.hat_victim,tag=oa.dead,limit=1] run tellraw @a [{selector:"@a[tag=oa.hat_victim,limit=1]"},{text:" はゆうあ財閥（資金提供者"},{selector:"@s"},{text:"）によってOA鯖を永久追放された",color:"light_purple"}]
