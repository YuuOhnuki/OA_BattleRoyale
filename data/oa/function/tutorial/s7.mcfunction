tellraw @s {text:"\n━━ チュートリアル（7/7）━━",color:"gold",bold:true}
tellraw @s {text:"6. もっと楽しむには\n",color:"yellow",bold:true}
tellraw @s {text:"・/trigger oa.achv で実績の一覧\n・/trigger oa.result で前回の試合結果\n・毎試合の「今日のお題」を達成すると、ごほうびがもらえます（/trigger oa.mission で確認）\n以上です。楽しんでください！",color:"white"}
tellraw @s [{text:"[最初から]",color:"aqua",click_event:{action:"run_command",command:"/trigger oa.tutorial set 1"}},{text:"[戻る]",color:"yellow",click_event:{action:"run_command",command:"/trigger oa.tutorial set 6"}},{text:"  "}]
scoreboard players set @s oa.tutdone 1
