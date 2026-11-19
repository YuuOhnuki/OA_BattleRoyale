# 1.9.191: 管理者のテスト用。次にだれかがガチャを回したとき、結果を n（1〜14）にする（1回だけ）。0 で取り消し
$scoreboard players set #gacha_force oa.tmp $(n)
execute if score #gacha_force oa.tmp matches 1..14 run tellraw @s [{text:"次のたやゆゆのガチャを固定しました：",color:"light_purple"},{score:{name:"#gacha_force",objective:"oa.tmp"},color:"white"}]
execute unless score #gacha_force oa.tmp matches 1..14 run tellraw @s {text:"ガチャの固定を取り消しました。",color:"gray"}
execute unless score #gacha_force oa.tmp matches 1..14 run scoreboard players set #gacha_force oa.tmp 0
