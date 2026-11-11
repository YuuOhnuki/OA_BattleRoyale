execute if entity @s[tag=br.loc_hidden] run attribute @s minecraft:waypoint_receive_range modifier remove oa:br_hide
execute if entity @s[tag=br.loc_shown] run attribute @s minecraft:waypoint_receive_range modifier remove oa:br_receive
execute if entity @s[tag=br.loc_transmit] run attribute @s minecraft:waypoint_transmit_range modifier remove oa:br_transmit
tag @s remove br.loc_hidden
tag @s remove br.loc_shown
tag @s remove br.loc_transmit
