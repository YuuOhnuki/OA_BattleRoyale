execute if entity @e[tag=tdm.pickup,distance=..3] run return 0
execute store result score #weapon_roll tdm.sys run random value 1..113
scoreboard players set #drop_kind tdm.sys 4
execute if score #weapon_roll tdm.sys matches 21..40 run scoreboard players set #drop_kind tdm.sys 6
execute if score #weapon_roll tdm.sys matches 41..60 run scoreboard players set #drop_kind tdm.sys 7
execute if score #weapon_roll tdm.sys matches 61..80 run scoreboard players set #drop_kind tdm.sys 8
execute if score #weapon_roll tdm.sys matches 81..90 run scoreboard players set #drop_kind tdm.sys 2
execute if score #weapon_roll tdm.sys matches 91..100 run scoreboard players set #drop_kind tdm.sys 3
execute if score #weapon_roll tdm.sys matches 101..110 run scoreboard players set #drop_kind tdm.sys 10
execute if score #weapon_roll tdm.sys matches 111..113 run scoreboard players set #drop_kind tdm.sys 5
function oa:tdm/loot/create
