execute unless entity @s[tag=br.admin] run return 0
tag @a remove oa.roster_viewer
tag @s add oa.roster_viewer
function oa:admin/players/row_prepare
tag @s remove oa.roster_viewer
