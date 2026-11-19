# 1.9.192: 時限爆弾を止める（終わり・試合の終了と開始）
scoreboard players set #g_oni oa.tmp 0
execute as @a[tag=oa.g_oni] run function oa:tayayuyu/oni_drop
kill @e[type=minecraft:item_display,tag=oa.g_oni_hat]
