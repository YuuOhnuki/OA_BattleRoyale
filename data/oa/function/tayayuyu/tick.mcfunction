execute unless entity @s[tag=oa.db_free_match] unless entity @s[tag=oa.debug_mob] unless entity @s[tag=br.alive,gamemode=!spectator] run return run function oa:tayayuyu/clear
function oa:tayayuyu/penalty_tick
scoreboard players remove @s[scores={oa.ghp=1..}] oa.ghp 1
execute if entity @s[tag=oa.gacha_hp] if score @s oa.ghp matches 0 run attribute @s minecraft:max_health modifier remove oa:gacha_hp
scoreboard players remove @s[scores={oa.gspeed=1..}] oa.gspeed 1
execute if entity @s[tag=oa.gacha_speed] if score @s oa.gspeed matches 0 run attribute @s minecraft:movement_speed modifier remove oa:gacha_speed
execute if score @s oa.gfire matches 160 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 140 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 120 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 100 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 80 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 60 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 40 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 20 run function oa:tayayuyu/fire_hit
execute if score @s oa.gfire matches 1.. if score #vclock br.tmp matches 0 run particle minecraft:flame ~ ~0.7 ~ 0.3 0.6 0.3 0.01 8 normal @a[distance=..24]
scoreboard players remove @s[scores={oa.gfire=1..}] oa.gfire 1
scoreboard players remove @s[scores={oa.glift=1..}] oa.glift 1
execute if score @s oa.glift matches 0 if entity @s[tag=oa.gacha_lift] if data entity @s active_effects[{id:"minecraft:levitation",amplifier:11}] run effect clear @s minecraft:levitation
execute if score @s oa.glift matches 0 run tag @s remove oa.gacha_lift

scoreboard players remove @s[scores={oa.gsize=1..}] oa.gsize 1
execute if score @s oa.gsize matches 0 if entity @s[tag=oa.gacha_size] run function oa:tayayuyu/size_end
scoreboard players remove @s[tag=oa.gacha_peace,scores={oa.gres_left=1..}] oa.gres_left 1
scoreboard players remove @s[scores={oa.gpeace=1..}] oa.gpeace 1
execute if score @s oa.gpeace matches 0 if entity @s[tag=oa.gacha_peace] run function oa:tayayuyu/peace_end
scoreboard players remove @s[scores={oa.gmood=1..}] oa.gmood 1
execute if score @s oa.gmood matches 0 if entity @s[tag=oa.gacha_mood] run function oa:tayayuyu/mood_end
scoreboard players remove @s[scores={oa.gglow=1..}] oa.gglow 1
execute if score @s oa.gglow matches 0 run tag @s remove oa.gacha_glow
execute if score @s oa.gstiff matches 1.. run return 0
execute if score @s oa.gexpose matches 1.. run return 0
execute if score @s oa.gsize matches 1.. run return 0
execute if score @s oa.gpeace matches 1.. run return 0
execute if score @s oa.gmood matches 1.. run return 0
execute if score @s oa.gglow matches 1.. run return 0

execute if score @s oa.ghp matches 1.. run return 0
execute if score @s oa.gspeed matches 1.. run return 0
execute if score @s oa.gfire matches 1.. run return 0
execute if score @s oa.glift matches 1.. run return 0
function oa:tayayuyu/clear

execute if score @s oa.ghp matches 0 run tag @s remove oa.gacha_hp
execute if score @s oa.gspeed matches 0 run tag @s remove oa.gacha_speed
