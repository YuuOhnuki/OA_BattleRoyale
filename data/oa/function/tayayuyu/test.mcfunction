# 1.9.191: 管理者のテスト用。ガチャの結果 n（1〜16）をすぐに実行する（実行した人を使用者として。CT・保護・武器の所持は見ない）。
# 例：/function oa:tayayuyu/test {n:5}　一覧は /function oa:tayayuyu/test_menu。試合中だけ（1人でソロの試合を始めても試せる）
execute unless score #state br.state matches 1 run return run tellraw @s {text:"試合中に実行してください（1人でソロの試合を始めても試せます）。"}
$scoreboard players set #gacha_test_n oa.tmp $(n)
execute unless score #gacha_test_n oa.tmp matches 1..16 run return run tellraw @s {text:"番号は1〜16です（/function oa:tayayuyu/test_menu）。"}
scoreboard players operation #gacha_roll oa.tmp = #gacha_test_n oa.tmp
scoreboard players operation #gacha_caster oa.tmp = @s oa.id
scoreboard players add #serial oa.serial 1
tellraw @a[tag=br.playing] {text:"（テスト：管理者がたやゆゆのガチャを指定して実行）",color:"dark_gray"}
execute as @a[tag=br.playing] at @s run playsound minecraft:block.end_portal.spawn player @s ~ ~ ~ 1.2 1.5
function oa:tayayuyu/apply
