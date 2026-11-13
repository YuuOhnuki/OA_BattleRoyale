scoreboard players operation #dis_m br.tmp = #dis_left br.tmp
scoreboard players operation #dis_m br.tmp %= #3 br.tmp
execute as @a[tag=br.alive] at @s if predicate oa:weather/rain if predicate oa:disaster/sky_exposed unless items entity @s armor.head * run function oa:disaster/k1/hit
