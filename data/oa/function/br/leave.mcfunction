execute if entity @s[tag=br.playing] run return run function oa:br/surrender
execute if entity @s[team=oa_br1] run team leave @s
execute if entity @s[team=oa_br2] run team leave @s
execute if entity @s[team=oa_br3] run team leave @s
execute if entity @s[team=oa_br4] run team leave @s
execute if entity @s[team=oa_br5] run team leave @s
execute if entity @s[team=oa_br6] run team leave @s
execute if entity @s[team=oa_br7] run team leave @s
execute if entity @s[team=oa_br8] run team leave @s
execute if entity @s[team=oa_br9] run team leave @s
execute if entity @s[team=oa_br10] run team leave @s
scoreboard players set @s br.pick 0
tag @s remove br.lobby
# 1.9.186: 参加しない印。ロビーに入り直しても自動では登録しない（羊毛でチームを選ぶ・「ゲームに参加」・/trigger br.join で外れる）
tag @s add br.optout
tellraw @s [{text:"参加登録を解除しました。ロビー（練習場）で待てます。",color:"gray"},{text:" [参加する]",color:"green",underlined:true,click_event:{action:"run_command",command:"/trigger br.join"}}]
