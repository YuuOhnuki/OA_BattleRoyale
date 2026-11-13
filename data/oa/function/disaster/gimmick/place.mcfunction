execute unless data storage oa:br center run return 0
execute if score #half br.tmp matches ..5000 run return 0
scoreboard players add #gm_try br.tmp 1
data modify storage oa:disaster g set from storage oa:br center
scoreboard players operation #gm_r br.tmp = #half br.tmp
scoreboard players operation #gm_r br.tmp /= #1000 br.tmp
scoreboard players remove #gm_r br.tmp 6
execute if score #gm_r br.tmp matches ..11 run scoreboard players set #gm_r br.tmp 12
execute store result storage oa:disaster g.range int 1 run scoreboard players get #gm_r br.tmp
function oa:disaster/gimmick/place_dim with storage oa:disaster g
