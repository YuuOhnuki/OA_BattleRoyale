# 1.9.186: 本人の通算戦績（ロビーの戦績ボードの値）と前回の試合結果を消す（プラグインの /oaplugin reset records から、本人として）
scoreboard players reset @s oa.t_games
scoreboard players reset @s oa.t_win
scoreboard players reset @s oa.t_kill
scoreboard players reset @s oa.t_rank
scoreboard players reset @s br.lkey
tag @s remove oa.last_result
