advancement revoke @s only oa:medical/kit
# 1.9.185: 14HP 回復＋再生 I を10秒（以前は10HP）
function oa:medical/heal {milli:14000}
effect give @s minecraft:regeneration 10 0
playsound minecraft:block.amethyst_block.chime player @s ~ ~ ~ 0.8 1.2
particle minecraft:heart ~ ~1 ~ 0.3 0.4 0.3 0 6 normal @a[distance=..16]
