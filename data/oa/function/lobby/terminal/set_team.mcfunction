execute unless score #state br.state matches 0 run return 0
execute if entity @s[tag=oa.practice] run return 0
execute if entity @s[tag=br.playing] run return 0
$scoreboard players set @s oa.lobby $(n)
execute if score @s oa.lobby matches 0 run return run function oa:lobby/terminal/clear_team
# Use arithmetic rather than concatenation for the public selection codes.
$scoreboard players set @s oa.lobby $(n)
scoreboard players add @s oa.lobby 100
function oa:lobby/guide/dispatch
scoreboard players set @s oa.lobby 0
