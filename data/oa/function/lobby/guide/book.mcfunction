execute if entity @s[tag=br.playing] run return 0
execute if entity @s[tag=oa.practice] run return 0
execute if items entity @s inventory.* *[minecraft:custom_data~{oa_player_book:1b,guide_v202:1b}] run return 0
execute if items entity @s hotbar.* *[minecraft:custom_data~{oa_player_book:1b,guide_v202:1b}] run return 0
execute if items entity @s weapon.offhand *[minecraft:custom_data~{oa_player_book:1b,guide_v202:1b}] run return 0
clear @s *[minecraft:custom_data~{oa_player_book:1b}]
scoreboard players set #guide_free oa.tmp 0
execute unless items entity @s hotbar.0 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s hotbar.1 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s hotbar.2 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s hotbar.3 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s hotbar.4 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s hotbar.5 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s hotbar.6 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s hotbar.7 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s hotbar.8 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.0 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.1 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.2 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.3 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.4 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.5 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.6 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.7 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.8 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.9 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.10 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.11 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.12 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.13 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.14 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.15 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.16 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.17 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.18 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.19 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.20 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.21 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.22 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.23 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.24 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.25 * run scoreboard players set #guide_free oa.tmp 1
execute unless items entity @s inventory.26 * run scoreboard players set #guide_free oa.tmp 1
execute if score #guide_free oa.tmp matches 0 run return run tellraw @s {text:"案内本を受け取るには持ち物に空きを作ってください。メニューは /oa",color:"yellow"}
give @s minecraft:written_book[minecraft:written_book_content={"title":{"raw":"OA はじめての案内"},"author":"OA","generation":0,"resolved":true,"pages":[{"raw":{"text":"","extra":[{"text":"ようこそ OAへ\n\n","color":"dark_aqua","bold":true},{"text":"探索と固有武器で戦うゲームです。\n正面へ少し進むと出撃受付。\n参加→チーム→準備完了！\n\n","color":"black"},{"text":"▸ メニュー /oa\n","color":"dark_blue","underlined":true,"click_event":{"action":"run_command","command":"/oa"}},{"text":"▸ 参加・観戦\n","color":"dark_blue","underlined":true,"click_event":{"action":"run_command","command":"/oa play"}}]}},{"raw":{"text":"","extra":[{"text":"BRとTDM\n\n","color":"dark_aqua","bold":true},{"text":"BR：装備を集め、最後まで生き残る。ソロとチーム戦。\nTDM：赤青2チーム、5分間のキル数勝負。\n\n","color":"black"},{"text":"▸ ゲーム案内\n","color":"dark_blue","underlined":true,"click_event":{"action":"run_command","command":"/oa mode"}},{"text":"▸ マップを見る\n","color":"dark_blue","underlined":true,"click_event":{"action":"run_command","command":"/oa maps"}}]}},{"raw":{"text":"","extra":[{"text":"参加とチーム\n\n","color":"dark_aqua","bold":true},{"text":"参加状態はメニュー上部で確認。\nチーム変更は試合前に。\nBRは各最大3人。TDMは開始時に人数を調整。\n\n","color":"black"},{"text":"▸ 参加・観戦\n","color":"dark_blue","underlined":true,"click_event":{"action":"run_command","command":"/oa play"}},{"text":"▸ チームを選ぶ\n","color":"dark_blue","underlined":true,"click_event":{"action":"run_command","command":"/oa team"}}]}},{"raw":{"text":"","extra":[{"text":"TDMの出撃\n\n","color":"dark_aqua","bold":true},{"text":"最初と復活待ちの10秒間に武器を選べます。\n死亡するとチェーン防具へ。\n地面の武器はシフトで交換。\n\n","color":"black"},{"text":"▸ 固有武器を選ぶ\n","color":"dark_blue","underlined":true,"click_event":{"action":"run_command","command":"/tdm"}}]}},{"raw":{"text":"","extra":[{"text":"練習場\n\n","color":"dark_aqua","bold":true},{"text":"荷物を預けて武器を試せます。\n退出時は練習の荷物を消し、預けた荷物を戻します。\n参加登録とチームは保持。\n\n","color":"black"},{"text":"▸ 練習場メニュー\n","color":"dark_blue","underlined":true,"click_event":{"action":"run_command","command":"/oa practice"}}]}},{"raw":{"text":"","extra":[{"text":"固有武器の操作\n\n","color":"dark_aqua","bold":true},{"text":"基本は右クリックでスキル。武器の説明に操作とCTを表示。\n展示室はロビー左側。\nゆーは在庫から自動発動。\n\n","color":"black"},{"text":"▸ 武器を練習する\n","color":"dark_blue","underlined":true,"click_event":{"action":"run_command","command":"/oa practice"}}]}},{"raw":{"text":"","extra":[{"text":"記録と遊び方\n\n","color":"dark_aqua","bold":true},{"text":"右のギャラリーに戦績を展示。\n自分の戦績・実績・前回の結果はメニューから確認。\n案内本の再取得もできます。\n\n","color":"black"},{"text":"▸ 戦績・実績\n","color":"dark_blue","underlined":true,"click_event":{"action":"run_command","command":"/oa records"}},{"text":"▸ 遊び方 / 案内本\n","color":"dark_blue","underlined":true,"click_event":{"action":"run_command","command":"/oa guide"}}]}}]},minecraft:custom_name={text:"OA はじめての案内",color:"aqua",italic:false},minecraft:custom_data={oa_player_book:1b,guide_v202:1b},minecraft:max_stack_size=1] 1
