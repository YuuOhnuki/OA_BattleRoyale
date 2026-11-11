tag @s add oa.ground
execute unless score @s oa.wait matches 0.. run scoreboard players set @s oa.wait 40
data merge entity @s {PickupDelay:32767s}
function oa:ground/label

scoreboard players operation @s oa.born = #total oa.gtime
