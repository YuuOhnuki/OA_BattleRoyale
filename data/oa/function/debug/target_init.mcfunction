tag @s add oa.debug_spawned
data merge entity @s {NoAI:1b,PersistenceRequired:1b,Silent:1b,CustomName:{text:"デバッグ標的",color:"aqua"},CustomNameVisible:1b}
attribute @s minecraft:max_health base set 100
data merge entity @s {Health:100.0f}
function oa:debug/mob/init
