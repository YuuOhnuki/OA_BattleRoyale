execute unless score @s oa.id matches 1.. run function oa:internal/id
execute store result storage oa:roster id int 1 run scoreboard players get @s oa.id
scoreboard players operation #join oa.tmp = @s oa.id
scoreboard players set #two oa.tmp 2
scoreboard players operation #join oa.tmp *= #two oa.tmp
scoreboard players operation #watch oa.tmp = #join oa.tmp
scoreboard players add #watch oa.tmp 1
execute store result storage oa:roster join int 1 run scoreboard players get #join oa.tmp
execute store result storage oa:roster watch int 1 run scoreboard players get #watch oa.tmp
scoreboard players operation #control_code oa.tmp = @s oa.id
scoreboard players set #control_ten oa.tmp 10
scoreboard players operation #control_code oa.tmp *= #control_ten oa.tmp
execute store result storage oa:roster survival int 1 run scoreboard players get #control_code oa.tmp
scoreboard players add #control_code oa.tmp 1
execute store result storage oa:roster adventure int 1 run scoreboard players get #control_code oa.tmp
scoreboard players add #control_code oa.tmp 1
execute store result storage oa:roster creative int 1 run scoreboard players get #control_code oa.tmp
scoreboard players add #control_code oa.tmp 1
execute store result storage oa:roster spectator int 1 run scoreboard players get #control_code oa.tmp
scoreboard players add #control_code oa.tmp 1
execute store result storage oa:roster revive int 1 run scoreboard players get #control_code oa.tmp
function oa:admin/players/row with storage oa:roster
