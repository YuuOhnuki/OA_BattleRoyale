execute unless block ~ ~ ~ minecraft:stone_button[powered=true] run return run tag @s remove oa.button_latched
execute if entity @s[tag=oa.button_latched] run return 0
execute unless entity @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] run return 0
tag @s add oa.button_latched
scoreboard players operation #gallery_button oa.tmp = @s oa.gallery_id
execute if score #gallery_button oa.tmp matches 1 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/1
execute if score #gallery_button oa.tmp matches 2 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/2
execute if score #gallery_button oa.tmp matches 3 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/3
execute if score #gallery_button oa.tmp matches 4 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/4
execute if score #gallery_button oa.tmp matches 5 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/5
execute if score #gallery_button oa.tmp matches 6 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/6
execute if score #gallery_button oa.tmp matches 7 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/7
execute if score #gallery_button oa.tmp matches 8 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/8
execute if score #gallery_button oa.tmp matches 9 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/9
execute if score #gallery_button oa.tmp matches 10 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/10
execute if score #gallery_button oa.tmp matches 11 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/11
execute if score #gallery_button oa.tmp matches 12 as @p[tag=br.lobby_now,gamemode=!spectator,distance=..6] at @s run function oa:lobby/gallery/click/12
