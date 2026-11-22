# 1.9.237：参加者への押し出しはプラグイン 0.49.1（combat/MeleeProcs。ダメージ oa:ambush のノックバックを、ノックバック10相当の1回の押し出しに置き換える）。
# ここでの座標を少しずつ動かす押し出し（20tick）は、練習場の相手だけに残す
execute unless entity @s[tag=oa.practice] unless entity @s[tag=oa.practice_dummy] run return 0
function oa:knockback/start_yuttari
