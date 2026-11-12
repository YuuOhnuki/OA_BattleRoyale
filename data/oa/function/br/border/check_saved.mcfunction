scoreboard players set #inside br.flag 0
execute unless data storage oa:position value{dim:"oa:br"} unless data storage oa:position value{dim:"oa:br_nether"} run return 0
function oa:br/border/check_saved_pos with storage oa:position value
