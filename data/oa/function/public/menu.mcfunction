tellraw @s [{text:"[OA] 参加 /trigger br.join | 取消 /trigger br.leave | スキル /trigger oa.skill | ネロ囮 /trigger oa.alt | テスト参加 /trigger oa.test（待機中のみ）",color:"aqua"}]

tellraw @s [{text:"[OA] 前回の試合結果 /trigger oa.result | 実績一覧 /trigger oa.achv",color:"aqua"}]
tellraw @s {text:"ロビーでは羊毛で選択。開始ホストは緑のパッドでソロ／水色のパッドでチーム開始（5秒）。",color:"yellow"}
tellraw @s {text:"ロビー移動（待機中のみ）：/trigger br.lobby",color:"aqua"}
execute if entity @s[tag=br.admin] run tellraw @s [{text:"[管理メニュー]",color:"gold",click_event:{action:"run_command",command:"/trigger oa.admin"}}]
tellraw @s [{text:"[観戦から参加へ]",color:"green",click_event:{action:"run_command",command:"/trigger oa.return"}}]
