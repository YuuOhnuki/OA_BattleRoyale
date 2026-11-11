function oa:lobby/events/skin_dispatch with storage oa:lobby_events origin
scoreboard players add #skin_refresh oa.tmp 1
execute store result storage oa:lobby_events origin.skin int 1 run scoreboard players get #skin_refresh oa.tmp
execute if score #skin_refresh oa.tmp matches ..11 run return run schedule function oa:lobby/events/skin_next 5t replace
function oa:lobby/events/release_dispatch with storage oa:lobby_events origin
