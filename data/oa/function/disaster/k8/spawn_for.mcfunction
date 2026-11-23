execute store result score #mob_n br.tmp run random value 8..12
function oa:disaster/mob_loop {kind:"chicken"}
playsound minecraft:entity.chicken.egg neutral @a[distance=..24] ~ ~ ~ 1 1.2
particle minecraft:poof ~ ~0.6 ~ 0.8 0.4 0.8 0.03 20 normal @a[distance=..32]
