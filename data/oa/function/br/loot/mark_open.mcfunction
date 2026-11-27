execute if score @s br.opened matches 1 run return 0
scoreboard players set @s br.opened 1
scoreboard players set #open_reward br.flag 1
# 1.9.254: 「開封済み」「再補充まで」の札は出さない。開けたチェストはふたを開けた見た目にし、空のときだけ「空」と出す（プラグイン0.56.0 glow/ChestGlowService）
