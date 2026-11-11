# ============================================================
# Jump Pad - アンインストール
# ============================================================

# 搭乗中キャリアを解除
execute as @e[type=minecraft:armor_stand,tag=jp_vehicle] at @s run function jumppad:land

# プレイヤー状態をクリーンアップ
execute as @a run attribute @s minecraft:fall_damage_multiplier modifier remove jumppad:no_fall
tag @a remove jp_riding
tag @a remove jp_valid_rider
tag @a remove jp_no_fall

# 残存キャリアを削除
kill @e[type=minecraft:armor_stand,tag=jp_vehicle]

# Scoreboard削除
scoreboard objectives remove jp_cd
scoreboard objectives remove jp_age
scoreboard objectives remove jp_fx
scoreboard objectives remove jp_safe

tellraw @a [{"text":"[Jump Pad] ","color":"gold","bold":true},{"text":"アンインストール処理が完了しました","color":"yellow"}]
