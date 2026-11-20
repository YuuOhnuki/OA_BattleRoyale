execute if score #active tdm.sys matches 1 run return 0
execute if score #building tdm.sys matches 1 run return run tellraw @s {text:"TDMアリーナを準備しています",color:"yellow"}
execute if entity @s[type=minecraft:player] run tag @s add tdm.pending_start
scoreboard players set #building tdm.sys 1
execute in oa:tdm run forceload add -64 -64 63 63
schedule function oa:tdm/map/ready 20t replace
tellraw @a[tag=br.lobby] {text:"TDM専用アリーナを初回生成中… 完了後に開始します",color:"gold"}
