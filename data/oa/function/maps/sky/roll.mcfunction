# 生成: scripts/build_map_sky.py（直接編集しない）。外周の島：3〜6個を、10か所の候補地から場所・種類・向きを抽選する（作成・再生成のときだけ。map/internal/job/begin から）
execute unless score #mode oa.map2 matches 0 run return 0
scoreboard players set #sk0 oa.map2 -1
scoreboard players set #sk1 oa.map2 -1
scoreboard players set #sk2 oa.map2 -1
scoreboard players set #sk3 oa.map2 -1
scoreboard players set #sk4 oa.map2 -1
scoreboard players set #sk5 oa.map2 -1
scoreboard players set #sk6 oa.map2 -1
scoreboard players set #sk7 oa.map2 -1
scoreboard players set #sk8 oa.map2 -1
scoreboard players set #sk9 oa.map2 -1
scoreboard players set #tu0 oa.map2 0
scoreboard players set #tu1 oa.map2 0
scoreboard players set #tu2 oa.map2 0
scoreboard players set #tu3 oa.map2 0
scoreboard players set #tu4 oa.map2 0
scoreboard players set #tu5 oa.map2 0
scoreboard players set #tu6 oa.map2 0
scoreboard players set #tu7 oa.map2 0
scoreboard players set #tu8 oa.map2 0
scoreboard players set #tu9 oa.map2 0
execute store result score #in oa.map2 run random value 3..6
scoreboard players set #ii oa.map2 0
function oa:maps/sky/isles/roll_one
