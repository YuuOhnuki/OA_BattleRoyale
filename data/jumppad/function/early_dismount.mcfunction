# ============================================================
# 早めの自動降車
# この関数は jp_vehicle のArmor Standを @s として実行
# ============================================================

# 近くの搭乗中プレイヤーを降ろす
ride @a[tag=jp_riding,distance=..3,limit=1,sort=nearest] dismount

# 降車演出
playsound minecraft:entity.wind_charge.wind_burst master @a[distance=..32] ~ ~ ~ 0.55 1.25
particle minecraft:cloud ~ ~0.25 ~ 0.24 0.08 0.24 0.025 10 force @a[distance=..32]
particle minecraft:end_rod ~ ~0.35 ~ 0.18 0.12 0.18 0.03 8 force @a[distance=..32]

# プレイヤー側の飛行タグを解除
tag @a[tag=jp_riding,distance=..4,limit=1,sort=nearest] remove jp_riding
scoreboard players set @a[distance=..4,limit=1,sort=nearest] jp_fx 0

# キャリアはここで削除
kill @s


# 注意:
# jp_no_fall はここでは解除しません。
# プレイヤーが実際に地面へ着地した時点で自動解除されます。
