execute if score #nobeginner br.flag matches 1 run return 0
# 1.9.243：ゆー：オーバーワークを1つ（チームデスマッチと同じく持ち物の4番へ直接入れる）
tag @s add tdm.yu_equip
execute at @s run function oa:give/internal/overwork
tag @s remove tdm.yu_equip
tellraw @s [{text:" ✚ ",color:"aqua"},{text:"初心者サポート：",color:"aqua"},{text:"ゆー：オーバーワークを1つ渡しました",color:"white"}]
