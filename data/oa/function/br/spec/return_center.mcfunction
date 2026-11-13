# 観戦者が会場の外にいるときの救済（実行者：観戦者）。脱落者・観戦者だけ中心へ戻し、他の人は何もしない
execute unless entity @s[tag=br.playing,tag=!br.alive] unless entity @s[tag=br.watch] run return 0
function oa:internal/tp with storage oa:br center
