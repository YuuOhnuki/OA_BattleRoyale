execute if score #mode br.mode matches 0 run tellraw @a[tag=br.playing] [{text:"ソロ戦",color:"gold"},{text:"｜参加 "},{score:{name:"#players",objective:"br.tmp"}},{text:"人"}]
execute if score #mode br.mode matches 1 run tellraw @a[tag=br.playing] [{text:"チーム戦",color:"gold"},{text:"｜参加 "},{score:{name:"#players",objective:"br.tmp"}},{text:"人"}]
tellraw @a[tag=br.playing] {text:"探索して装備を集め、縮む安置で最後まで生き残ろう。最初の1分は保護、6分でチェスト補充。",color:"gray"}
