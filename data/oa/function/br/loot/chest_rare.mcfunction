execute store result score #rare br.tmp run random value 1..200
scoreboard players set #rare_chance br.tmp 12
execute if score #time br.time matches 4800.. run scoreboard players set #rare_chance br.tmp 18
execute if score #time br.time matches 7200.. run scoreboard players set #rare_chance br.tmp 24
execute if score #time br.time matches 9600.. run scoreboard players set #rare_chance br.tmp 30
execute if score #rare br.tmp > #rare_chance br.tmp run return 0
function oa:br/loot/unique
execute store success score #copy br.flag run item replace block ~ ~ ~ container.26 from entity @e[tag=br.newunique,limit=1] contents
execute if score #copy br.flag matches 1 run kill @e[tag=br.newunique]
tag @e[tag=br.newunique] remove br.newunique
