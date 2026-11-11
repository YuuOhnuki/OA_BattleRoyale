$execute unless entity @e[type=minecraft:item_display,tag=oa.itori_shield_mesh,scores={oa.owner=$(id)}] run function oa:itori/fx/shield_spawn
$execute positioned ~ ~0.9 ~ run tp @e[type=minecraft:item_display,tag=oa.itori_shield_mesh,scores={oa.owner=$(id)},limit=1] ~ ~ ~ ~ 0
