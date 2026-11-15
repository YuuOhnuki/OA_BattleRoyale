execute if score #quiet_was oa.tmp matches 0 run function oa:internal/gamerule_all {rule:"show_death_messages",value:"false"}
execute if score #quiet_was oa.tmp matches 1 run function oa:internal/gamerule_all {rule:"show_death_messages",value:"true"}
scoreboard players set #quiet_depth oa.tmp 0
