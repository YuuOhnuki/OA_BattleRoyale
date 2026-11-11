execute unless entity @s[type=minecraft:player] run return 0
tag @s add br.admin
tag @s add br.host
function oa:admin/defaults
scoreboard players enable @s oa.admin
function oa:admin/menu
function oa:admin/book
