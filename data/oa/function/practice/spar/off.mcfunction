tag @s remove oa.spar
team join oa_practice @s
effect clear @s minecraft:resistance
effect give @s minecraft:resistance infinite 4 true
tellraw @s {text:"【模擬戦OFF】通常の練習に戻りました。",color:"green"}
