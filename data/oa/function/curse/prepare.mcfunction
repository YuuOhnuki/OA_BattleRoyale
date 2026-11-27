# キリングのマスクの無効化の抽選（毎tick、そのtickの全ダメージで共有）。
# 1.9.257：確率は20%（1.9.251〜1.9.256 は25%。1.9.228〜1.9.250 は攻撃を当ててから3秒間だけ下げていた。スコア oa.katk はもう使わない）
execute store result score #guard_roll oa.tmp run random value 1..100
execute if score #guard_roll oa.tmp matches 1..20 run tag @s add oa.curse_guard
