tellraw @s {text:"\n━━ チュートリアル（4/7）━━",color:"gold",bold:true}
tellraw @s {text:"3. 自分の固有武器\n",color:"yellow",bold:true}
tellraw @s {text:"武器は1人につき1つだけ持てます。友人モチーフの特別な武器で、使い方や能力は1つずつ違います。\nロビーの「武器練習場」で、全ての武器を試せます。試合の前に、必ず練習しておきましょう。",color:"white"}
tellraw @s [{text:"[次へ]",color:"green",click_event:{action:"run_command",command:"/trigger oa.tutorial set 5"}},{text:"  "},{text:"[戻る]",color:"yellow",click_event:{action:"run_command",command:"/trigger oa.tutorial set 3"}},{text:"  "}]
