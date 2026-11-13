scoreboard players operation #dis_m br.tmp = #dis_left br.tmp
scoreboard players operation #dis_m br.tmp %= #3 br.tmp
execute as @a[tag=br.alive] at @s unless items entity @s armor.chest minecraft:leather_chestplate run function oa:disaster/k2/check
