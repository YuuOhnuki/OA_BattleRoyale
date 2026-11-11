# ============================================================
# Jump Pad - 落下ダメージ無効化解除
# ============================================================

attribute @s minecraft:fall_damage_multiplier modifier remove jumppad:no_fall
tag @s remove jp_no_fall
scoreboard players set @s jp_safe 0
