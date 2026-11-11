scoreboard players set #r_pick oa.tmp 1
scoreboard players set #r_count oa.tmp 0
execute as @a[tag=!oa.radar_viewer] run function oa:curse/radar/select
