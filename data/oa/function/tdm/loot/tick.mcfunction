scoreboard players remove @e[tag=tdm.node,scores={tdm.cool=1..}] tdm.cool 1
execute as @e[tag=tdm.node,scores={tdm.cool=0}] at @s run function oa:tdm/loot/spawn
execute as @a[tag=tdm.player,tag=br.alive,tag=!br.pvp_grace,gamemode=adventure] at @s if entity @e[tag=tdm.pickup,distance=..1.4] run function oa:tdm/loot/pick
# Player-dropped items cannot become additional permanent armor upgrades.
kill @e[type=minecraft:item]
