tag @s remove tdm.player
tag @s remove br.playing
tag @s remove br.alive
function oa:tdm/clean_player
execute unless entity @s[nbt={Health:0.0f}] run function oa:br/recover
