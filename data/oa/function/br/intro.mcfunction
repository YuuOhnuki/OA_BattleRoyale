# 試合開始の案内（1.9.186：見やすく、1つのまとまりに。罫線・空行・見出し。以前は保護期間・お題・案内が別々に出ていた）
# br/start から：intro → 初心者サポート・ヒント（本人だけ）→ intro_end の順
tellraw @a[tag=br.playing] {text:""}
tellraw @a[tag=br.playing] {text:"━━━━━━━━━━━━━━━━━━━━━━",color:"gold"}
execute if score #mode br.mode matches 0 run tellraw @a[tag=br.playing] [{text:" ⚔ 試合開始 ",color:"gold",bold:true},{text:"ソロ戦",color:"yellow"},{text:"  ｜  参加 ",color:"gray"},{score:{name:"#players",objective:"br.tmp"},color:"white"},{text:" 人",color:"gray"}]
execute if score #mode br.mode matches 1 run tellraw @a[tag=br.playing] [{text:" ⚔ 試合開始 ",color:"gold",bold:true},{text:"チーム戦",color:"yellow"},{text:"  ｜  参加 ",color:"gray"},{score:{name:"#players",objective:"br.tmp"},color:"white"},{text:" 人",color:"gray"}]
execute if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{text:"    マップ：",color:"gray"},{text:"地上",color:"white"}]
execute if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{text:"    マップ：",color:"gray"},{text:"ネザー",color:"white"}]
execute if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{text:"    マップ：",color:"gray"},{text:"洞窟",color:"white"}]
execute if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{text:"    マップ：",color:"gray"},{text:"天空島",color:"white"},{text:"（落ちたら奈落。橋・ジャンプ台・転移装置で島を渡る）",color:"gray"}]
execute if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{text:"    マップ：",color:"gray"},{text:"エンド",color:"white"},{text:"（落ちたら奈落。エンドポータル・重力異常エリアあり）",color:"gray"}]
tellraw @a[tag=br.playing] {text:"━━━━━━━━━━━━━━━━━━━━━━",color:"gold"}
tellraw @a[tag=br.playing] [{text:" ▸ ",color:"gold"},{text:"探索して装備を集め、最後まで生き残ろう",color:"white"}]
tellraw @a[tag=br.playing] [{text:" ▸ ",color:"gold"},{text:"最初の1分間は保護期間（プレイヤー同士のダメージなし）",color:"white"}]
tellraw @a[tag=br.playing] [{text:" ▸ ",color:"gold"},{text:"開始6分でチェストが強くなって再補充",color:"white"}]
tellraw @a[tag=br.playing] [{text:" ▸ ",color:"gold"},{text:"試合中の地図はホットバーの右端",color:"white"}]
tellraw @a[tag=br.playing] {text:""}
function oa:br/mission/announce
