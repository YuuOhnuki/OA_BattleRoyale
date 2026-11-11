# ============================================================
# Hypixel風ジャンプパッド - 毎tick管理
#
# 注意:
# プレイヤーの移動に /tp は一切使用していません。
# tick処理は検出・演出・着地判定・後始末だけです。
# ============================================================

# スコア初期化
scoreboard players add @a jp_cd 0
scoreboard players add @a jp_fx 0
scoreboard players add @a jp_safe 0

# クールダウン
scoreboard players remove @a[scores={jp_cd=1..}] jp_cd 1


# ------------------------------------------------------------
# jp_riding タグの自動クリーンアップ
#
# 実際に jp_vehicle の防具立てへ搭乗しているプレイヤーだけ
# 一時タグ jp_valid_rider を付ける。
# 途中で手動降車・強制降車などが発生し、
# jp_riding だけ残っている場合は自動的に削除する。
# ------------------------------------------------------------

# 前tickの確認用タグをリセット
tag @a remove jp_valid_rider

# jp_vehicle に現在乗っているプレイヤーだけ確認済みにする
execute as @e[type=minecraft:armor_stand,tag=jp_vehicle] on passengers if entity @s[type=minecraft:player] run tag @s add jp_valid_rider
execute if entity @a[tag=oa.practice] in oa:practice as @e[type=minecraft:armor_stand,tag=jp_vehicle] on passengers if entity @s[type=minecraft:player] run tag @s add jp_valid_rider

# jp_riding はあるが、実際にはもう乗っていないプレイヤーを掃除
execute as @a[tag=jp_riding,tag=!jp_valid_rider] run tag @s remove jp_riding
execute as @a[tag=!jp_valid_rider] run scoreboard players set @s jp_fx 0


# ------------------------------------------------------------
# 落下ダメージ無効化の管理
# ------------------------------------------------------------

# 保護中の経過時間
scoreboard players add @a[tag=jp_no_fall] jp_safe 1

# 発射直後の床を拾わないよう5tick待ってから、
# 地面に着いたプレイヤーの落下ダメージ無効化を解除
execute as @a[tag=jp_no_fall,scores={jp_safe=5..},nbt={OnGround:1b}] run function jumppad:clear_fall_immunity

# 万一着地判定が取れなかった場合も10秒で解除
execute as @a[tag=jp_no_fall,scores={jp_safe=200..}] run function jumppad:clear_fall_immunity

# 発射検出:
# 石の感圧板 + 直下にレンガブロック
execute as @a[tag=br.alive,gamemode=!spectator,tag=!jp_riding,scores={jp_cd=0}] at @s if block ~ ~ ~ minecraft:stone_pressure_plate if block ~ ~-1 ~ minecraft:bricks run function jumppad:launch
execute as @a[tag=oa.practice,gamemode=!spectator,tag=!jp_riding,scores={jp_cd=0}] at @s if dimension oa:practice if block ~ ~ ~ minecraft:stone_pressure_plate if block ~ ~-1 ~ minecraft:bricks run function jumppad:launch

# 物理キャリアの経過時間
scoreboard players add @e[type=minecraft:armor_stand,tag=jp_vehicle] jp_age 1
execute if entity @a[tag=oa.practice] in oa:practice as @e[type=minecraft:armor_stand,tag=jp_vehicle,scores={jp_age=0}] run function oa:practice/shorten_jump
execute if entity @a[tag=oa.practice] in oa:practice run scoreboard players add @e[type=minecraft:armor_stand,tag=jp_vehicle] jp_age 1

# 飛行中の演出カウンタ
scoreboard players add @a[tag=jp_riding] jp_fx 1

# 「ドドドド」「ババババン」演出
execute as @a[tag=jp_riding,scores={jp_fx=1}] at @s run function jumppad:fx/burst_1
execute as @a[tag=jp_riding,scores={jp_fx=2}] at @s run function jumppad:fx/burst_2
execute as @a[tag=jp_riding,scores={jp_fx=3}] at @s run function jumppad:fx/burst_3
execute as @a[tag=jp_riding,scores={jp_fx=4}] at @s run function jumppad:fx/burst_4
execute as @a[tag=jp_riding,scores={jp_fx=5}] at @s run function jumppad:fx/burst_5
execute as @a[tag=jp_riding,scores={jp_fx=6}] at @s run function jumppad:fx/burst_6
execute as @a[tag=jp_riding,scores={jp_fx=7}] at @s run function jumppad:fx/burst_7

# 飛行中の短い光跡
execute as @a[tag=jp_riding,scores={jp_fx=1..14}] at @s run particle minecraft:electric_spark ~ ~0.35 ~ 0.12 0.12 0.12 0.02 4 force @a[distance=..32]
execute as @a[tag=jp_riding,scores={jp_fx=1..14}] at @s run particle minecraft:end_rod ~ ~0.25 ~ 0.10 0.10 0.10 0.01 2 force @a[distance=..32]


# ------------------------------------------------------------
# 早めの自動降車
# 発射から24tick（約1.2秒）で防具立てから降ろす
# ------------------------------------------------------------
execute as @e[type=minecraft:armor_stand,tag=jp_vehicle,scores={jp_age=24}] at @s run function jumppad:early_dismount
execute if entity @a[tag=oa.practice] in oa:practice as @e[type=minecraft:armor_stand,tag=jp_vehicle,scores={jp_age=24}] at @s run function jumppad:early_dismount

# 着地判定
# 発射直後に元の床を拾わないよう、4tick経過後から判定
execute as @e[type=minecraft:armor_stand,tag=jp_vehicle,scores={jp_age=120..}] at @s if data entity @s {OnGround:1b} run function jumppad:land
execute if entity @a[tag=oa.practice] in oa:practice as @e[type=minecraft:armor_stand,tag=jp_vehicle,scores={jp_age=120..}] at @s if data entity @s {OnGround:1b} run function jumppad:land

# 万一着地判定できない場合の安全装置（6秒）
execute as @e[type=minecraft:armor_stand,tag=jp_vehicle,scores={jp_age=120..}] at @s run function jumppad:land
execute if entity @a[tag=oa.practice] in oa:practice as @e[type=minecraft:armor_stand,tag=jp_vehicle,scores={jp_age=120..}] at @s run function jumppad:land
