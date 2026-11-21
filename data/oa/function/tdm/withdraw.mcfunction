tag @s remove tdm.player
scoreboard players set @s tdm.ui 0
tag @s remove br.playing
tag @s remove br.alive
function oa:tdm/clean_player
execute unless entity @s[tag=oa.dead] run function oa:br/recover
