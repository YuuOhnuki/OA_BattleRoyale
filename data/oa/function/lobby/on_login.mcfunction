execute if entity @s[tag=tdm.player] run return run function oa:tdm/rejoin
scoreboard players operation @s br.login_epoch = #epoch br.login_epoch
scoreboard players add @s br.login_leave 0
scoreboard players operation @s br.login_seen = @s br.login_leave
tag @s add br.login_pending
execute if score #state br.state matches 1 if entity @s[tag=br.alive] run function oa:br/surrender

execute if entity @s[tag=br.lobby] unless score @s br.pick matches 0.. run tag @s add br.pick_rearm
execute if entity @s[tag=br.lobby] run scoreboard players add @s br.pick 0
function oa:br/team/sync
# 1.9.185: 回復の上限（medical/cap）を外す前に抜けた人の分
attribute @s minecraft:max_health modifier remove oa:medical_cap
tag @s remove oa.med_cap
