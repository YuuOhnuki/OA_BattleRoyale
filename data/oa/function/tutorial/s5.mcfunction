tellraw @s {text:"\n━━ チュートリアル（5/7）━━",color:"gold",bold:true}
tellraw @s {text:"4. 縮んでいくエリア\n",color:"yellow",bold:true}
tellraw @s {text:"時間がたつと、安全なエリアが縮みます。赤い境界の外にいると、ダメージを受けます。最後のエリアは、中央の広場です。\n画面の表示で、次に縮むまでの時間を確認できます。",color:"white"}
tellraw @s [{text:"[次へ]",color:"green",click_event:{action:"run_command",command:"/trigger oa.tutorial set 6"}},{text:"  "},{text:"[戻る]",color:"yellow",click_event:{action:"run_command",command:"/trigger oa.tutorial set 4"}},{text:"  "}]
