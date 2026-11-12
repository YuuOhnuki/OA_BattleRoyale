# 試合開始時、参加者を実行者として呼ぶ。マップごとの「参加」実績。
execute if score #map oa.mapid matches 0 run function oa:ach/give {id:"map_br_play",name:"草原の戦場へ"}
execute if score #map oa.mapid matches 1 run function oa:ach/give {id:"map_nether_play",name:"炎獄の戦場へ"}
