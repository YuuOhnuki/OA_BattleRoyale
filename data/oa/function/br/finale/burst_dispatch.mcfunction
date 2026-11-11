execute store result score #fr br.tmp run random value 0..11
execute if score #fr br.tmp matches 0 positioned ~ ~6 ~ run function oa:br/finale/burst
execute if score #fr br.tmp matches 1 positioned ~9 ~3 ~5 run function oa:br/finale/burst
execute if score #fr br.tmp matches 2 positioned ~-8 ~5 ~7 run function oa:br/finale/burst
execute if score #fr br.tmp matches 3 positioned ~6 ~8 ~-10 run function oa:br/finale/burst
execute if score #fr br.tmp matches 4 positioned ~-11 ~4 ~-5 run function oa:br/finale/burst
execute if score #fr br.tmp matches 5 positioned ~13 ~6 ~-3 run function oa:br/finale/burst
execute if score #fr br.tmp matches 6 positioned ~-4 ~9 ~12 run function oa:br/finale/burst
execute if score #fr br.tmp matches 7 positioned ~2 ~4 ~-14 run function oa:br/finale/burst
execute if score #fr br.tmp matches 8 positioned ~-15 ~7 ~2 run function oa:br/finale/burst
execute if score #fr br.tmp matches 9 positioned ~16 ~4 ~9 run function oa:br/finale/burst
execute if score #fr br.tmp matches 10 positioned ~-9 ~10 ~-12 run function oa:br/finale/burst
execute if score #fr br.tmp matches 11 positioned ~11 ~9 ~14 run function oa:br/finale/burst
