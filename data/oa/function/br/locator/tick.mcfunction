execute if score #active tdm.sys matches 1 run return 0
function oa:br/locator/all_off
execute as @a[tag=br.loc_hidden] run function oa:br/locator/restore
execute as @a[tag=br.loc_shown] run function oa:br/locator/restore
execute as @a[tag=br.loc_transmit] run function oa:br/locator/restore
