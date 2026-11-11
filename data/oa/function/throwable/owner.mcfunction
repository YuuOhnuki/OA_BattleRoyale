execute unless entity @s[type=minecraft:player,tag=br.alive] run return 0
execute if entity @s[tag=br.pvp_grace] run return 0
function oa:combat/select_targets
