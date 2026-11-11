function oa:itori/progress
execute unless entity @s[tag=br.alive] unless entity @s[tag=oa.db_free_match] run return 0
execute unless items entity @s weapon.mainhand *[minecraft:custom_data~{oa:{kind:10}}] run return 0
scoreboard players add @s[scores={oa.i_charge=..14}] oa.i_charge 1
execute store result storage oa:itori id int 1 run scoreboard players get @s oa.id
function oa:itori/proxy_move with storage oa:itori
