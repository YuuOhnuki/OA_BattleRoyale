execute unless entity @s[tag=oa.player] run return 0
function oa:test/reset
gamemode adventure @s
effect give @s minecraft:instant_health 1 10 true
