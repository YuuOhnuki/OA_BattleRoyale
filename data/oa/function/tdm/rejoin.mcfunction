scoreboard players operation @s br.login_epoch = #epoch br.login_epoch
scoreboard players add @s br.login_leave 0
scoreboard players operation @s br.login_seen = @s br.login_leave
tag @s remove br.login_pending
execute if score #active tdm.sys matches 1 if score @s br.round = #round br.round run return run function oa:tdm/death
function oa:tdm/withdraw
