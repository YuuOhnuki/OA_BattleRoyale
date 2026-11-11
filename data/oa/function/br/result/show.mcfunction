tag @a[tag=oa.last_result] remove oa.last_result
execute as @a[tag=br.playing] run function oa:br/result/prep_dmg
execute as @a[tag=br.playing] run function oa:br/stats/add
tag @a[tag=br.playing] add oa.last_result
tag @a[tag=br.playing] add oa.res_view
function oa:br/result/body
tag @a remove oa.res_view
