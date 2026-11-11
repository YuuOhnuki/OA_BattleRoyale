execute if data storage oa:migration {statistics_removed1924:1b} run return 0
execute in minecraft:overworld run kill @e[tag=oa.rank_holo]
execute in minecraft:overworld run kill @e[tag=oa.rank_reader]
execute in minecraft:the_nether run kill @e[tag=oa.rank_holo]
execute in minecraft:the_nether run kill @e[tag=oa.rank_reader]
execute in minecraft:the_end run kill @e[tag=oa.rank_holo]
execute in minecraft:the_end run kill @e[tag=oa.rank_reader]
tag @a remove oa.rank_recorded
scoreboard objectives remove oa.b_dd
scoreboard objectives remove oa.b_death
scoreboard objectives remove oa.b_dt
scoreboard objectives remove oa.b_jump
scoreboard objectives remove oa.b_kill
scoreboard objectives remove oa.b_run
scoreboard objectives remove oa.b_walk
scoreboard objectives remove oa.cm
scoreboard objectives remove oa.lfxd
scoreboard objectives remove oa.lfxt
scoreboard objectives remove oa.lfxw
scoreboard objectives remove oa.r_dd
scoreboard objectives remove oa.r_death
scoreboard objectives remove oa.r_dt
scoreboard objectives remove oa.r_jump
scoreboard objectives remove oa.r_kill
scoreboard objectives remove oa.r_run
scoreboard objectives remove oa.r_walk
scoreboard objectives remove oa.rank_used
scoreboard objectives remove oa.st_dd
scoreboard objectives remove oa.st_death
scoreboard objectives remove oa.st_dt
scoreboard objectives remove oa.st_jump
scoreboard objectives remove oa.st_kill
scoreboard objectives remove oa.st_move
scoreboard objectives remove oa.st_win
scoreboard objectives remove oa.stats
data remove storage oa:rank_args best
data remove storage oa:rank_args current
data remove storage oa:rank_args objective
data remove storage oa:ranking users
data remove storage oa:rank_render text
data remove storage oa:rank_register row
data remove storage oa:lobby_events stats
scoreboard players reset #rank_clock oa.tmp
scoreboard players reset #rank_kind oa.tmp
scoreboard players reset #rank_epoch oa.tmp
execute as @a run function oa:migration/statistics_books
scoreboard objectives remove oa.lfxr
data modify storage oa:migration statistics_removed1924 set value 1b
data modify storage oa:lobby_events remove_stats set value 1b
function oa:lobby/events/request
