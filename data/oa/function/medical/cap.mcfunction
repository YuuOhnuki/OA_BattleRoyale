# 1.9.185: 回復量の上限（最大体力を一時的に「今の体力＋回復量」にする）は、次の tick に外す。
# 即時回復は次の tick に効くため、同じ tick に外すと上限が効かず満タンまで回復していた
attribute @s minecraft:max_health modifier remove oa:medical_cap
$attribute @s minecraft:max_health modifier add oa:medical_cap $(cap) add_value
effect give @s minecraft:instant_health 1 10 true
tag @s add oa.med_cap
schedule function oa:medical/cap_clear 2t append
