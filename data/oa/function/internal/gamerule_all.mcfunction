# 1.9.184: 試合のディメンションと練習場にゲームルールを設定する。
# Paper ではゲームルールがワールドごとなので、ディメンションごとに設定する。引数 rule（minecraft: なし）・value（true/false）
$execute in minecraft:overworld run gamerule minecraft:$(rule) $(value)
$execute in oa:br run gamerule minecraft:$(rule) $(value)
$execute in oa:br_nether run gamerule minecraft:$(rule) $(value)
$execute in oa:br_cave run gamerule minecraft:$(rule) $(value)
$execute in oa:br_sky run gamerule minecraft:$(rule) $(value)
$execute in oa:br_end run gamerule minecraft:$(rule) $(value)
$execute in oa:practice run gamerule minecraft:$(rule) $(value)
$execute in oa:tdm run gamerule minecraft:$(rule) $(value)
