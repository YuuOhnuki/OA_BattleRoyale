# 1.9.246：初心者救済の復活待ち（本人として）。同じチームに生存者がいなければ（全滅）、復活せずに脱落
scoreboard players operation #rt br.tmp = @s oa.team
scoreboard players set #rt_alive br.tmp 0
execute as @a[tag=br.alive,tag=!oa.dead] if score @s oa.team = #rt br.tmp run scoreboard players set #rt_alive br.tmp 1
execute if score #rt_alive br.tmp matches 1 run return 0
tag @s remove br.rescue
tellraw @a[tag=br.playing] [{selector:"@s"},{text:" が脱落しました",color:"red"}]
tellraw @s {text:"チームが全滅したため、復活はありません"}
