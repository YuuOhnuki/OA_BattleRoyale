# 生成: scripts/build_map_float.py end（直接編集しない）。スロット（外周の8つの島）の中身を3種類から抽選する（map/internal/job/begin から）
execute unless score #mode oa.map2 matches 0 run return 0
execute store result score #variant oa.map2 run random value 1..3
execute if score #variant oa.map2 matches 1..1 run scoreboard players set #sv0 oa.map2 0
execute if score #variant oa.map2 matches 2..2 run scoreboard players set #sv0 oa.map2 1
execute if score #variant oa.map2 matches 3..3 run scoreboard players set #sv0 oa.map2 2
execute store result score #variant oa.map2 run random value 1..3
execute if score #variant oa.map2 matches 1..1 run scoreboard players set #sv1 oa.map2 0
execute if score #variant oa.map2 matches 2..2 run scoreboard players set #sv1 oa.map2 1
execute if score #variant oa.map2 matches 3..3 run scoreboard players set #sv1 oa.map2 2
execute store result score #variant oa.map2 run random value 1..3
execute if score #variant oa.map2 matches 1..1 run scoreboard players set #sv2 oa.map2 0
execute if score #variant oa.map2 matches 2..2 run scoreboard players set #sv2 oa.map2 1
execute if score #variant oa.map2 matches 3..3 run scoreboard players set #sv2 oa.map2 2
execute store result score #variant oa.map2 run random value 1..3
execute if score #variant oa.map2 matches 1..1 run scoreboard players set #sv3 oa.map2 0
execute if score #variant oa.map2 matches 2..2 run scoreboard players set #sv3 oa.map2 1
execute if score #variant oa.map2 matches 3..3 run scoreboard players set #sv3 oa.map2 2
execute store result score #variant oa.map2 run random value 1..3
execute if score #variant oa.map2 matches 1..1 run scoreboard players set #sv4 oa.map2 0
execute if score #variant oa.map2 matches 2..2 run scoreboard players set #sv4 oa.map2 1
execute if score #variant oa.map2 matches 3..3 run scoreboard players set #sv4 oa.map2 2
execute store result score #variant oa.map2 run random value 1..3
execute if score #variant oa.map2 matches 1..1 run scoreboard players set #sv5 oa.map2 0
execute if score #variant oa.map2 matches 2..2 run scoreboard players set #sv5 oa.map2 1
execute if score #variant oa.map2 matches 3..3 run scoreboard players set #sv5 oa.map2 2
execute store result score #variant oa.map2 run random value 1..3
execute if score #variant oa.map2 matches 1..1 run scoreboard players set #sv6 oa.map2 0
execute if score #variant oa.map2 matches 2..2 run scoreboard players set #sv6 oa.map2 1
execute if score #variant oa.map2 matches 3..3 run scoreboard players set #sv6 oa.map2 2
execute store result score #variant oa.map2 run random value 1..3
execute if score #variant oa.map2 matches 1..1 run scoreboard players set #sv7 oa.map2 0
execute if score #variant oa.map2 matches 2..2 run scoreboard players set #sv7 oa.map2 1
execute if score #variant oa.map2 matches 3..3 run scoreboard players set #sv7 oa.map2 2
function oa:maps/end/layout
