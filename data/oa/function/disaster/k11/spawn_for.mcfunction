execute store result score #mob_n br.tmp run random value 3..5
function oa:disaster/mob_loop {kind:"pig"}
playsound minecraft:entity.pig.ambient neutral @a[distance=..24] ~ ~ ~ 1 0.9
particle minecraft:poof ~ ~0.6 ~ 0.8 0.4 0.8 0.03 16 normal @a[distance=..32]
