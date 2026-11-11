execute if entity @s[tag=oa.practice] run return run tag @s remove br.login_pending
execute if entity @s[tag=br.playing,tag=br.alive] run return run tag @s remove br.login_pending
execute if entity @s[nbt={Health:0.0f}] run return 0
execute unless data storage oa:lobby origin{ready:1b} run return 0
function oa:lobby/center with storage oa:lobby origin
tag @s remove br.login_pending
