scoreboard players set #10 br.tmp 10
scoreboard players set #100 br.tmp 100
tellraw @a[tag=oa.res_view] {text:"━━ 試合リザルト ━━",color:"yellow",bold:true}
execute as @a[tag=oa.last_result] run function oa:br/result/line
# 1.9.243：ハイライトはチャットに出さない（ユーザーの指示）
