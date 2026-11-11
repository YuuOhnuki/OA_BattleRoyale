scoreboard players reset @s oa.practice_resp
scoreboard players operation #practice_tier oa.tmp = @s oa.kind
execute summon minecraft:zombie run function oa:practice/dummy
scoreboard players operation @s oa.owner = #practice_spawned oa.tmp
