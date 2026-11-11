# ============================================================
# Jump Pad - 初期化
# Minecraft Java Edition 1.21 / 1.21.1
# ============================================================

scoreboard objectives add jp_cd dummy
scoreboard objectives add jp_age dummy
scoreboard objectives add jp_fx dummy
scoreboard objectives add jp_safe dummy

tellraw @a[tag=br.admin] [{"text":"[Jump Pad] ","color":"gold","bold":true},{"text":"読み込み完了","color":"green"}]
