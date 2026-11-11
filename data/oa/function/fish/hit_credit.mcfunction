function oa:fish/hit
execute unless entity @s[type=minecraft:player,tag=br.playing] run return 0
execute unless score @s oa.hop matches 100.. run return 0
scoreboard players set #by br.tmp 0
execute as @a[tag=br.playing,tag=br.alive,scores={oa.kind=2},distance=..8,limit=1,sort=nearest] run scoreboard players operation #by br.tmp = @s br.pid
scoreboard players operation @s br.hopby = #by br.tmp
