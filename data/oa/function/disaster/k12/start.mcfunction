# 1.9.232：塔の砲撃（エンドのみ・45秒・危険度4）。黒曜石の柱の頂上（storage oa:maps spikes.end）から、近くの生存者へ光弾を撃つ。
# 狙い・予告の線・弾・当たり（♥×2、物陰で防げる）はプラグイン（disaster/TowerBarrage）。#barrage br.tmp=1 が合図
scoreboard players set #barrage br.tmp 1
execute as @a[tag=br.playing] at @s run playsound minecraft:block.beacon.activate ambient @s ~ ~ ~ 1 0.6
execute as @a[tag=br.playing] at @s run playsound minecraft:entity.ender_dragon.growl ambient @s ~ ~ ~ 0.6 1.2
