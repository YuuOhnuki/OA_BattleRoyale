# 1.9.167: 洞窟の途中参加の場所（admin/players/spawn から、in oa:br_cave で呼ばれる）
scoreboard players set #cave_try oa.tmp 0
function oa:admin/players/spawn_cave_try with storage oa:roster_spawn args
