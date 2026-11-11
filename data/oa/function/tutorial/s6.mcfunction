tellraw @s {text:"\n━━ チュートリアル（6/7）━━",color:"gold",bold:true}
tellraw @s {text:"5. 回復と補給\n",color:"yellow",bold:true}
tellraw @s {text:"包帯は、すぐに使える小さな回復。応急キットは、少し時間をかけて大きく回復します。\n試合中に数回「空中補給」が落ちます。場所は、チャットでお知らせします。強いアイテムは取り合いになるので、慎重に！",color:"white"}
tellraw @s [{text:"[次へ]",color:"green",click_event:{action:"run_command",command:"/trigger oa.tutorial set 7"}},{text:"  "},{text:"[戻る]",color:"yellow",click_event:{action:"run_command",command:"/trigger oa.tutorial set 5"}},{text:"  "}]
