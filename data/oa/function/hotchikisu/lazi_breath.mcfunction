function oa:hotchikisu/check
execute if score #hfound oa.tmp matches 0 run return 0
effect give @s minecraft:glowing 5 0 true
tag @s add oa.h_revealed
execute store result score #hchat oa.tmp run random value 1..4
execute if score #hchat oa.tmp matches 1 run tellraw @a [{selector:"@s",color:"yellow"},{text:" はほちきすにより位置がバレました！",color:"red"}]
execute if score #hchat oa.tmp matches 1 run tellraw @a {text:"らじらじ息切れしてるのらじらじだね～♡",color:"light_purple"}
