execute if score #quiet_was oa.tmp matches 0 run gamerule minecraft:show_death_messages false
execute if score #quiet_was oa.tmp matches 1 run gamerule minecraft:show_death_messages true
scoreboard players set #quiet_depth oa.tmp 0
