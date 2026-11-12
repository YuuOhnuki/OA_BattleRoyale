execute unless entity @s[type=minecraft:player] run return 0
execute unless dimension oa:br unless dimension oa:br_nether run return 0
execute if score #state br.state matches 1.. run return 0
execute at @s positioned ~ ~-0.2 ~ align xyz positioned ~0.5 ~0.5 ~0.5 run function oa:br/loot/register_chest_at
