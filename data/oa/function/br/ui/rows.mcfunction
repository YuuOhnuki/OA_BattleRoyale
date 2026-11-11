$scoreboard players display name OA_alive br.ui$(view) [{text:"残りプレイヤー： ",color:"gray"},{text:"$(alive)",color:"white"}]
$scoreboard players display name OA_width br.ui$(view) [{text:"ボーダー： ",color:"gray"},{text:"$(width) × $(width)",color:"white"}]
$scoreboard players display name OA_phase br.ui$(view) [{text:"フェーズ ",color:"gray"},{text:"$(phase) - $(state)",color:"white"}]
$scoreboard players display name OA_next br.ui$(view) [{text:"次の収縮： ",color:"gray"},{text:"$(next_m):$(next_pad)$(next_s)",color:"white"}]
$scoreboard players reset OA_left br.ui$(view)
