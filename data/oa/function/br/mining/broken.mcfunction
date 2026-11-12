scoreboard players operation @s br.regen = #time br.time
scoreboard players add @s br.regen 1200
setblock ~ ~ ~ minecraft:bedrock
execute if score @s br.ore matches 1 as @a[tag=br.alive,distance=..7,scores={br.mcoal=1..},sort=nearest,limit=1] run function oa:br/mining/reward {table:"food",overwork_roll:0,stat:"br.mcoal"}
execute if score @s br.ore matches 2 as @a[tag=br.alive,distance=..7,scores={br.mdcoal=1..},sort=nearest,limit=1] run function oa:br/mining/reward {table:"food",overwork_roll:0,stat:"br.mdcoal"}
execute if score @s br.ore matches 3 as @a[tag=br.alive,distance=..7,scores={br.mred=1..},sort=nearest,limit=1] run function oa:br/mining/reward {table:"ore_medical",overwork_roll:1,stat:"br.mred"}
execute if score @s br.ore matches 5 as @a[tag=br.alive,distance=..7,scores={br.mqz=1..},sort=nearest,limit=1] run function oa:br/mining/reward {table:"food",overwork_roll:0,stat:"br.mqz"}
execute if score @s br.ore matches 6 as @a[tag=br.alive,distance=..7,scores={br.mng=1..},sort=nearest,limit=1] run function oa:br/mining/reward {table:"ore_medical",overwork_roll:1,stat:"br.mng"}
execute if score @s br.ore matches 4 as @a[tag=br.alive,distance=..7,scores={br.mdred=1..},sort=nearest,limit=1] run function oa:br/mining/reward {table:"ore_medical",overwork_roll:1,stat:"br.mdred"}
