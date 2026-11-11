tellraw @s {text:"\n━━ チュートリアル（3/7）━━",color:"gold",bold:true}
tellraw @s {text:"2. まず装備を集めよう\n",color:"yellow",bold:true}
tellraw @s {text:"最初に持っているのは、採掘用のツルハシだけです。\n・チェスト（家や遺跡の塔）を開けて武器や回復を手に入れる\n・石炭の鉱石は食料、レッドストーンの鉱石は回復アイテムが出る\n塔の中のチェストは特に強い装備が入っています。",color:"white"}
tellraw @s [{text:"[次へ]",color:"green",click_event:{action:"run_command",command:"/trigger oa.tutorial set 4"}},{text:"  "},{text:"[戻る]",color:"yellow",click_event:{action:"run_command",command:"/trigger oa.tutorial set 2"}},{text:"  "}]
