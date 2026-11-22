scoreboard players set #inside br.flag 0
execute if entity @s[tag=tdm.player] if data storage oa:position value{dim:"oa:tdm"} run scoreboard players set #inside br.flag 1
execute if entity @s[tag=tdm.player] run return 0
execute unless data storage oa:position value{dim:"oa:br"} unless data storage oa:position value{dim:"oa:br_nether"} unless data storage oa:position value{dim:"oa:br_cave"} unless data storage oa:position value{dim:"oa:br_sky"} unless data storage oa:position value{dim:"oa:br_end"} run return 0
function oa:br/border/check_saved_pos with storage oa:position value
