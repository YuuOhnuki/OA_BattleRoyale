execute if entity @s[tag=oa.debug] run return 0
scoreboard players operation #previous oa.tmp = @s br.lmode
scoreboard players set @s br.lmode 0
execute if block ~ ~-0.1 ~ minecraft:emerald_block run scoreboard players set @s br.lmode 1
execute if block ~ ~-0.1 ~ minecraft:diamond_block run scoreboard players set @s br.lmode 2
execute unless score @s br.lmode = #previous oa.tmp run scoreboard players set @s br.lcnt 0
execute if score @s br.lmode matches 0 run tag @s remove br.pad_latched
execute if score @s br.lmode matches 0 run return run scoreboard players set @s br.lcnt 0
execute if entity @s[tag=br.pad_latched] run return 0
scoreboard players add @s br.lcnt 1
execute if score @s br.lcnt matches 1 run tellraw @a[tag=br.admin] {text:"開始パッド：準備中",color:"gray"}
execute if score @s br.lcnt matches 40 run function oa:lobby/countdown_3
execute if score @s br.lcnt matches 60 run function oa:lobby/countdown_2
execute if score @s br.lcnt matches 80 run function oa:lobby/countdown_1
execute unless score @s br.lcnt matches 100.. run return 0
scoreboard players set @s br.lcnt 0
tag @a[tag=br.host,tag=br.lobby_now] add br.pad_latched
execute if score @s br.lmode matches 1 run return run function oa:br/start_solo
execute if score @s br.lmode matches 2 run function oa:br/start_team
