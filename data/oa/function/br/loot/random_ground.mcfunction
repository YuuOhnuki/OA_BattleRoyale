# 固有武器の地上湧き。置ける地面が見つからなければ最大4回まで別の場所を試す（1.9.121：ネザーの地面・草の上でも湧くように）
execute store result score #spawn_roll br.tmp run random value 1..20
execute if score #spawn_roll br.tmp matches 1 run return 0
scoreboard players set #gok br.tmp 0
function oa:br/loot/ground_try with storage oa:br_spawn
execute if score #gok br.tmp matches 0 run function oa:br/loot/ground_try with storage oa:br_spawn
execute if score #gok br.tmp matches 0 run function oa:br/loot/ground_try with storage oa:br_spawn
execute if score #gok br.tmp matches 0 run function oa:br/loot/ground_try with storage oa:br_spawn
