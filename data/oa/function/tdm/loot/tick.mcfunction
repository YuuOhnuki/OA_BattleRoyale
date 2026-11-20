scoreboard players add #loot_clock tdm.sys 1
scoreboard players add #hat_clock tdm.sys 1
scoreboard players add #yu_clock tdm.sys 1
execute if score #loot_clock tdm.sys matches 1 run function oa:tdm/loot/drop_wave
execute if score #loot_clock tdm.sys matches 200.. run scoreboard players set #loot_clock tdm.sys 0
execute if score #hat_clock tdm.sys matches 3000.. run function oa:tdm/loot/hat
execute if score #yu_clock tdm.sys matches 900.. run function oa:tdm/loot/overwork
scoreboard players remove @e[tag=tdm.pickup,scores={tdm.cool=1..}] tdm.cool 1
kill @e[tag=tdm.pickup,scores={tdm.cool=0}]
execute as @a[tag=tdm.player,tag=br.alive,tag=!br.pvp_grace,gamemode=adventure] at @s if entity @e[tag=tdm.pickup,distance=..1.4] run function oa:tdm/loot/pick
kill @e[type=minecraft:item]
