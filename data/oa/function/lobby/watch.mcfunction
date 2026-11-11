execute unless score #state br.state matches 0 run return 0
execute if score @s br.saved matches 1 run return 0
execute if entity @s[tag=br.watch] run return 0
scoreboard players set @s br.pick 0
tag @s add br.watch
tag @s remove br.lobby
team add oa_watch {text:"観戦者"}
team modify oa_watch color gray
team join oa_watch @s
gamemode spectator @s
tellraw @s [{text:"観戦者になりました。",color:"gray"},{text:"[参加へ戻る]",color:"green",underlined:true,click_event:{action:"run_command",command:"/trigger oa.return"}}]

tellraw @s {text:"[参加者へ戻る]",color:"green",click_event:{action:"run_command",command:"/trigger oa.lobby set 6"}}
