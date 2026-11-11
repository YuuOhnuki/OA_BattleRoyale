scoreboard players set #event_ready oa.tmp 1
execute unless loaded ~-40 ~0 ~-40 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-40 ~0 ~-24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-40 ~0 ~-8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-40 ~0 ~8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-40 ~0 ~24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-40 ~0 ~40 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-24 ~0 ~-40 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-24 ~0 ~-24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-24 ~0 ~-8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-24 ~0 ~8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-24 ~0 ~24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-24 ~0 ~40 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-8 ~0 ~-40 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-8 ~0 ~-24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-8 ~0 ~-8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-8 ~0 ~8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-8 ~0 ~24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~-8 ~0 ~40 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~8 ~0 ~-40 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~8 ~0 ~-24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~8 ~0 ~-8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~8 ~0 ~8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~8 ~0 ~24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~8 ~0 ~40 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~24 ~0 ~-40 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~24 ~0 ~-24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~24 ~0 ~-8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~24 ~0 ~8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~24 ~0 ~24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~24 ~0 ~40 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~40 ~0 ~-40 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~40 ~0 ~-24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~40 ~0 ~-8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~40 ~0 ~8 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~40 ~0 ~24 run scoreboard players set #event_ready oa.tmp 0
execute unless loaded ~40 ~0 ~40 run scoreboard players set #event_ready oa.tmp 0
scoreboard players add #event_wait oa.tmp 1
execute if score #event_wait oa.tmp matches 100.. run return run function oa:lobby/events/release_dispatch with storage oa:lobby_events origin
execute if score #event_ready oa.tmp matches 0 run return run schedule function oa:lobby/events/wait 2t replace
function oa:lobby/events/apply
