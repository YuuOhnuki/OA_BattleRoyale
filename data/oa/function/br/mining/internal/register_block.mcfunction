scoreboard players set #ore br.tmp 0
execute if block ~ ~ ~ minecraft:coal_ore run scoreboard players set #ore br.tmp 1
execute if block ~ ~ ~ minecraft:deepslate_coal_ore run scoreboard players set #ore br.tmp 2
execute if block ~ ~ ~ minecraft:redstone_ore run scoreboard players set #ore br.tmp 3
execute if block ~ ~ ~ minecraft:deepslate_redstone_ore run scoreboard players set #ore br.tmp 4
execute if block ~ ~ ~ minecraft:nether_quartz_ore run scoreboard players set #ore br.tmp 5
execute if block ~ ~ ~ minecraft:nether_gold_ore run scoreboard players set #ore br.tmp 6
execute if score #ore br.tmp matches 0 run return 0
scoreboard players set #registered br.flag 1
execute if entity @e[type=minecraft:marker,tag=br.ore,distance=..0.2] run return run tellraw @s {text:"この鉱石は登録済みです",color:"yellow"}
summon minecraft:marker ~ ~ ~ {Tags:["br.ore","br.newore"]}
scoreboard players operation @e[tag=br.newore,limit=1] br.ore = #ore br.tmp
scoreboard players set @e[tag=br.newore,limit=1] br.regen 0
tag @e[tag=br.newore] remove br.newore
tellraw @s {text:"資源鉱石を登録しました（試合中、採掘から30秒で再生成）",color:"green"}
