execute if score @s oa.tutdone matches 1 run return 0
tellraw @s [{text:" ✚ ",color:"aqua"},{text:"はじめての方は ",color:"white"},{text:"[チュートリアル]",color:"aqua",underlined:true,click_event:{action:"run_command",command:"/trigger oa.tutorial set 1"}},{text:"（/trigger oa.tutorial）",color:"gray"}]
