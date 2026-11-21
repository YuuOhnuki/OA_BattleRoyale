# 2列6行の隊列（各12匹）。既定上限30匹なので最大2隊。
scoreboard players add @a br.dpig 0
execute as @a[tag=br.alive,gamemode=!spectator,sort=random] at @s run function oa:disaster/k11/spawn_for
