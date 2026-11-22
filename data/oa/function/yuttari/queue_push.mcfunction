# 1.9.238：押し出しは練習場もプラグイン0.49.2（combat/MeleeProcs）で統一。
# oa:ambush のノックバックを7相当の1回の押し出しに置き換える。
# 模擬戦の練習中プレイヤーはダメージを与えないので専用の合図。ダミーは通常のダメージで処理する。
execute if entity @s[tag=oa.practice] run tag @s add oa.ambush_push
