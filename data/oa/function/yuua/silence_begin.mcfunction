scoreboard players add #quiet_depth oa.tmp 0
execute if score #quiet_depth oa.tmp matches 0 store result score #quiet_was oa.tmp run gamerule minecraft:show_death_messages
scoreboard players add #quiet_depth oa.tmp 1
gamerule minecraft:show_death_messages false
