# 1.9.192: 時限爆弾の1 tick（tick から、#g_oni 1.. のとき）
execute unless score #state br.state matches 1 run return run function oa:tayayuyu/oni_reset
scoreboard players remove #g_oni oa.tmp 1
scoreboard players remove @a[scores={oa.goni_cd=1..}] oa.goni_cd 1
# 鬼が倒れた・抜けた：生存者のだれかに移す
execute unless entity @a[tag=oa.g_oni,tag=br.alive,gamemode=!spectator] run function oa:tayayuyu/oni_lost
execute unless score #g_oni oa.tmp matches 0.. run return 0
execute unless entity @a[tag=oa.g_oni] run return 0
# Repair the equipped TNT if commands/creative mode removed it.
execute as @a[tag=oa.g_oni,tag=br.alive,limit=1] at @s unless items entity @s armor.head *[minecraft:custom_data~{oa_tnt_oni:1b}] run function oa:tayayuyu/oni_hat
execute as @a[tag=oa.g_oni,limit=1] at @s anchored eyes positioned ^ ^ ^ run particle minecraft:smoke ~ ~0.9 ~ 0.05 0.05 0.05 0.01 1 normal @a[distance=..32]
scoreboard players set #c20 oa.tmp 20
scoreboard players operation #oni_m oa.tmp = #g_oni oa.tmp
scoreboard players operation #oni_m oa.tmp %= #c20 oa.tmp
execute if score #oni_m oa.tmp matches 0 run function oa:tayayuyu/oni_second
execute if score #g_oni oa.tmp matches ..100 if score #oni_m oa.tmp matches 10 as @a[tag=oa.g_oni] at @s run playsound minecraft:block.note_block.hat player @a[distance=..32] ~ ~ ~ 1.5 2
execute if score #g_oni oa.tmp matches 0 run function oa:tayayuyu/oni_boom
