# 1.9.186: ふろボールを打ち返す（ボールとして。打ち返した人は oa.f_deflector）
# 向き：打ち返した人の向いている方。持ち主・チームもその人に（その人には当たらず、元の持ち主に当たるようになる）
execute rotated as @a[tag=oa.f_deflector,limit=1] run tp @s ~ ~ ~ ~ ~
scoreboard players operation @s oa.fowner = @a[tag=oa.f_deflector,limit=1] oa.id
scoreboard players operation @s oa.fteam = @a[tag=oa.f_deflector,limit=1] oa.team
scoreboard players operation #f_owner oa.tmp = @s oa.fowner
scoreboard players operation #f_team oa.tmp = @s oa.fteam
particle minecraft:crit ~ ~ ~ 0.2 0.2 0.2 0.3 12 normal @a[distance=..32]
playsound minecraft:entity.player.attack.strong player @a[distance=..24] ~ ~ ~ 1 1.2
tag @a remove oa.f_deflector
