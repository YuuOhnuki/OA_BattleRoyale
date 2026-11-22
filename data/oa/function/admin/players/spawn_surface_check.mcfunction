function oa:br/spawn_points/check
# 柵・塀・ゲートは当たり判定がブロック上端より高く、整数の高さでは体が食い込む。
execute if block ~ ~-0.1 ~ #minecraft:fences run scoreboard players set #spawn_floor br.flag 0
execute if block ~ ~-0.1 ~ #minecraft:walls run scoreboard players set #spawn_floor br.flag 0
execute if block ~ ~-0.1 ~ #minecraft:fence_gates run scoreboard players set #spawn_floor br.flag 0
