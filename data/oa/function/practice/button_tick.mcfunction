execute unless block ~ ~ ~ minecraft:stone_button[powered=true] run return run tag @s remove oa.button_latched
execute if entity @s[tag=oa.button_latched] run return 0
tag @s add oa.button_latched
function oa:practice/button_dispatch with entity @s data
