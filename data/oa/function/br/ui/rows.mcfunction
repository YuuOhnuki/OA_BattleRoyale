$scoreboard players display name OA_alive br.ui$(view) [{text:"残りプレイヤー： ",color:"gray"},{text:"$(alive)",color:"white"}]
$scoreboard players display name OA_width br.ui$(view) [{text:"安置の半径： ",color:"gray"},{text:"$(width)m",color:"white"}]
$scoreboard players display name OA_phase br.ui$(view) [{text:"フェーズ ",color:"gray"},{text:"$(phase) - $(state)",color:"white"}]
$scoreboard players display name OA_next br.ui$(view) [{text:"次の収縮： ",color:"gray"},{text:"$(next_m):$(next_pad)$(next_s)",color:"white"}]
$scoreboard players reset OA_left br.ui$(view)

$scoreboard players set OA_mission1 br.ui$(view) 2
$scoreboard players set OA_mission2 br.ui$(view) 1
$scoreboard players display name OA_mission1 br.ui$(view) [{text:"お題：",color:"gold"},{text:"$(mission1)",color:"yellow"}]
$scoreboard players display name OA_mission2 br.ui$(view) {text:"$(mission2)",color:"yellow"}
