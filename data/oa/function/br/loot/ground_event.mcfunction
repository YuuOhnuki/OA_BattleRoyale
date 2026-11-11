execute if score #half br.tmp matches ..5000 run return 0
data modify storage oa:br_spawn x set from storage oa:br center.x
data modify storage oa:br_spawn z set from storage oa:br center.z
data modify storage oa:br_spawn y set from storage oa:br center.y
scoreboard players operation #range br.tmp = #half br.tmp
scoreboard players operation #range br.tmp /= #1000 br.tmp
scoreboard players remove #range br.tmp 4
execute store result storage oa:br_spawn range int 1 run scoreboard players get #range br.tmp
execute in oa:br run function oa:br/loot/random_ground with storage oa:br_spawn
execute in oa:br run function oa:br/loot/random_ground with storage oa:br_spawn
execute in oa:br run function oa:br/loot/random_ground with storage oa:br_spawn
scoreboard players set #extra_chance br.tmp 0
execute if score #time br.time matches 4800.. run scoreboard players set #extra_chance br.tmp 500
execute if score #time br.time matches 7200.. run scoreboard players set #extra_chance br.tmp 900
execute if score #time br.time matches 9600.. run scoreboard players set #extra_chance br.tmp 350
execute if score #time br.time matches 9600.. in oa:br run function oa:br/loot/random_ground with storage oa:br_spawn
execute store result score #extra_roll br.tmp run random value 1..1000
execute if score #extra_roll br.tmp <= #extra_chance br.tmp in oa:br run function oa:br/loot/random_ground with storage oa:br_spawn
