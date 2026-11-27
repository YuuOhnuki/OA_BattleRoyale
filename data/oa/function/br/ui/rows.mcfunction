$scoreboard players display name OA_alive br.ui$(view) [{text:"残りプレイヤー： ",color:"gray"},{text:"$(alive)",color:"white"}]
$scoreboard players display name OA_width br.ui$(view) [{text:"安地の半径： ",color:"gray"},{text:"$(width)m",color:"white"}]
$scoreboard players display name OA_phase br.ui$(view) [{text:"フェーズ ",color:"gray"},{text:"$(phase) - $(state)",color:"white"}]
$scoreboard players display name OA_next br.ui$(view) [{text:"次の収縮： ",color:"gray"},{text:"$(next_m):$(next_pad)$(next_s)",color:"white"}]
$scoreboard players reset OA_left br.ui$(view)

# 1.9.258: お題はバージョン（9）より上（11・10）。ほかの行と同じく見出しは灰・中身は白。2行目が空なら行を消す
# 達成した人には、プラグイン（menu/MissionStrike）が自分の画面だけ打ち消し線をつける（br.mdone=1）
$scoreboard players set OA_mission1 br.ui$(view) 11
$scoreboard players set OA_mission2 br.ui$(view) 10
$scoreboard players display name OA_mission1 br.ui$(view) [{text:"お題： ",color:"gray"},{text:"$(mission1)",color:"white"}]
$scoreboard players display name OA_mission2 br.ui$(view) {text:"$(mission2)",color:"white"}
$execute if data storage oa:br_ui {mission2:""} run scoreboard players reset OA_mission2 br.ui$(view)
