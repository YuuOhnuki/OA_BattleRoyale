execute unless entity @s[tag=br.admin] run return 0
data modify storage oa:lobby_events force_skins set value 1b
data modify storage oa:lobby_events skins set value 1b
function oa:lobby/events/request
