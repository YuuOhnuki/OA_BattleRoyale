# 塔の砲撃の1秒（動きはプラグイン。ここでは何もしない）
execute if score #barrage br.tmp matches 0 run scoreboard players set #barrage br.tmp 1
