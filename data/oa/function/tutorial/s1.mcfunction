tellraw @s {text:"\n━━ チュートリアル（1/7）━━",color:"gold",bold:true}
tellraw @s {text:"ようこそ！\n",color:"yellow",bold:true}
tellraw @s {text:"このゲームは、友人同士で遊ぶバトルロワイヤルです。マップを探索して装備を集め、最後の1人（チーム戦なら最後の1チーム）になれば優勝です。\n慣れていなくても大丈夫。順番に説明します。",color:"white"}
tellraw @s [{text:"[次へ]",color:"green",click_event:{action:"run_command",command:"/trigger oa.tutorial set 2"}},{text:"  "}]
