# 1.9.191: TNTの雨の1秒（tnt_all と br/second から）
execute unless score #g_tnt oa.tmp matches 1.. run return 0
scoreboard players remove #g_tnt oa.tmp 1
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s run function oa:tayayuyu/tnt_drop
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s run function oa:tayayuyu/tnt_drop
execute as @a[tag=br.alive,gamemode=!spectator,tag=!oa.dead] at @s run function oa:tayayuyu/tnt_drop
