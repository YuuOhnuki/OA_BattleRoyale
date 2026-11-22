# キリングのマスクの無効化の抽選（毎tick、そのtickの全ダメージで共有）。
# 1.9.228：攻撃を当ててから3秒間（oa.katk＝残りtick。プラグインの combat/KillingParry が当てたときに60にする）は 25%→15%
scoreboard players remove @s[scores={oa.katk=1..}] oa.katk 1
execute store result score #guard_roll oa.tmp run random value 1..100
execute unless score @s oa.katk matches 1.. if score #guard_roll oa.tmp matches 1..25 run tag @s add oa.curse_guard
execute if score @s oa.katk matches 1.. if score #guard_roll oa.tmp matches 1..15 run tag @s add oa.curse_guard
