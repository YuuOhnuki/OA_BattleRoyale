execute unless entity @s[tag=oa.practice,gamemode=!spectator] run return 0
execute unless dimension oa:practice run return 0
execute store result score #practice_space oa.tmp run function oa:practice/catalog/has_space
execute if score #practice_space oa.tmp matches 0 run return run tellraw @s {text:"持ち物に空きを1つ作ってから受け取ってください。",color:"yellow"}
loot give @s loot oa:practice/catalog_8
playsound minecraft:entity.item.pickup player @s ~ ~ ~ 0.6 1.2
