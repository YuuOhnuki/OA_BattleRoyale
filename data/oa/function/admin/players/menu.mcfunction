execute unless entity @s[tag=br.admin] run return 0
tag @a remove oa.roster_viewer
tag @s add oa.roster_viewer
tellraw @s {text:"参加者管理｜名前の右の操作をクリック",color:"gold"}
execute as @a run function oa:admin/players/row_prepare
tag @s remove oa.roster_viewer
