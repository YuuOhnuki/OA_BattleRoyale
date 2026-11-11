execute if score @s oa.hcool matches 1.. run return 0
function oa:hotchikisu/check
execute if score #hfound oa.tmp matches 0 run return 0
effect give @s minecraft:glowing 5 0 true
tag @s add oa.h_revealed
scoreboard players set @s oa.hcool 20
execute store result score #hchat oa.tmp run random value 1..4
execute if score #hchat oa.tmp matches 1 run tellraw @a [{selector:"@s",color:"aqua"},{text:" はほちきすにより位置がバレました！",color:"red"}]
execute if score #hchat oa.tmp matches 1 run tellraw @a {text:"ほちきす：ぴちぴちがぴちぴちしててぴちぴちかわいいね～♡",color:"light_purple"}
