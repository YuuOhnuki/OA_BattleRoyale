particle minecraft:dust{color:[0.4,0.9,0.2],scale:2.5} ~ ~1 ~ 4 1.5 4 0 140 force @a[distance=..64]
execute as @a[tag=br.alive,distance=..9] run effect give @s minecraft:poison 3 0 true
execute as @a[tag=br.alive,distance=..9] run title @s actionbar {text:"☠ 毒霧の中！ 外へ出よう",color:"dark_green"}
