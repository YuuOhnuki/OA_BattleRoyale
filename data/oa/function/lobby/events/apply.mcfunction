data modify storage oa:lobby_events remove_stats set value 0b
kill @e[type=minecraft:text_display,tag=oa.rank_holo]
execute unless data storage oa:lobby_events {skins:1b} run return run function oa:lobby/events/release_dispatch with storage oa:lobby_events origin
data modify storage oa:lobby_events skins set value 0b
scoreboard players set #skin_refresh oa.tmp 0
data modify storage oa:lobby_events origin.skin set value 0
function oa:lobby/events/skin_next
