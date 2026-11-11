tellraw @s {text:"OA管理メニュー｜生成・再建は範囲を上書きします",color:"gold"}
tellraw @s [{"text":"[2] 準備状況","color":"aqua","click_event":{"action":"run_command","command":"/trigger oa.admin set 2"}}]
tellraw @s [{"text":"[3] BR専用ディメンションにマップ生成","color":"red","click_event":{"action":"run_command","command":"/trigger oa.admin set 3"}}]
tellraw @s [{"text":"[4] 現在地にロビー作成","color":"red","click_event":{"action":"run_command","command":"/trigger oa.admin set 4"}}]
tellraw @s [{"text":"[5] ソロ開始","color":"aqua","click_event":{"action":"run_command","command":"/trigger oa.admin set 5"}}]
tellraw @s [{"text":"[6] チーム開始","color":"aqua","click_event":{"action":"run_command","command":"/trigger oa.admin set 6"}}]
tellraw @s [{"text":"[7] 試合中止","color":"aqua","click_event":{"action":"run_command","command":"/trigger oa.admin set 7"}}]
tellraw @s [{"text":"[9] 木のバットを入手","color":"aqua","click_event":{"action":"run_command","command":"/trigger oa.admin set 9"}}]
tellraw @s [{"text":"[10] ノックバック棒を入手","color":"aqua","click_event":{"action":"run_command","command":"/trigger oa.admin set 10"}}]
tellraw @s [{"text":"[11] 生成停止","color":"aqua","click_event":{"action":"run_command","command":"/trigger oa.admin set 11"}}]
tellraw @s [{"text":"[12] 生成再開","color":"aqua","click_event":{"action":"run_command","command":"/trigger oa.admin set 12"}}]
tellraw @s [{"text":"[13] マップ全面再生成","color":"red","click_event":{"action":"run_command","command":"/trigger oa.admin set 13"}}]
tellraw @s [{"text":"[14] ロビー再建","color":"red","click_event":{"action":"run_command","command":"/trigger oa.admin set 14"}}]
tellraw @s [{text:"[管理ブックを受け取る]",color:"gold",click_event:{action:"run_command",command:"/trigger oa.admin set 16"}}]

tellraw @s {text:"[参加者管理] 参加・観戦を変更",color:"green",click_event:{action:"run_command",command:"/trigger oa.admin set 35"}}

tellraw @s [{text:"[デバッグを開始]",color:"aqua",underlined:true,click_event:{action:"run_command",command:"/trigger oa.admin set 40"}}]

tellraw @s [{"text":"削除：","color":"red"},{"text":"[ロビー] ","color":"red","click_event":{"action":"run_command","command":"/trigger oa.admin set 47"}},{"text":"[マップ] ","color":"red","click_event":{"action":"run_command","command":"/trigger oa.admin set 48"}},{"text":"[ボーダー自動設定]","color":"aqua","click_event":{"action":"run_command","command":"/trigger oa.admin set 49"}}]

tellraw @s [{"text":"展示スキン更新 ","color":"aqua","click_event":{"action":"run_command","command":"/trigger oa.admin set 51"}}]

tellraw @s {text:"昭心を入手",color:"light_purple",click_event:{action:"run_command",command:"/trigger oa.admin set 53"}}
