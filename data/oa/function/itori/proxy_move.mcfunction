$execute unless entity @e[type=minecraft:interaction,tag=oa.itori_proxy,scores={oa.owner=$(id)}] run function oa:itori/proxy_spawn
$execute anchored eyes positioned ^ ^ ^0.8 positioned ~ ~-0.45 ~ run tp @e[type=minecraft:interaction,tag=oa.itori_proxy,scores={oa.owner=$(id)},limit=1] ~ ~ ~
