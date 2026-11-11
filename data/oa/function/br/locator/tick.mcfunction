gamerule minecraft:locator_bar false
execute as @a[tag=br.loc_hidden] run function oa:br/locator/restore
execute as @a[tag=br.loc_shown] run function oa:br/locator/restore
execute as @a[tag=br.loc_transmit] run function oa:br/locator/restore
