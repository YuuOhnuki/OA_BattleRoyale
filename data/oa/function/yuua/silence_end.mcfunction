scoreboard players remove #quiet_depth oa.tmp 1
execute if score #quiet_depth oa.tmp matches 0 if score #quiet_was oa.tmp matches 0 run function oa:internal/gamerule_all {rule:"show_death_messages",value:"false"}
execute if score #quiet_depth oa.tmp matches 0 if score #quiet_was oa.tmp matches 1 run function oa:internal/gamerule_all {rule:"show_death_messages",value:"true"}
