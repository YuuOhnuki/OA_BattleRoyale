execute if score #nobeginner br.flag matches 1 run return 0
loot give @s loot oa:br/heal
tellraw @s [{text:"[初心者サポート] ",color:"aqua"},{text:"回復アイテムを1つ渡しました。わからないことは /trigger oa.tutorial",color:"white"}]
