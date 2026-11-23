execute if entity @s[tag=tdm.player] run return run function oa:tdm/withdraw
execute if entity @s[tag=br.alive] run function oa:br/drop_inventory
# 1.9.242：降参・切断は初心者救済の対象外
tag @s add br.surrendering
function oa:br/eliminate
tag @s remove br.surrendering
