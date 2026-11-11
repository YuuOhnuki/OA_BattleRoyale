execute unless items entity @s armor.head *[minecraft:custom_data~{oa:{kind:5}}] run return 0
function oa:curse/radar/prepare
scoreboard players operation #radar_team oa.team = @s oa.team
tag @a remove oa.radar_ally
execute if score #radar_team oa.team matches 1.. as @a unless entity @s[tag=oa.radar_viewer] if score @s oa.team = #radar_team oa.team run tag @s add oa.radar_ally
execute if entity @s[tag=br.playing] run tag @a[tag=br.alive,tag=!oa.radar_viewer,tag=!oa.radar_ally,gamemode=!spectator,distance=0..,sort=nearest,limit=1] add oa.radar_target
execute unless entity @s[tag=br.playing] run tag @a[tag=!oa.radar_viewer,tag=!oa.radar_ally,gamemode=!spectator,distance=0..,sort=nearest,limit=1] add oa.radar_target
execute store result storage oa:radar cd int 1 run scoreboard players get #cd br.tmp
execute unless entity @a[tag=oa.radar_target] run title @s actionbar [{nbt:"name",storage:"oa:br_item",interpret:true},{text:" | 最寄り：対象なし",color:"light_purple"},{nbt:"display",storage:"oa:allies",interpret:true}]
execute if entity @a[tag=oa.radar_target] run function oa:curse/radar/distance
execute if entity @a[tag=oa.radar_target] run function oa:curse/radar/render with storage oa:radar
execute if entity @a[tag=oa.radar_target] anchored feet positioned ~ ~1 ~ facing entity @a[tag=oa.radar_target,limit=1] eyes run function oa:curse/radar/line
tag @a remove oa.radar_target
tag @s remove oa.radar_viewer
tag @a remove oa.radar_ally
