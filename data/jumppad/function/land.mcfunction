# ============================================================
# 着地
# この関数は jp_vehicle (Armor Stand) を @s として実行されます
# ============================================================

# 着地演出
playsound minecraft:entity.generic.explode master @a[distance=..32] ~ ~ ~ 0.35 1.55
playsound minecraft:block.amethyst_block.resonate master @a[distance=..32] ~ ~ ~ 0.65 1.55
particle minecraft:cloud ~ ~0.15 ~ 0.45 0.10 0.45 0.04 22 force @a[distance=..32]
particle minecraft:electric_spark ~ ~0.25 ~ 0.45 0.20 0.45 0.10 18 force @a[distance=..32]
particle minecraft:end_rod ~ ~0.25 ~ 0.35 0.20 0.35 0.05 14 force @a[distance=..32]

# 搭乗しているプレイヤーを降ろす
ride @a[tag=jp_riding,distance=..3,limit=1,sort=nearest] dismount

# プレイヤー側の状態を解除
tag @a[tag=jp_riding,distance=..4,limit=1,sort=nearest] remove jp_riding
scoreboard players set @a[distance=..4,limit=1,sort=nearest] jp_fx 0

# 物理キャリアを削除
kill @s


# 落下ダメージ保護はプレイヤー側のOnGround判定で解除するため、
# ここでは jp_no_fall を削除しません。
