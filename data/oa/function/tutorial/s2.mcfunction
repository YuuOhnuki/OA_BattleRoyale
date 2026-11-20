tellraw @s {text:"\n━━ チュートリアル（2/7）━━",color:"gold",bold:true}
tellraw @s {text:"1. 参加のしかた\n",color:"yellow",bold:true}
tellraw @s {text:"ロビーの正面にある出撃受付で参加します（/oa でも同じ操作ができます）。左がバトルロワイヤル受付、右がチームデスマッチ受付です。チームは受付のチーム端末で選びます。開始は、ホストが受付の「出撃設定」端末から行います。",color:"white"}
tellraw @s [{text:"[次へ]",color:"green",click_event:{action:"run_command",command:"/trigger oa.tutorial set 3"}},{text:"  "},{text:"[戻る]",color:"yellow",click_event:{action:"run_command",command:"/trigger oa.tutorial set 1"}},{text:"  "}]
