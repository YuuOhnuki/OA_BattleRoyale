tag @a[tag=oa.last_result] remove oa.last_result
scoreboard players set #10 br.tmp 10
scoreboard players set #100 br.tmp 100
execute as @a[tag=br.playing,tag=br.alive] run scoreboard players operation @s br.surv = #time br.time
execute as @a[tag=br.playing] run function oa:br/result/prep_dmg
execute as @a[tag=br.playing] run function oa:ach/finish_check
execute as @a[tag=br.playing] run function oa:br/stats/add
execute as @a[tag=br.playing] run function oa:ach/stats_check
tag @a[tag=br.playing] add oa.last_result
tag @a[tag=br.playing] add oa.res_view
function oa:br/result/body
tag @a remove oa.res_view
