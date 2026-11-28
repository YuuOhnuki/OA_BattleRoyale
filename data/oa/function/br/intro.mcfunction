# 試合開始の案内（1.9.186：見やすく、1つのまとまりに。罫線・空行・見出し。以前は保護期間・お題・案内が別々に出ていた）
# br/start から：intro → 初心者サポート・ヒント（本人だけ）→ intro_end の順
tellraw @a[tag=br.playing] {text:""}
tellraw @a[tag=br.playing] {text:"━━━━━━━━━━━━━━━━━━━━━━"}
execute if score #mode br.mode matches 0 run tellraw @a[tag=br.playing] [{text:" ⚔ 試合開始 ",color:"gold",bold:true},{text:"ソロ戦"},{text:"  ｜  参加 ",color:"gray"},{score:{name:"#players",objective:"br.tmp"},color:"white"},{text:" 人",color:"gray"}]
execute if score #mode br.mode matches 1 run tellraw @a[tag=br.playing] [{text:" ⚔ 試合開始 ",color:"gold",bold:true},{text:"チーム戦"},{text:"  ｜  参加 ",color:"gray"},{score:{name:"#players",objective:"br.tmp"},color:"white"},{text:" 人",color:"gray"}]
execute if score #map oa.mapid matches 0 run tellraw @a[tag=br.playing] [{text:"    マップ：",color:"gray"},{text:"地上",color:"white"}]
execute if score #map oa.mapid matches 1 run tellraw @a[tag=br.playing] [{text:"    マップ：",color:"gray"},{text:"ネザー",color:"white"}]
execute if score #map oa.mapid matches 2 run tellraw @a[tag=br.playing] [{text:"    マップ：",color:"gray"},{text:"地下",color:"white"}]
execute if score #map oa.mapid matches 3 run tellraw @a[tag=br.playing] [{text:"    マップ：",color:"gray"},{text:"天空島",color:"white"},{text:"　落ちると奈落",color:"gray"}]
execute if score #map oa.mapid matches 4 run tellraw @a[tag=br.playing] [{text:"    マップ：",color:"gray"},{text:"エンド",color:"white"},{text:"　落ちると奈落",color:"gray"}]
tellraw @a[tag=br.playing] {text:"━━━━━━━━━━━━━━━━━━━━━━"}
tellraw @a[tag=br.playing] [{text:" ▸ ",color:"gold"},{text:"装備を集めて最後まで生き残ろう",color:"white"}]
tellraw @a[tag=br.playing] [{text:" ▸ ",color:"gold"},{text:"最初の1分は保護期間",color:"white"}]
tellraw @a[tag=br.playing] [{text:" ▸ ",color:"gold"},{text:"6分でチェスト補充",color:"white"}]
tellraw @a[tag=br.playing] [{text:" ▸ ",color:"gold"},{text:"地図はホットバーの右端",color:"white"}]
tellraw @a[tag=br.playing] {text:""}
function oa:br/mission/announce
