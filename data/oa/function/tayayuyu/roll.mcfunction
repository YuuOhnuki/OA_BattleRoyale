# 1.9.192: ガチャの抽選。1〜1500 の乱数で、1〜15（1%）が大当たり（14）、残りを15種に99ずつ（各6.6%）。
# 15種の並び：1〜13、15（時限爆弾）、16（大ハズレ：大爆発）。管理者が次の1回を固定していれば（#gacha_force）その結果にする（1回で外れる）
execute store result score #gacha_r oa.tmp run random value 1..1500
scoreboard players set #c99 oa.tmp 99
scoreboard players set #gacha_roll oa.tmp 14
execute if score #gacha_r oa.tmp matches 16.. run scoreboard players operation #gacha_roll oa.tmp = #gacha_r oa.tmp
execute if score #gacha_r oa.tmp matches 16.. run scoreboard players remove #gacha_roll oa.tmp 16
execute if score #gacha_r oa.tmp matches 16.. run scoreboard players operation #gacha_roll oa.tmp /= #c99 oa.tmp
execute if score #gacha_r oa.tmp matches 16.. run scoreboard players add #gacha_roll oa.tmp 1
execute if score #gacha_r oa.tmp matches 16.. if score #gacha_roll oa.tmp matches 14.. run scoreboard players add #gacha_roll oa.tmp 1
execute if score #gacha_force oa.tmp matches 1..16 run scoreboard players operation #gacha_roll oa.tmp = #gacha_force oa.tmp
scoreboard players set #gacha_force oa.tmp 0
