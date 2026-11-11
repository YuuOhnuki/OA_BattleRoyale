scoreboard players add @s oa.wait 1
execute if score @s oa.wait matches 1 run function oa:lazi/ring_small
execute if score @s oa.wait matches 3 run function oa:lazi/ring_medium
execute if score @s oa.wait matches 5 run function oa:lazi/ring_large
execute if score @s oa.wait matches 6.. run kill @s
