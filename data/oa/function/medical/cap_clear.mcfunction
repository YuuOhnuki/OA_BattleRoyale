# 1.9.185: medical/cap の回復量の上限を外す（2 tick 後）
execute as @a[tag=oa.med_cap] run attribute @s minecraft:max_health modifier remove oa:medical_cap
tag @a remove oa.med_cap
