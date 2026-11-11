execute as @e[tag=oa.lobby_exhibit,tag=!oa.protected1921] run function oa:lobby/protect_one
execute as @e[type=minecraft:text_display,tag=oa.lobby_label,tag=!oa.text_cull1925] run function oa:lobby/cull_text
kill @e[type=minecraft:text_display,tag=oa.lobby_region1914]
kill @e[type=minecraft:text_display,tag=oa.lobby_region1916]
