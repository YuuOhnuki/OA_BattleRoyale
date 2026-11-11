execute store result storage oa:gacha_penalty amount double 0.1 run scoreboard players get #ex_bonus oa.tmp
tag @s add oa.ex_extra
function oa:tayayuyu/penalty_damage with storage oa:gacha_penalty
tag @s remove oa.ex_extra
