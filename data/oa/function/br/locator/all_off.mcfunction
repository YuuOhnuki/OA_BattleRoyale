# 1.9.183: ロケーターバーを全ディメンションで消す。Paper ではゲームルールがワールドごとなので、
# 実行位置のワールドにしか効かない（以前はオーバーワールドだけ false で、試合の会場・練習場では表示されていた）。
# 変わっているワールドだけ書き換える（毎秒呼ばれるため）
execute in minecraft:overworld store result score #lbar oa.tmp run gamerule minecraft:locator_bar
execute if score #lbar oa.tmp matches 1 in minecraft:overworld run gamerule minecraft:locator_bar false
execute in minecraft:the_nether store result score #lbar oa.tmp run gamerule minecraft:locator_bar
execute if score #lbar oa.tmp matches 1 in minecraft:the_nether run gamerule minecraft:locator_bar false
execute in minecraft:the_end store result score #lbar oa.tmp run gamerule minecraft:locator_bar
execute if score #lbar oa.tmp matches 1 in minecraft:the_end run gamerule minecraft:locator_bar false
execute in oa:br store result score #lbar oa.tmp run gamerule minecraft:locator_bar
execute if score #lbar oa.tmp matches 1 in oa:br run gamerule minecraft:locator_bar false
execute in oa:br_nether store result score #lbar oa.tmp run gamerule minecraft:locator_bar
execute if score #lbar oa.tmp matches 1 in oa:br_nether run gamerule minecraft:locator_bar false
execute in oa:br_cave store result score #lbar oa.tmp run gamerule minecraft:locator_bar
execute if score #lbar oa.tmp matches 1 in oa:br_cave run gamerule minecraft:locator_bar false
execute in oa:practice store result score #lbar oa.tmp run gamerule minecraft:locator_bar
execute if score #lbar oa.tmp matches 1 in oa:practice run gamerule minecraft:locator_bar false
