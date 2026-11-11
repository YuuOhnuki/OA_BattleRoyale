execute store result score #fc br.tmp run random value 0..5
execute if score #fc br.tmp matches 0 run particle minecraft:dust{"color":[1,0.15,0.15],"scale":3.0} ~ ~ ~ 3.2 3.2 3.2 0 160 force @a[tag=br.playing,distance=..160]
execute if score #fc br.tmp matches 1 run particle minecraft:dust{"color":[1,0.8,0.1],"scale":3.0} ~ ~ ~ 3.2 3.2 3.2 0 160 force @a[tag=br.playing,distance=..160]
execute if score #fc br.tmp matches 2 run particle minecraft:dust{"color":[0.2,0.9,1],"scale":3.0} ~ ~ ~ 3.2 3.2 3.2 0 160 force @a[tag=br.playing,distance=..160]
execute if score #fc br.tmp matches 3 run particle minecraft:dust{"color":[1,0.35,0.85],"scale":3.0} ~ ~ ~ 3.2 3.2 3.2 0 160 force @a[tag=br.playing,distance=..160]
execute if score #fc br.tmp matches 4 run particle minecraft:dust{"color":[0.4,1,0.3],"scale":3.0} ~ ~ ~ 3.2 3.2 3.2 0 160 force @a[tag=br.playing,distance=..160]
execute if score #fc br.tmp matches 5 run particle minecraft:dust_color_transition{"from_color":[1,0.3,0.1],"to_color":[0.6,0.2,1],"scale":3.0} ~ ~ ~ 3.2 3.2 3.2 0 160 force @a[tag=br.playing,distance=..160]
particle minecraft:flash{color:[1.0,0.9,0.5,1.0]} ~ ~ ~ 0 0 0 0 1 force @a[tag=br.playing,distance=..160]
particle minecraft:firework ~ ~ ~ 3 3 3 0.22 140 force @a[tag=br.playing,distance=..160]
particle minecraft:end_rod ~ ~ ~ 3.5 3.5 3.5 0.12 70 force @a[tag=br.playing,distance=..160]
particle minecraft:glow ~ ~ ~ 3 3 3 0.05 40 force @a[tag=br.playing,distance=..160]
playsound minecraft:entity.firework_rocket.launch player @a[tag=br.playing,distance=..160] ~ ~-6 ~ 3 1
playsound minecraft:entity.firework_rocket.large_blast player @a[tag=br.playing,distance=..160] ~ ~ ~ 3 1
playsound minecraft:entity.firework_rocket.twinkle player @a[tag=br.playing,distance=..160] ~ ~ ~ 3 1.1
