tag @s add tdm.player
tag @s add br.playing
tag @s remove br.login_pending
scoreboard players operation @s br.round = #round br.round
scoreboard players set @s tdm.kills 0
scoreboard players set @s tdm.prev 0
scoreboard players set @s tdm.points 0
execute unless score @s tdm.load matches 2..8 unless score @s tdm.load matches 10 run scoreboard players set @s tdm.load 8
function oa:test/join
function oa:itori/progress_reset
function oa:tdm/respawn
