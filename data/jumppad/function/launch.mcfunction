# ============================================================
# Jump Pad - 発射
#
# プレイヤー本人のMotionはデータパックから変更できないため、
# 小型・不可視のArmor Standを一瞬だけ物理キャリアとして利用します。
# キャリアのMotionに初速を設定し、プレイヤーを乗せます。
# 以後の放物線はMinecraft標準の重力・空気抵抗によるものです。
# ============================================================

scoreboard players set @s jp_cd 24
scoreboard players set @s jp_fx 0
tag @s add jp_riding

# ------------------------------------------------------------
# ジャンプ直後の落下ダメージ無効化
#
# 1.21 / 1.21.1 の minecraft:fall_damage_multiplier を
# 一時的に0倍にします。
# Slow Fallingとは違い、ジャンプ軌道や落下速度は変えません。
# ------------------------------------------------------------

# 念のため以前の同名Modifierを削除
attribute @s minecraft:fall_damage_multiplier modifier remove jumppad:no_fall

# 最終的な落下ダメージ倍率を100%減少 = 0倍
attribute @s minecraft:fall_damage_multiplier modifier add jumppad:no_fall -1 add_multiplied_total

tag @s add jp_no_fall
scoreboard players set @s jp_safe 0

# 発射瞬間の超派手演出
playsound minecraft:entity.generic.explode master @a[distance=..40] ~ ~ ~ 0.95 0.70
playsound minecraft:entity.wind_charge.wind_burst master @a[distance=..40] ~ ~ ~ 1.35 0.62
playsound minecraft:entity.wind_charge.throw master @a[distance=..40] ~ ~ ~ 1.30 0.72
playsound minecraft:entity.firework_rocket.large_blast master @a[distance=..40] ~ ~ ~ 1.00 0.88
playsound minecraft:block.respawn_anchor.charge master @a[distance=..40] ~ ~ ~ 0.75 1.25

particle minecraft:gust ~ ~0.20 ~ 0.75 0.22 0.75 0.05 40 force @a[distance=..40]
particle minecraft:cloud ~ ~0.08 ~ 0.60 0.10 0.60 0.04 35 force @a[distance=..40]
particle minecraft:electric_spark ~ ~0.30 ~ 0.70 0.30 0.70 0.16 42 force @a[distance=..40]
particle minecraft:end_rod ~ ~0.32 ~ 0.62 0.30 0.62 0.10 38 force @a[distance=..40]
particle minecraft:firework ~ ~0.22 ~ 0.68 0.25 0.68 0.17 34 force @a[distance=..40]
particle minecraft:crit ~ ~0.25 ~ 0.72 0.25 0.72 0.22 34 force @a[distance=..40]
particle minecraft:explosion ~ ~0.20 ~ 0.16 0.06 0.16 0.01 4 force @a[distance=..40]

# ------------------------------------------------------------
# 向いている方向を16分割して、対応する速度ベクトルを選択
# MinecraftのYaw:
#   0 = 南(+Z)
#  90 = 西(-X)
# -90 = 東(+X)
# ±180 = 北(-Z)
# ------------------------------------------------------------
execute if entity @s[y_rotation=-11.25..11.24] run function jumppad:direction/d00
execute if entity @s[y_rotation=11.25..33.74] run function jumppad:direction/d01
execute if entity @s[y_rotation=33.75..56.24] run function jumppad:direction/d02
execute if entity @s[y_rotation=56.25..78.74] run function jumppad:direction/d03
execute if entity @s[y_rotation=78.75..101.24] run function jumppad:direction/d04
execute if entity @s[y_rotation=101.25..123.74] run function jumppad:direction/d05
execute if entity @s[y_rotation=123.75..146.24] run function jumppad:direction/d06
execute if entity @s[y_rotation=146.25..168.74] run function jumppad:direction/d07
execute if entity @s[y_rotation=168.75..180] run function jumppad:direction/d08
execute if entity @s[y_rotation=-180..-168.76] run function jumppad:direction/d08
execute if entity @s[y_rotation=-168.75..-146.26] run function jumppad:direction/d09
execute if entity @s[y_rotation=-146.25..-123.76] run function jumppad:direction/d10
execute if entity @s[y_rotation=-123.75..-101.26] run function jumppad:direction/d11
execute if entity @s[y_rotation=-101.25..-78.76] run function jumppad:direction/d12
execute if entity @s[y_rotation=-78.75..-56.26] run function jumppad:direction/d13
execute if entity @s[y_rotation=-56.25..-33.76] run function jumppad:direction/d14
execute if entity @s[y_rotation=-33.75..-11.26] run function jumppad:direction/d15
