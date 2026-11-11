execute if score @s oa.tutdone matches 1 run return 0
tellraw @s [{text:"[ヒント] ",color:"aqua"},{text:"はじめての方は /trigger oa.tutorial でチュートリアルが見られます。",color:"white",click_event:{action:"run_command",command:"/trigger oa.tutorial set 1"}}]
