tellraw @s {text:"\n━━ チュートリアル（2/7）━━",color:"gold",bold:true}
tellraw @s {text:"1. 参加のしかた\n",color:"yellow",bold:true}
tellraw @s {text:"ロビーで /trigger br.join を実行すると参加できます（やめる時は /trigger br.leave）。チーム戦は、ロビーの羊毛を踏んでチームを選びます。開始は、ホストが緑のパッド（ソロ）か水色のパッド（チーム）に5秒立ちます。\n最初の60秒は、倒されない保護時間です。",color:"white"}
tellraw @s [{text:"[次へ]",color:"green",click_event:{action:"run_command",command:"/trigger oa.tutorial set 3"}},{text:"  "},{text:"[戻る]",color:"yellow",click_event:{action:"run_command",command:"/trigger oa.tutorial set 1"}},{text:"  "}]
