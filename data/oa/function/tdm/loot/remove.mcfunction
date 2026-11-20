scoreboard players operation #remove tdm.dropid = @s tdm.dropid
execute as @e[tag=tdm.loot_label] if score @s tdm.dropid = #remove tdm.dropid run kill @s
kill @s
