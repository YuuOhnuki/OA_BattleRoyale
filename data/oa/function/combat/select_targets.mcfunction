tag @e[tag=oa.target] remove oa.target
scoreboard players operation #team oa.team = @s oa.team
tag @s add oa.caster
execute as @a[tag=oa.player,tag=!oa.practice,tag=!oa.caster,gamemode=!spectator] if score @s oa.team matches 0 run tag @s add oa.target
execute as @a[tag=oa.player,tag=!oa.practice,tag=!oa.caster,gamemode=!spectator] unless score @s oa.team = #team oa.team run tag @s add oa.target

execute if entity @s[tag=oa.debug] run function oa:debug/select_targets
# 1.9.187: 模擬戦の相手は、デバッグの標的を選んだあとに足す（以前は先に足していて、練習場ではデバッグの選び直しで消え、ほちきす・lazi・ゆったり・いとりのスキルが模擬戦の相手に効かなかった）
execute if entity @s[tag=oa.spar] as @a[tag=oa.spar,tag=!oa.caster,gamemode=!spectator] run tag @s add oa.target
