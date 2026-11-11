execute unless score @s oa.id matches 1.. run function oa:internal/id
scoreboard players operation #control_actor oa.tmp = @s oa.id
