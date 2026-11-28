# 1.9.269：空中補給の中身（br/supply/spawn と信号弾〔プラグイン match/FlareService〕で共通）。#sup_grade br.tmp＝1〜3（第1〜3便のグレード）。実行位置に出す
# 1.9.142: 回を追うごとに中身が良くなる。chest_site は25%で上位（chest_upgraded）、75%で通常（chest_basic）の中身
execute if score #sup_grade br.tmp matches 1 run loot spawn ~ ~0.5 ~ loot oa:br/chest_basic
execute if score #sup_grade br.tmp matches 1 run loot spawn ~ ~0.5 ~ loot oa:br/chest_basic
execute if score #sup_grade br.tmp matches 1 run loot spawn ~ ~0.5 ~ loot oa:br/heal
execute if score #sup_grade br.tmp matches 1 run loot spawn ~ ~0.5 ~ loot oa:br/heal
execute if score #sup_grade br.tmp matches 1 run loot spawn ~ ~0.5 ~ loot oa:br/food
execute if score #sup_grade br.tmp matches 2 run loot spawn ~ ~0.5 ~ loot oa:br/chest_upgraded
execute if score #sup_grade br.tmp matches 2 run loot spawn ~ ~0.5 ~ loot oa:br/chest_site
execute if score #sup_grade br.tmp matches 2 run loot spawn ~ ~0.5 ~ loot oa:br/chest_basic
execute if score #sup_grade br.tmp matches 2 run loot spawn ~ ~0.5 ~ loot oa:br/heal
execute if score #sup_grade br.tmp matches 2 run loot spawn ~ ~0.5 ~ loot oa:br/heal
execute if score #sup_grade br.tmp matches 3 run loot spawn ~ ~0.5 ~ loot oa:br/chest_upgraded
execute if score #sup_grade br.tmp matches 3 run loot spawn ~ ~0.5 ~ loot oa:br/chest_upgraded
execute if score #sup_grade br.tmp matches 3 run loot spawn ~ ~0.5 ~ loot oa:br/chest_upgraded
execute if score #sup_grade br.tmp matches 3 run loot spawn ~ ~0.5 ~ loot oa:br/heal
execute if score #sup_grade br.tmp matches 3 run loot spawn ~ ~0.5 ~ loot oa:br/heal
execute if score #sup_grade br.tmp matches 1..3 run function oa:br/supply/unique
# 1.9.222：「ゆー：オーバーワーク」も1個（固有武器の1個とは別枠）。1.9.224 で 1/3→1/4
execute store result score #sup_yu br.tmp run random value 1..100
execute if score #sup_grade br.tmp matches 1..3 if score #sup_yu br.tmp matches 1..15 run function oa:give/internal/overwork
execute as @e[type=minecraft:item,distance=..3,nbt={Age:0s}] run data merge entity @s {Glowing:1b}
