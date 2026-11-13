execute unless loaded ~ ~-1 ~ run return 0
execute unless block ~ ~-1 ~ #oa:ground_spawn_surface run return 0
execute unless block ~ ~ ~ #oa:spawn_clear run return 0
execute unless block ~ ~1 ~ #oa:spawn_clear run return 0
execute if entity @e[type=minecraft:marker,tag=br.gimmick,distance=..30] run return 0
function oa:disaster/gimmick/make
