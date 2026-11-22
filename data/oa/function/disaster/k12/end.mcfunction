# 塔の砲撃の終わり
scoreboard players set #barrage br.tmp 0
execute as @a[tag=br.playing] at @s run playsound minecraft:block.beacon.deactivate ambient @s ~ ~ ~ 1 0.6
