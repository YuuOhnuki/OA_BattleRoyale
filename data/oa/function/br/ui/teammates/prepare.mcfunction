data modify storage oa:allies display set value [{text:""}]
execute unless entity @s[tag=br.playing] run return 0
execute unless score @s oa.team matches 1.. run return 0
scoreboard players operation #ally_team oa.team = @s oa.team
tag @a remove oa.ally_viewer
tag @s add oa.ally_viewer
execute as @a[tag=br.alive,tag=!oa.ally_viewer,gamemode=!spectator] if score @s oa.team = #ally_team oa.team run function oa:br/ui/teammates/entry
tag @s remove oa.ally_viewer
