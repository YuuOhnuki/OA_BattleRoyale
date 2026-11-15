# 1.9.184: 試合で使うディメンション（ロビーのオーバーワールドと会場3つ）にゲームルールを設定する。
# Paper ではゲームルールがワールドごとなので、ディメンションごとに設定する。引数 rule（minecraft: なし）・value（true/false）
$execute in minecraft:overworld run gamerule minecraft:$(rule) $(value)
$execute in oa:br run gamerule minecraft:$(rule) $(value)
$execute in oa:br_nether run gamerule minecraft:$(rule) $(value)
$execute in oa:br_cave run gamerule minecraft:$(rule) $(value)
