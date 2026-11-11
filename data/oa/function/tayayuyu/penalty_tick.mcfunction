scoreboard players remove @s[scores={oa.gstiff=1..}] oa.gstiff 1
execute if entity @s[tag=oa.gacha_stiff,scores={oa.gstiff=0}] run function oa:tayayuyu/stiff_end
scoreboard players remove @s[scores={oa.gexpose=1..}] oa.gexpose 1
execute if entity @s[tag=oa.gacha_exposed,scores={oa.gexpose=0}] run function oa:tayayuyu/exposed_end
execute if entity @s[tag=oa.gacha_exposed] run scoreboard players operation @s oa.ex_prev = @s oa.ex_taken
execute if entity @s[tag=oa.gacha_exposed] run scoreboard players operation @s oa.ex_aprev = @s oa.ex_absorb
