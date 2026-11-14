# 試合開始の案内（1.9.157 で文言を変更）
execute if score #mode br.mode matches 0 run tellraw @a[tag=br.playing] [{text:"ソロ戦",color:"gold"},{text:" | 参加"},{score:{name:"#players",objective:"br.tmp"}},{text:"人"}]
execute if score #mode br.mode matches 1 run tellraw @a[tag=br.playing] [{text:"チーム戦",color:"gold"},{text:" | 参加"},{score:{name:"#players",objective:"br.tmp"}},{text:"人"}]
tellraw @a[tag=br.playing] {text:"探索して装備を集め、最後まで生き残ろう。",color:"gray"}
tellraw @a[tag=br.playing] {text:"開始後6分でチェストが再補充されます。",color:"gray"}
