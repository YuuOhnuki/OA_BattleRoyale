# 1.9.167: 洞窟の落盤の着弾（マーカーとして実行）。屋根の判定はしない（どこでも当たる）。ダメージは隕石群と同じ（3.5以内12、5.5以内6）
playsound minecraft:block.stone.break hostile @a[distance=..48] ~ ~ ~ 2 0.5
playsound minecraft:entity.generic.explode hostile @a[distance=..48] ~ ~ ~ 1.5 0.6
particle minecraft:block{block_state:"minecraft:cobblestone"} ~ ~0.5 ~ 1.5 0.5 1.5 0.1 80 force @a[distance=..64]
particle minecraft:falling_dust{block_state:"minecraft:stone"} ~ ~5 ~ 2 1 2 0 40 force @a[distance=..64]
particle minecraft:large_smoke ~ ~0.5 ~ 1.5 0.3 1.5 0.02 15 force @a[distance=..64]
execute as @a[tag=br.alive,distance=..3.5] run damage @s 12 minecraft:falling_block
execute as @a[tag=br.alive,distance=3.5..5.5] run damage @s 6 minecraft:falling_block
kill @s
