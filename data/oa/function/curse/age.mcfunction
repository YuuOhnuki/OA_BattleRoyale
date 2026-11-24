# Per-mask cumulative equipped ticks (1.9.250: 45 s = 900 ticks). No reset on reload, rejoin, gear switch, or owner change.
$scoreboard players add #k$(serial) oa.ktimer 1
$execute if score #k$(serial) oa.ktimer matches 900.. run function oa:curse/expire
