scoreboard players remove #quiet_depth oa.tmp 1
execute if score #quiet_depth oa.tmp matches 0 if score #quiet_was oa.tmp matches 0 run gamerule minecraft:show_death_messages false
execute if score #quiet_depth oa.tmp matches 0 if score #quiet_was oa.tmp matches 1 run gamerule minecraft:show_death_messages true
