execute unless loaded ~ ~-1 ~ run return 0
execute unless block ~ ~-1 ~ #oa:ground_spawn_surface run return 0
execute unless block ~ ~ ~ #oa:spawn_clear run return 0
execute unless block ~ ~1 ~ #oa:spawn_clear run return 0
scoreboard players set #gok br.tmp 1
function oa:br/loot/unique
