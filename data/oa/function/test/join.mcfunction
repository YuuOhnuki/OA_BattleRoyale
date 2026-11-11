execute unless entity @s[type=minecraft:player] run return 0
execute if entity @s[tag=oa.player] run return 0
execute unless score @s oa.id matches 1.. run function oa:internal/id
scoreboard players set @s oa.owner 0
scoreboard players set @s oa.kind 0
scoreboard players set @s oa.cd 0
scoreboard players set @s oa.mark 0
scoreboard players set @s oa.decoy 0
scoreboard players set @s oa.breath 0
scoreboard players set @s oa.death 0
scoreboard players set @s oa.team 0
scoreboard players add @s oa.left 0
scoreboard players operation @s oa.seen = @s oa.left
scoreboard players operation @s oa.epoch = #epoch oa.epoch
scoreboard players set @s oa.skill 0
scoreboard players set @s oa.alt 0
scoreboard players set @s oa.use 0
tag @s add oa.player
tellraw @s {text:"装備テストに参加しました。",color:"aqua"}
